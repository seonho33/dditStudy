package kr.or.ddit.cmm.service;

import java.util.Collection;

import jakarta.servlet.http.Part;
import kr.or.ddit.cmm.vo.AtchFileDetailVO;
import kr.or.ddit.cmm.vo.AtchFileVO;

/**
 * 첨부파일 저장을 위한 공통 서비스용 인터페이스
 */
public interface IAtchFileService {
	
	/**
	 * 첨부파일 목록을 저장하기 위한 메서드
	 * @param parts Part객체를 담은 Collection 객체
	 * @return 첨부파일ID를 담은 AtchFileVO객체
	 */
	public AtchFileVO saveAtchFileList(Collection<Part> parts);
	
	
	/**
	 * 첨부파일 목록을 조회하기 위한 메서드
	 * @param atchFileVO 첨부파일ID를 담은 AtchFileVO객체
	 * @return 첨부파일 목록을 담은 AtchFileVO객체
	 */
	public AtchFileVO getAtchFile(AtchFileVO atchFileVO);
	
	/**
	 * 첨부파일 상세정보를 조회하기 위한 메서드
	 * @param detailVO 첨부파일ID 및 파일순번을 담은 AtchFileDetailVO객체
	 * @return 첨부파일 상세정보를 담은 AtchFileDetailVO객체
	 */
	public AtchFileDetailVO getAtchFileDetail(
			AtchFileDetailVO detailVO);
	
}
