package kr.or.ddit.board.main;

import java.util.List;
import java.util.Scanner;

import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;

import kr.or.ddit.board.Service.BoardService;
import kr.or.ddit.board.Service.IBoardService;
import kr.or.ddit.board.vo.BoardVO;

/*
	제작 순서
	jar파일 add하기
	-> sourse 파일, config안에 dp.properties와 mybatis-config.xml 작성하기(dataSource type:"pooled", property name,id...) 
	-> util 패키지의 MyBatisUtil에 한글 깨짐방지와 config에서 정보 가져와서 static 블럭으로 sqlSessionFactory 객체 만들고 getter 메서드 만들기
	-> DB 테이블을 설계해서 만들기
	-> VO 클래스와 DAO 인터페이스 작성
	-> DAO인터페이스에 맞는 DAO 파일을 만들기
	-> SQL 작성
	-> Service 인터페이스와 Service, Main 만들기(log4j2 사용해서...)
*/

public class BoardMain {
	private Scanner scan;
	private IBoardService boardService;
	
	private static final Logger RESULT_LOGGER = LogManager.getLogger("log4j.result");

	
	public BoardMain() {
		boardService = BoardService.getInstance();
		scan = new Scanner(System.in);
	}
	
	/**
	 * 메뉴 출력 메서드
	 */
	public void displayMenu() {
		System.out.println();
		System.out.println("----------------------");
		System.out.println("  === 작 업 선 택 ===");
		System.out.println("  1. 게시글 작성");
		System.out.println("  2. 게시글 삭제");
		System.out.println("  3. 게시글 수정");
		System.out.println("  4. 게시글 검색");
		System.out.println("  5. 전체 자료 출력");
		System.out.println("  6. 작업 끝.");
		System.out.println("----------------------");
		System.out.print("원하는 작업 선택 >> ");
	}
	
	/**
	 *  프로그램을 시작하는 메서드 메뉴출력+기능
	 */
	public void start() {
		int choice;
		do {
			displayMenu();
			choice = scan.nextInt();
			switch(choice) {
			case 1 :
				insertContent();
				break;
			case 2 : 
				deleteContent();
				break;
			case 3 :
				updateContent();
				break;
			case 4 :
				searchContent();
				break;
			case 5 :
				displayAllBoard();
				break;
			case 6 :
				System.out.println("프로그램 종료합니다.");
				break;
			default :
				System.out.println("번호를 다시 입력해 주십시오.");
			}
		}while(choice!=6);
	}

	private void insertContent() {	
		scan.nextLine();	//입력버퍼 비우기
		System.out.println("게시물을 작성합니다.");
		System.out.println("작성자 이름을 적어주십시오.");
		System.out.print("작성자 >>");
		String writer = scan.nextLine();
		System.out.println("게시물의 제목을 작성해주십시오.");
		System.out.print("게시물 제목 >>");
		String title = scan.nextLine();
		System.out.println("게시물 내용을 작성해주십시오.");
		System.out.print("게시물 내용 >>");
		String content = scan.nextLine();
		
		BoardVO bv = new BoardVO(title, writer, content);
		
		int cnt = boardService.addContent(bv);
		
		if(cnt>0) {
			System.out.println(title + " 작성 완료");
			RESULT_LOGGER.debug("성공");
		}else {
			System.out.println(title + " 작성 실패");
			RESULT_LOGGER.debug("실패");
		}
	}

	private void deleteContent() {
		System.out.println();
		System.out.println("삭제할 게시글번호를 입력해 주세요.");
		System.out.print("게시글 번호 >>");
		int boardNo = scan.nextInt();
		int cnt = boardService.removeContent(boardNo);
		
		if(cnt>0) {
			System.out.println(boardNo + "번 게시글 삭제완료");
			RESULT_LOGGER.debug("성공");
		}else {
			System.out.println("삭제할 게시글이 존재하지 않습니다.");
			RESULT_LOGGER.debug("실패");
		}
	}

	private void updateContent() {
		boolean isExist;
		
		int boardNo = 0;
		
			System.out.println();
			System.out.println("수정할 게시글 번호를 입력해주세요");
			System.out.print("게시글 번호 >>");
			boardNo = scan.nextInt();
			isExist = boardService.checkBoard(boardNo);
			if(!isExist) {
				System.out.println("게시글 번호가 "+boardNo+"인 게시글은 존재하지 않습니다");
				return;
			}
			System.out.println("작성자 이름을 적어주십시오.");
			System.out.print("작성자 >>");
			String writer = scan.next();
			System.out.println("게시물의 제목을 작성해주십시오.");
			System.out.print("게시물 제목 >>");
			String title = scan.next();
			System.out.println("게시물 내용을 작성해주십시오.");
			System.out.print("게시물 내용 >>");
			String content = scan.next();
			/////////////////////////////////
			BoardVO bv = new BoardVO(title, writer, content);
			bv.setBoardNo(boardNo);
			
			int cnt = boardService.modifyContent(bv);
			
			if(cnt>0) {
				System.out.println("게시물 번호가 " +boardNo+"인 게시물 수정 완료");
				RESULT_LOGGER.debug("성공");
			}else {
				System.out.println("수정작업 실패");
				RESULT_LOGGER.debug("실패");
			}
	}

	private void searchContent() {
		scan.nextLine();	//입력버퍼 비우기
		System.out.println();
		System.out.println("검색할 게시물 번호를 입력해 주세요 ");
		System.out.print("게시물번호 >> ");
		String boardNoStr = scan.nextLine().trim();
		int boardNo = 0;
		if(boardNoStr != null && boardNoStr != "") {
			try{
				boardNo=Integer.parseInt(boardNoStr);
			}catch(Exception e) {
				e.printStackTrace();
			}
		}
		System.out.print("작성자 이름 >>");
		String writer = scan.nextLine().trim(); 
		System.out.print("게시물제목 >> ");
		String title = scan.nextLine().trim();
		
		String content = "";
		
		BoardVO bv = new BoardVO(title, writer, content);
		bv.setBoardNo(boardNo);
		
		List<BoardVO> boardList = boardService.searchContent(bv);
		
		System.out.println();
		System.out.println("---------------------------------------------------------------");
		System.out.println("작성날짜\t\t게시물번호\t작성자\t제목\t\t내용");
		System.out.println("---------------------------------------------------------------");
		
		if(boardList.size() == 0) {
			System.out.println("조회된 게시물이 없습니다.");
		}else {
			for(BoardVO bv2 : boardList) {
			
			System.out.println(bv2.getBoardDate() +"\t" + bv2.getBoardNo() +"\t"+ bv2.getWriter() +"\t"+bv2.getTitle()
								+"\t" + bv2.getContent());
			}
		}
		System.out.println("---------------------------------------------------------------");
		System.out.println("전체 게시물 조회 완료...");
	}

	private void displayAllBoard() {
		System.out.println();
		System.out.println("---------------------------------------------------------------");
		System.out.println("작성날짜\t\t게시물번호\t작성자\t제목\t\t내용");
		System.out.println("---------------------------------------------------------------");
		
		List<BoardVO> boardList = boardService.displayAllBoard();
		
		if(boardList.size() == 0) {
			System.out.println("조회된 게시물이 없습니다.");
		}else {
			for(BoardVO bv : boardList) {
			
				System.out.println(bv.getBoardDate() +"\t" + bv.getBoardNo() +"\t"+ bv.getWriter() +"\t"+bv.getTitle()
				+"\t" + bv.getContent());
			}
		}
		System.out.println("---------------------------------------------------------------");
		System.out.println("전체 게시물 조회 완료...");
		}
	public static void main(String[] args) {
		BoardMain boardObj = new BoardMain();
		boardObj.start();
	}
}