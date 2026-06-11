package kr.or.ddit.cmm.dao;

import kr.or.ddit.cmm.vo.AtchFileDetailVO;
import kr.or.ddit.cmm.vo.AtchFileVO;

public interface IAtchFileDao {
	
	/**
	 * 기본 첨부파일 정보 저장
	 * @param atchFileVO
	 * @return 저장 성공하면 1, 실패하면 0 반환됨.
	 */
	public int insertAtchFile(AtchFileVO atchFileVO);
	
	/**
	 * 상세 첨부파일 정보 저장
	 * @param detailVO 상세 첨부파일 정보를 담은 VO객체
	 * @return 저장 성공하면 1, 실패하면 0 반환됨.
	 */
	public int insertAtchFileDetail(AtchFileDetailVO detailVO);
	
	/**
	 * 첨부파일 목록 조회하기
	 * @param atchFileVO
	 * @return
	 */
	public AtchFileVO getAtchFile(AtchFileVO atchFileVO);
	
	/**
	 * 세부 첨부파일 정보 조회
	 * @param detailVO 검색할 첨부파일의 파일ID 및 파일순번을 담은 객체
	 * @return 
	 */
	public AtchFileDetailVO 
		getAtchFileDetail(AtchFileDetailVO detailVO);
	
}
