package kr.or.ddit.member;
import java.util.List;
import java.util.Scanner;

import kr.or.ddit.member.dao.MemberDaoImplForJDBC2;
import kr.or.ddit.member.vo.MemberVO;

/*
	회원정보를 관리하는 프로그램을 작성하는데 
	아래의 메뉴를 모두 구현하시오. (CRUD기능 구현하기)
	(DB의 MYMEMBER테이블을 이용하여 작업한다.)
	
	* 자료 삭제는 회원ID를 입력 받아서 삭제한다.
	
	예시메뉴)
	----------------------
		== 작업 선택 ==
		1. 자료 입력			---> insert
		2. 자료 삭제			---> delete
		3. 자료 수정			---> update
		4. 전체 자료 출력	---> select
		5. 작업 끝.
	----------------------
	 
	   
// 회원관리 프로그램 테이블 생성 스크립트 
create table mymember(
    mem_id varchar2(8) not null,  -- 회원ID
    mem_name varchar2(100) not null, -- 이름
    mem_tel varchar2(50) not null, -- 전화번호
    mem_addr varchar2(128),    -- 주소
    reg_dt DATE DEFAULT sysdate, -- 등록일
    CONSTRAINT MYMEMBER_PK PRIMARY KEY (mem_id)
);

*/
public class MemberinfoMain2 {
	
	private Scanner scan = new Scanner(System.in); 
	
	/**
	 * 메뉴를 출력하는 메서드
	 */
	public void displayMenu(){
		System.out.println();
		System.out.println("----------------------");
		System.out.println("  === 작 업 선 택 ===");
		System.out.println("  1. 자료 입력");
		System.out.println("  2. 자료 삭제");
		System.out.println("  3. 자료 수정");
		System.out.println("  4. 전체 자료 출력");
		System.out.println("  5. 작업 끝.");
		System.out.println("----------------------");
		System.out.print("원하는 작업 선택 >> ");
	}
	
	/**
	 * 프로그램 시작메서드
	 */
	MemberDaoImplForJDBC2 dao = new MemberDaoImplForJDBC2();
	String memId;
	boolean isExist = false;
	int cnt =0;
	
	public void start(){
		
		int choice;
		do{
			displayMenu(); //메뉴 출력
			choice = scan.nextInt(); // 메뉴번호 입력받기
			switch(choice){
				case 1 :  // 자료 입력
					insertV();
					break;
					
				case 2 :  // 자료 삭제
					deletV();
					break;
					
				case 3 :  // 자료 수정
					updateV();
					break;
					
				case 4 :  // 전체 자료 출력
					getAllMemberV();
					break;
				case 5 :  // 작업 끝
					System.out.println("작업을 마칩니다.");
					break;
				default :
					System.out.println("번호를 잘못 입력했습니다. 다시입력하세요");
			}
		}while(choice!=5);
	}

	private void getAllMemberV() {
		
		List<MemberVO> memdata = dao.getAllMember();
		
		for(MemberVO mv : memdata) {
			System.out.println(mv.getMemId() +"\t"+ mv.getRegDt() +"\t"+mv.getMemName() + "\t" + mv.getMemTel() + "\t" + mv.getMemAddr());
		}
		
	}

	public static void main(String[] args) {
		MemberinfoMain2 memObj = new MemberinfoMain2();
		memObj.start();
	}
	
	public void insertV() {
		do {
			System.out.println();
			System.out.println("추가할 회원정보를 입력해 주세요.");
			System.out.print("회원ID >>");
			memId = scan.next();
			isExist=dao.checkMember(memId);
			if(isExist) {
				System.out.println("회원ID가 " +memId+"인 회원은 이미 존재합니다.");
				System.out.println("다시 입력해 주세요");
			}
			}while(isExist);
		
		System.out.print("회원이름 >>");
		String memName = scan.next();
		
		System.out.print("회원 전화번호 >>");
		String memTel = scan.next();
		
		scan.nextLine(); // 입력버퍼에 남아있는 엔터키 제거용
		System.out.print("회원 주소 >>");
		String memAddr = scan.nextLine();
		
		cnt = dao.insertMember(new MemberVO(memId,memName,memTel,memAddr));
		
		if(cnt>0){
			System.out.println(memId + "인 회원정보 추가작업 성공");
		}else {
			System.out.println(memId + "인 회원정보 추가정보 실패!!");
		}
	}
	
	public void deletV() {
		System.out.println();
		System.out.println("삭제할 회원정보를 입력해 주세요.");
		System.out.print("회원ID >>");
		
		memId = scan.next();
		
		if(dao.deletMember(memId)>0) {
			System.out.println("회원정보 삭제 성공");
		}else {
			System.out.println("삭제할 회원정보가 없습니다.");
		}
	}
	
	public void updateV() {
		do {
			System.out.println();
			System.out.println("수정할 회원정보를 입력해 주세요.");
			System.out.print("회원ID >>");
			memId = scan.next();
			isExist = dao.checkMember(memId);
			if(!isExist) {
				System.out.println("회원ID가 " +memId+"인 회원은 존재하지 않습니다.");
				System.out.println("다시 입력해 주세요");
			}
			}while(!isExist);
		
			System.out.print("회원이름 >>");
			String memName = scan.next();
		
			System.out.print("회원 전화번호 >>");
			String memTel = scan.next();
		
			scan.nextLine(); // 입력버퍼에 남아있는 엔터키 제거용
			System.out.print("회원 주소 >>");
			String memAddr = scan.nextLine();
			
			cnt = dao.updateMember(new MemberVO(memId,memName,memTel,memAddr));
			
			if(cnt>0) {
				System.out.println(memId+ "의 회원정보 수정 작업 성공!!");
			}else {
				System.out.println(memId+"의 회원정보 수정 작업 실패!!");
			}
	}
}