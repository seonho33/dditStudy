package kr.or.ddit.board.dao;

import java.util.List;

import kr.or.ddit.board.vo.BoardVO;

public interface IBoardDao {
	/*
	필요한 기능
	전체 목록 출력, 새글작성, 수정, 삭제, 검색 
	*/
	
	/**
	 * 게시글을 추가하는 메서드
	 * @param bv 게시글 정보를 담은 BoardVO 객체
	 * @return 게시글 등록에 성공하면 1, 실패하면 0반환
	 */
	public int insertContent(BoardVO bv);
	
	/**
	 * 게시글을 삭제하는 메서드
	 * @param no 게시글테이블의 기본키(시퀸스)의 정보
	 * @return 삭제성공하면 1, 실패하면 0반환
	 */
	public int deleteContent(int no);
	
	/**
	 * 게시글을 수정하기위한 메서드
	 * @param no 게시글 테이블의 기본키(시퀸스)의 정보
	 * @return 수정성공하면 1, 실패하면 0 반환
	 */
	public int updateContent(BoardVO bv);
	
	/**
	 * 게시글 존재여부를 확인하기위한 메서드
	 * @param no 존재여부 확인을 위한 게시글번호
	 * @return 게시글정보가 존재하면 true, 존재하지 않으면 false 반환함
	 */
	public boolean checkBoard(int no);
	
	/**
	 * 검색조건에 해당하는 게시글을 검색하기위한 메서드
	 * @param bv 검색조건을 담은 Board 객체
	 * @return 검색된 게시글 정보를 담은 list 객체
	 */
	public List<BoardVO> searchContent(BoardVO bv);

	/**
	 * DB에 존재하는 모든 게시글을 확인하기위한 메서드
	 * @return 모든 게시글정보를 담은 List 객체 반환
	 */
	public List<BoardVO> getAllContent();
}