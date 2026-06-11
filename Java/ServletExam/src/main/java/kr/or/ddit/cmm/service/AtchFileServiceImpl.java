package kr.or.ddit.cmm.service;

import java.io.File;
import java.io.IOException;
import java.util.Collection;
import java.util.UUID;

import jakarta.servlet.http.Part;
import kr.or.ddit.cmm.dao.AtchFileDaoImpl;
import kr.or.ddit.cmm.dao.IAtchFileDao;
import kr.or.ddit.cmm.vo.AtchFileDetailVO;
import kr.or.ddit.cmm.vo.AtchFileVO;

public class AtchFileServiceImpl implements IAtchFileService {
	
	private static final String UPLOAD_DIR = "d:/D_Other/upload_files";
	
	private IAtchFileDao atchFileDao;
	
	private static IAtchFileService fileService = 
											new AtchFileServiceImpl();
	
	private AtchFileServiceImpl() {
		atchFileDao = AtchFileDaoImpl.getInstance();
	}
	
	public static IAtchFileService getInstance() {
		return fileService;
	}

	@Override
	public AtchFileVO saveAtchFileList(Collection<Part> parts) {
		
		File uploadDir = new File(UPLOAD_DIR);
		if(!uploadDir.exists()) {
			uploadDir.mkdir(); // 디렉토리 생성하기
		}
		
		AtchFileVO atchFileVO = null;
		
		boolean isFirstFile = true;  // 첫번째 파일 여부
		
		for(Part part : parts) {
			
			String fileName = part.getSubmittedFileName();
			
			if(fileName != null && !fileName.equals("")) {
				// 해당 Part 데이터가 첨부파일인 경우...
				
				if(isFirstFile) { // 첫번째 첨부파일인 경우...
					
					// 파일 기본정보 저장...
					atchFileVO = new AtchFileVO();
					int cnt = atchFileDao.insertAtchFile(atchFileVO);
					isFirstFile = false;
				}
				
				String orignFileName = fileName; // 원본파일명
				long fileSize = part.getSize(); // 파일크기(bytes)
				String saveFileName = 
				UUID.randomUUID().toString().replace("-", "");
				String saveFilePath = UPLOAD_DIR + "/" + saveFileName;
				
				// 확장명 추출
				String fileExtension = 
					orignFileName.lastIndexOf(".") < 0 ? 
						"" : orignFileName.substring(
							 orignFileName.lastIndexOf(".") + 1).toUpperCase(); 
				
				// 업로드 파일 저장하기
				try {
					part.write(saveFilePath);
					part.delete(); // 임시 업로드 파일 삭제하기
				} catch (IOException e) {
					e.printStackTrace();
				}
				
				AtchFileDetailVO detailVO = new AtchFileDetailVO();
				detailVO.setAtchFileId(atchFileVO.getAtchFileId());
				detailVO.setOrignlFileNm(orignFileName);
				detailVO.setStreFileNm(saveFileName);
				detailVO.setFileStreCours(saveFilePath);
				detailVO.setFileExtsn(fileExtension);
				detailVO.setFileSize(fileSize);
				
				// 첨부파일 세부정보 저장하기
				atchFileDao.insertAtchFileDetail(detailVO);
			}
		}
		
		return atchFileVO;
	}

	@Override
	public AtchFileVO getAtchFile(AtchFileVO atchFileVO) {
		
		return atchFileDao.getAtchFile(atchFileVO);
	}

	@Override
	public AtchFileDetailVO getAtchFileDetail(AtchFileDetailVO detailVO) {
		
		return atchFileDao.getAtchFileDetail(detailVO);
	}
	
	public static void main(String[] args) {
		String fileName = UUID.randomUUID().toString().replace("-", "");
		System.out.println(fileName);
		
		String orignFileName = "coffee.jpg";
		
		String fileExtension = 
				orignFileName.lastIndexOf(".") < 0 ? 
					"" : orignFileName.substring(
						 orignFileName.lastIndexOf(".") + 1).toUpperCase();
		
		System.out.println(fileExtension);
	}

}
