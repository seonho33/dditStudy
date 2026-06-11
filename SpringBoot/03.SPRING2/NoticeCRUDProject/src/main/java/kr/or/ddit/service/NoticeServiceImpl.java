package kr.or.ddit.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.configurationprocessor.json.JSONArray;
import org.springframework.boot.configurationprocessor.json.JSONObject;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.ServiceResult;
import kr.or.ddit.controller.TelegramSendController;
import kr.or.ddit.exception.CustomFileSizeException;
import kr.or.ddit.mapper.ICommentMapper;
import kr.or.ddit.mapper.ILoginMapper;
import kr.or.ddit.mapper.INoticeMapper;
import kr.or.ddit.mapper.IProfileMapper;
import kr.or.ddit.vo.ApiResult;
import kr.or.ddit.vo.AptVO;
import kr.or.ddit.vo.LawDongVO;
import kr.or.ddit.vo.NoticeCommentVO;
import kr.or.ddit.vo.NoticeFileVO;
import kr.or.ddit.vo.NoticeMemberVO;
import kr.or.ddit.vo.NoticeVO;
import kr.or.ddit.vo.PaginationInfoVO;
import lombok.extern.slf4j.Slf4j;

@Service
@Slf4j
public class NoticeServiceImpl implements INoticeService {
	private static final String SERVICE_KEY = "279564b17283c0863ff904cbfee96deb15c26cd426ec71fe7c5966a865f64f2f";
	
	@Autowired
	private IProfileMapper profileMapper;
	
	@Autowired
	private TelegramSendController tst;
	
	@Autowired
	private ICommentMapper commentMapper;
	
	@Value("${kr.or.ddit.upload.path}")
	private String uploadPath;
	
	private final long MAX_FILE_SIZE = 2*1024*1024; //2MB
	
	@Autowired
	private INoticeMapper noticeMapper;
	
	@Autowired
	private ILoginMapper loginMapper;

	@Override
	public ServiceResult idCheck(String memId) {
		ServiceResult result = null;
		NoticeMemberVO member = loginMapper.idCheck(memId);
		if(member != null) {
			result = ServiceResult.EXIST;
		}else {
			result = ServiceResult.NOTEXIST;
		}
		
		return result;
	}

	@Override
	public ServiceResult signup(NoticeMemberVO memberVO) {
		ServiceResult result = null;
		
		String path = uploadPath + "profile";
		
		File file = new File(path);
		
		if(!file.exists()) {
			file.mkdirs();
		}
		
		String proFileImg = "";	//회원정보에 추가될 프로필 이미지 경로
		try {
			MultipartFile profileImgFile=memberVO.getImgFile();
			if(profileImgFile != null &&
					profileImgFile.getOriginalFilename() != null &&
						!profileImgFile.getOriginalFilename().equals("")) {
				String fileName = UUID.randomUUID().toString();
				fileName +="_"+profileImgFile.getOriginalFilename();
				path += "/" + fileName;
				profileImgFile.transferTo(new File(path));
				proFileImg = "/upload/profile/" + fileName;
			}
			
			memberVO.setMemProfileimg(proFileImg);
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		int status =  loginMapper.signup(memberVO);
		
		if(status>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		
		return result;
	}

	@Override
	public NoticeMemberVO loginCheck(NoticeMemberVO member) {
		
		return loginMapper.loginCheck(member);
	}

	@Override
	public ServiceResult insertNotice(NoticeVO noticeVO) {
		
		// 1. Notice 테이블에 게시글 정보를 등록
		// 2. 등록 성공 또는 실패 여부에 따라 결과를 리턴(ServiceResult)
		// 3. 등록 성공 시, 물리적인 파일들을 업로드
		// 4. 등록 성공 시, Telegram Bot API 실시간 알림
		ServiceResult result = null;
		int status = noticeMapper.insertNotice(noticeVO);
		if(status>0) {
			List<NoticeFileVO> noticeFileList = noticeVO.getNoticeFileList();
			try {
				noticeFileUpload(noticeFileList,noticeVO.getBoNo());
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			try {
				tst.sendGet("홍길동", noticeVO.getBoTitle(), "notice");
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	private void noticeFileUpload(List<NoticeFileVO> noticeFileList, int boNo) throws IllegalStateException, IOException {
		if(noticeFileList !=null&&noticeFileList.size()>0) {
			for(NoticeFileVO noticeFileVO : noticeFileList) {
				if(noticeFileVO.getItem().isEmpty()) {
					throw new IllegalArgumentException("업로드 할 파일이 존재하지 않습니다");
				}
				
				// 기본적으로 application.properties에서 max-file-size와 같은 설정으로
				// 내가 업로드한 파일의 사이즈가 설정 크기보다 큰 경우, 예외처리를
				// 할 수 있습니다.
				// 이때 발생하는 예외가 MaxUploadSizeExceededException입니다.
				// 해당 에러에 의한 예외처리를 진행하다보면 설정 크기보다 큰 파일에
				// 의해 해당 예외를 인터셉트 할 순 있지만, Spring DispatcherServlet
				// 단계까지 다다르지 않고, Servlet Contailer에서 차단 당하기 때문에
				// 브라우저는 ERR_CONNECTION_RESET과 같은 화면을 제공합니다.
				// 사용자 입장에서는 시스템에 의해서 뭔가 크게 잘못됨을 감지하고 다시 URL을
				// 입력하거나, 원래 해야했던 프로세스를 다시 이행하게 되는 것입니다.
				// 그렇다면 예외처리를 어떻게하면 좋을까요? 파일 사이즈에 대해 발생하고있는 예외는
				// 중간 Connection 이 끊어지지않고 DispatcherServlet 영역까지는 넘어오되, 서비스 로직에서
				// 파일이 가지고있는 크기 제한 로직을 통해 커스텀에러를 발생시키는 방법입니다.
				// 커스텀 에러를 통해서 @ControllerAdvice 어노테이션으로 설정한 ExceptionHandler를
				// 동작시켜 사용자에게 우리가 보여줄 에러 페이지를 커스텀으로 제공하는 것입니다.
				if(noticeFileVO.getItem().getSize() > MAX_FILE_SIZE) {
					throw new CustomFileSizeException("2MB 이상의 파일은 업로드 할 수 없습니다!");
				}
				
				String saveName = UUID.randomUUID().toString() + "_" + noticeFileVO.getFileName().replaceAll(" ","_");
				String saveLocate = uploadPath + "notice/" + boNo;
				File file = new File(saveLocate);
				if(!file.exists()) {
					file.mkdirs();
				}
				
				saveLocate +="/" + saveName;
				
				noticeFileVO.setBoNo(boNo);
				noticeFileVO.setFileSavepath(saveLocate);
				noticeMapper.insertNoticeFile(noticeFileVO);
				
				File saveFile = new File(saveLocate);
				noticeFileVO.getItem().transferTo(saveFile);	//파일 복사
			}
		}
	}

	@Override
	public NoticeVO selectNotice(int boNo) {
		noticeMapper.incrementHit(boNo);
		
		return noticeMapper.selectNotice(boNo);
	}

	@Override
	public NoticeFileVO noticeDownload(int fileNo) {
		NoticeFileVO noticeFileVO = noticeMapper.noticeDownload(fileNo);
		
		if(noticeFileVO == null) {
			throw new RuntimeException();
		}
		noticeMapper.incrementNoticeDownCount(fileNo);	//다운로드 횟수증가
		
		return noticeFileVO;
	}

	@Override
	public ServiceResult noticeInsertComment(NoticeCommentVO noticeCommentVO) {

		ServiceResult result = null;
		
		int status = commentMapper.noticeInsertComment(noticeCommentVO);
		if(status>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public List<NoticeCommentVO> selectNoticeCommentList(int integer) {
		return commentMapper.selectNoticeCommentList(integer);
	}

	@Override
	public ServiceResult noticeInsertSubComment(NoticeCommentVO noticeCommentVO) {

		ServiceResult result = null;
		
		int status = commentMapper.noticeInsertSubComment(noticeCommentVO);
		if(status>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult noticeUpdateComment(NoticeCommentVO noticeCommentVO) {
		ServiceResult result = null;
		
		int status = commentMapper.noticeUpdateComment(noticeCommentVO);
		if(status>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult noticeDeleteComment(int cmtNo) {
		ServiceResult result = null;
		
		int status = commentMapper.noticeDeleteComment(cmtNo);
		if(status>0) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult updateNotice(NoticeVO noticeVO) {
		ServiceResult result = null;
		
		// 1. 일반적인 데이터 수정
		int status = noticeMapper.updateNotice(noticeVO);
		if(status>0) {
			// 2. 새롭게 추가된 파일들을 업로드
			List<NoticeFileVO> noticeFileList = noticeVO.getNoticeFileList();
			try {
				noticeFileUpload(noticeFileList,noticeVO.getBoNo());
			} catch (Exception e) {
				e.printStackTrace();
			}
			// 3. 기존에 업로드 된 파일들 중, 삭제 처리된 파일을 삭제(데이터, 파일)
			// 기존에 등록되어 있는 파일 목록들 중, 수정하기 위해서 'X'버튼을 눌러 삭제 처리로 넘겨준 파일 번호
			Integer[] delFileNo = noticeVO.getDelFileNo();
			if(delFileNo != null) {
				for(int i=0;i<delFileNo.length;i++) {
					NoticeFileVO noticeFileVO = noticeMapper.selectNoticeFile(delFileNo[i]);
					// 파일 번호에 해당하는 파일 데이터를 삭제!
					noticeMapper.deleteNoticeFile(delFileNo[i]);
					
					File file = new File(noticeFileVO.getFileSavepath());
					file.delete();		// 기존의 파일이 업로드 되어있던 경로에서 삭제
				}
			}
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
		
		return result;
	}

	@Override
	public ServiceResult deleteNotice(int boNo) {
		ServiceResult result = null;
		
		// 공지사항 파일 삭제를 위한 준비(파일 적용시)
		// 게시글 번호에 해당하는 공지사항 게시글 정보 가져오기(파일정보들을 가져오기 위함)
		NoticeVO noticeVO = noticeMapper.selectNotice(boNo);
		noticeMapper.deleteNoticeFileByNo(boNo);	// 게시글 번호에 해당하는 파일 데이터 삭제
		noticeMapper.deleteNoticeComment(boNo);		// 게시글 번호에 해당하는 댓글 데이터 삭제
		
		int status = noticeMapper.deleteNotice(boNo);
		
		if(status >0) {
			// 공지사항 게시글 정보에서 파일 목록 가져오기
			List<NoticeFileVO> noticeFileList = noticeVO.getNoticeFileList();
			try {
				if(noticeFileList != null && noticeFileList.size()>0) {
					NoticeFileVO noticeFileVO = noticeFileList.get(0);
					String fileSavePath = noticeFileVO.getFileSavepath();
					int pathIndex = fileSavePath.lastIndexOf("/");	// 파일명 제외 전 경로 index
					String path = fileSavePath.substring(0,pathIndex+1);
					
					//폴더 및 파일 삭제
					deleteFolder(path);
				}
			}catch(Exception e) {
				e.printStackTrace();
			}
			
			result = ServiceResult.OK;
		}else{
			result = ServiceResult.FAILED;
		}
		return result;
	}

	private void deleteFolder(String path) {
		File folder = new File(path);
		try {
			if(folder.exists()) {
				File[] fileList = folder.listFiles();	// 폴더 안에 있는 파일들의 목록을 가져온다
				
				for(int i =0;i<fileList.length;i++) {
					if(fileList[i].isFile()) {			// 폴더안에 있는 파일이 파일일 때
						//파일일 경우 삭제
						fileList[i].delete();
					}else {
						//폴더일 경우
						deleteFolder(fileList[i].getPath());
					}
				}
				folder.delete();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		
	}

	@Override
	public int selectNoticeCount(PaginationInfoVO<NoticeVO> pagingVO) {
		return noticeMapper.selectNoticeCount(pagingVO);
	}

	@Override
	public List<NoticeVO> selectNoticeList(PaginationInfoVO<NoticeVO> pagingVO) {
		return noticeMapper.selectNoticeList(pagingVO);
	}

	@Override
	public String idForgetProcess(NoticeMemberVO member) {
		return loginMapper.idForgetProcess(member);
	}

	@Override
	public String pwForgetProcess(NoticeMemberVO member) {
		return loginMapper.pwForgetProcess(member);
	}

	@Override
	public NoticeMemberVO selectMember(String memId) {
		return profileMapper.selectMember(memId);
	}

	@Override
	public ServiceResult profileUpdate(NoticeMemberVO memberVO) {
		ServiceResult result = null;
		
		String path = uploadPath + "profile";
		File file = new File(path);
		if(file.exists()) {
			file.mkdirs();
		}
		
		String profileImg = "";
		try {
		 	MultipartFile profileImgFile = memberVO.getImgFile();
		 	if(profileImgFile !=null && profileImgFile.getOriginalFilename() !=null && !profileImgFile.getOriginalFilename().equals("")) {
		 		String fileName = UUID.randomUUID().toString() + "_" + profileImgFile.getOriginalFilename();
		 		path += "/" + fileName;
		 		profileImgFile.transferTo(new File(path));
		 		profileImg = "/upload/profile/" + fileName;
		 	}
		 	memberVO.setMemProfileimg(profileImg);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		int status = profileMapper.profileUpdate(memberVO);
		if(status > 0 ) {
			result = ServiceResult.OK;
		}else {
			result = ServiceResult.FAILED;
		}
			
		return result;
	}

    @Override
    public void collectLawDong() throws Exception {

        int page = 1;
        int totalPage = 1;
        int perPage = 1000;

        do {
            String url = "https://api.odcloud.kr/api/15063424/v1/uddi:5176efd5-da6e-42a0-b2cf-8512f74503ea"
                    + "?page=" + page
                    + "&perPage=" + perPage
                    + "&serviceKey=" + SERVICE_KEY;

            String result = request(url);

            JSONObject json = new JSONObject(result);

            int totalCount = json.getInt("totalCount");
            totalPage = (int) Math.ceil(totalCount / (double) perPage);

            JSONArray dataArr = json.getJSONArray("data");

            saveData(dataArr);

            log.info("page: {}", page);

            page++;

            Thread.sleep(500);

        } while (page <= totalPage);
    }

    private void saveData(JSONArray arr) throws Exception {

        for (int i = 0; i < arr.length(); i++) {

            JSONObject item = arr.getJSONObject(i);

            LawDongVO vo = new LawDongVO();

            vo.setLawdCd(item.getString("법정동코드"));
            vo.setSidoNm(item.getString("시도명"));
            vo.setSigunguNm(item.getString("시군구명"));
            vo.setDongNm(item.getString("읍면동명"));
            vo.setRiNm(item.optString("리명"));

            String useYn = "Y";

            if (item.has("폐지여부")) {
                String val = item.optString("폐지여부");
                useYn = val.equals("존재") ? "Y" : "N";
            }   
            
            
            vo.setUseYn(useYn);

            noticeMapper.mergeLawDong(vo);
        }
    }

    private String request(String urlStr) throws Exception {
        HttpURLConnection conn = (HttpURLConnection) new URL(urlStr).openConnection();
        conn.setRequestMethod("GET");

        BufferedReader br = new BufferedReader(
                new InputStreamReader(conn.getInputStream(), "UTF-8"));

        StringBuilder sb = new StringBuilder();
        String line;

        while ((line = br.readLine()) != null) {
            sb.append(line);
        }

        br.close();
        conn.disconnect();

        return sb.toString();
    }

    
    
    @Override
    public void collectAptData() {

        List<String> dongCodes = noticeMapper.selectAllDongCodes();

        for (String bjdCode : dongCodes) {

            int pageNo = 1;
            int totalPage = 1;

            do {
                ApiResult result = callApi(bjdCode, pageNo);

                for (AptVO apt : result.getList()) {
                    noticeMapper.mergeApt(apt);
                }

                totalPage = result.getTotalPage();
                pageNo++;

                try { Thread.sleep(500); } catch (Exception e) {}

                log.info("동코드: {}, page: {}", bjdCode, pageNo);

            } while (pageNo <= totalPage);
        }
    }

    private ApiResult callApi(String bjdCode, int pageNo) {
    	
        try {
            String serviceKey = "279564b17283c0863ff904cbfee96deb15c26cd426ec71fe7c5966a865f64f2f"; // 디코딩된 키 사용

            String urlStr =
                "https://apis.data.go.kr/1613000/AptListService3/getLegaldongAptList3" +
                "?serviceKey=" + serviceKey +
                "&pageNo=" + pageNo +
                "&numOfRows=50" +
                "&bjdCode=" + bjdCode +
                "&_type=json";

            URL url = new URL(urlStr);
            HttpURLConnection conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod("GET");

            BufferedReader br;

            if (conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
                br = new BufferedReader(new InputStreamReader(conn.getInputStream(), "UTF-8"));
            } else {
                br = new BufferedReader(new InputStreamReader(conn.getErrorStream(), "UTF-8"));
            }

            StringBuilder sb = new StringBuilder();
            String line;

            while ((line = br.readLine()) != null) {
                sb.append(line);
            }

            br.close();
            conn.disconnect();

            String resultStr = sb.toString();

            if (resultStr == null || !resultStr.trim().startsWith("{")) {
                log.error("API 응답 이상 (동코드: {}, page: {}): {}", bjdCode, pageNo, resultStr);
                return new ApiResult(new ArrayList<>(), pageNo); // 페이지 유지
            }
            
            JSONObject json = new JSONObject(sb.toString());
            JSONObject body = json.getJSONObject("response").getJSONObject("body");

            JSONArray items = body.getJSONArray("items");

            int totalCount = body.getInt("totalCount");
            int numOfRows = body.getInt("numOfRows");
            int totalPage = (int) Math.ceil(totalCount / (double) numOfRows);

            if (items.length() == 0) {
                log.info("아파트 없음 - 동코드: {}", bjdCode);
                return new ApiResult(new ArrayList<>(), totalPage);
            }
            
            List<AptVO> list = new ArrayList<>();

            for (int i = 0; i < items.length(); i++) {

                JSONObject item = items.getJSONObject(i);

                AptVO apt = new AptVO();
                apt.setAptId(item.getString("kaptCode"));
                apt.setAptName(item.getString("kaptName"));
                apt.setLawdCd(item.getString("bjdCode"));
                apt.setSidoNm(item.optString("as1"));
                apt.setSigunguNm(item.optString("as2"));
                apt.setDongNm(item.optString("as3"));
                apt.setDetailAddr(item.optString("as4"));

                list.add(apt);
            }

            return new ApiResult(list, totalPage);

        } catch (Exception e) {
            e.printStackTrace();
            return new ApiResult(new ArrayList<>(), 1);
        }
    }
    
    
    
    
}
