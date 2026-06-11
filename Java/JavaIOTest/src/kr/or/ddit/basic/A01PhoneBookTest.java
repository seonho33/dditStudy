package kr.or.ddit.basic;
import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.EOFException;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Scanner;
import java.util.Set;

/*
문제) 이름, 주소, 전화번호 속성을 갖는 Phone클래스를 만들고, 이 Phone클래스를 이용하여 
	  전화번호 정보를 관리하는 프로그램을 완성하시오.
	  이 프로그램에는 전화번호를 등록, 수정, 삭제, 검색, 전체출력하는 기능이 있다.
	  
	  전체의 전화번호 정보는 Map을 이용하여 관리한다.
	  (key는 '이름'으로 하고 value는 'Phone클래스의 인스턴스'로 한다.)


실행예시)
===============================================
   전화번호 관리 프로그램(파일로 저장되지 않음)
===============================================

  메뉴를 선택하세요.
  1. 전화번호 등록
  2. 전화번호 수정
  3. 전화번호 삭제
  4. 전화번호 검색
  5. 전화번호 전체 출력
  0. 프로그램 종료
  번호입력 >> 1  <-- 직접 입력
  
  새롭게 등록할 전화번호 정보를 입력하세요.
  이름 >> 홍길동  <-- 직접 입력
  전화번호 >> 010-1234-5678  <-- 직접 입력
  주소 >> 대전시 중구 대흥동 111  <-- 직접 입력
  
  메뉴를 선택하세요.
  1. 전화번호 등록
  2. 전화번호 수정
  3. 전화번호 삭제
  4. 전화번호 검색
  5. 전화번호 전체 출력
  0. 프로그램 종료
  번호입력 >> 5  <-- 직접 입력
  
  =======================================
  번호   이름       전화번호         주소
  =======================================
   1    홍길동   010-1234-5678    대전시
   ~~~~~
   
  =======================================
  출력완료...
  
  메뉴를 선택하세요.
  1. 전화번호 등록
  2. 전화번호 수정
  3. 전화번호 삭제
  4. 전화번호 검색
  5. 전화번호 전체 출력
  0. 프로그램 종료
  번호입력 >> 0  <-- 직접 입력
  
  프로그램을 종료합니다...
  
  +++++ 전화번호 전체출력할때 이름순으로 정렬해보기....
  
*/
public class A01PhoneBookTest {
	private Scanner scanner;						 
	private Map<String, Phone> phoneBookMap;						
		
	public A01PhoneBookTest() {
		scanner = new Scanner(System.in);
		phoneBookMap = new HashMap<String, Phone>();				
	}
		
	public static void main(String[] args) {
		new A01PhoneBookTest().phoneBookStart();
	}
	

	// 메뉴를 출력하는 메서드
	public void displayMenu(){
		System.out.println();
		System.out.println("메뉴를 선택하세요.");
		System.out.println(" 1. 전화번호 등록");
		System.out.println(" 2. 전화번호 수정");
		System.out.println(" 3. 전화번호 삭제");
		System.out.println(" 4. 전화번호 검색");
		System.out.println(" 5. 전화번호 전체 출력");
		System.out.println(" 0. 프로그램 종료");
		System.out.print(" 번호입력 >> ");		
	}
	
	// 프로그램을 시작하는 메서드
	public void phoneBookStart(){
		System.out.println("===============================================");
		System.out.println("   전화번호 관리 프로그램(저장된 파일을 불러옴)");
		System.out.println("===============================================");
		
		try(ObjectInputStream ois = new ObjectInputStream(new BufferedInputStream(new FileInputStream("d:/D_Other/phone.bin")));
			) {
			Object obj = null;
			while((obj = ois.readObject())!=null) {		//역직렬화
														//읽어온 데이터를 원래의 타입으로 캐스팅하여 사용한다.
			Phone ph = (Phone) obj;
			phoneBookMap.put(ph.getName(), ph);
			System.out.println("이름: " + ph.getName());
			System.out.println("전화번호: " + ph.getTel());
			System.out.println("주소: " + ph.getAddr());
			}
		}catch(FileNotFoundException ex) {
			System.out.println("불러올 파일이 없습니다.");
		}catch(EOFException ee) {
			System.out.println("불러오기 성공...");
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		while(true){
			
			displayMenu();  // 메뉴 출력
			try {
			int menuNum = scanner.nextInt();   // 메뉴 번호 입력

			switch(menuNum){
				case 1 : insert();		// 등록
					break;
				
				 case 2 : update(); // 수정
				 	break;
				 
				 case 3 : delete(); // 삭제
				 	break;
				 
				 case 4 : search(); // 검색
				 	break;
				 
				 case 5 : displayAll(); // 전체 출력
				 	break;
				 
				case 0 :
					System.out.println("프로그램을 종료합니다...");
					try(ObjectOutputStream oos = new ObjectOutputStream(new BufferedOutputStream(new FileOutputStream("d:/D_Other/phone.bin")));
						){
						for(Phone p : phoneBookMap.values()) {
							oos.writeObject(p);
						}
					} catch (Exception e) {
						e.printStackTrace();
					}
					System.out.println("저장 완료....");
					return;
				default :
					System.out.println("잘못 입력했습니다. 다시입력하세요.");
			}}catch(Exception e) {
				scanner.nextLine();
				System.out.println("잘못 입력했습니다. 다시 입력하세요.");
				continue;
			}
			} 
			// switch문
			// while문
	}
	
	//전체 전화번호 정보를 출력하기 위한 메서드
	private void displayAll() {
		System.out.println("모든 정보를 출력합니다");
		System.out.println("================================");
		System.out.println("번호\t이름\t전화번호\t주소");
		System.out.println("================================");
		
		Set<String> keySet = phoneBookMap.keySet();
		if(keySet.size() ==0 ) {
			System.out.println("등록된 전화번호 정보가 없습니다.");
		}else {
			Iterator<String> it = keySet.iterator();
			int cnt = 1;
			while(it.hasNext()) {
				String name = it.next();
				Phone p = phoneBookMap.get(name);
				System.out.println("No."+cnt++ + "\t"+p.getName()+"\t"+p.getTel()+"\t"+p.getAddr());
			}
			System.out.println("================================");
			System.out.println("전체 전화번호 출력완료");
		}	
	}
	//입력한 사람의 정보를 출력하기위한 메서드
	private void search() {
		System.out.println("검색할 사람의 이름을 입력해주십시오.");
		System.out.print("이름 >>");
		String name = scanner.next();
		
		Phone p = phoneBookMap.get(name);
		
		if(p==null) {
			System.out.println(name + "씨의 정보가 없습니다.");
		}else {
			System.out.println(name + "씨의 전화번호 정보");
			System.out.println("이름 : " + phoneBookMap.get(name).getName());
			System.out.println("전화 : " + p.getTel());
			System.out.println("주소 : " + p.getAddr());
		}
		System.out.println("=================================");
	}

	private void delete() {
		System.out.println("삭제할 사람의 이름을 입력해주십시오.");
		String name = scanner.next();
		if(phoneBookMap.remove(name) == null) {				//remove 는 삭제성공하면 value값을 반환하고, 실패하면 null을 반환한다.
			System.out.println(name + "씨는 등록된 사람이 아닙니다.");
			return;
		}
		System.out.println(name + "씨의 정보가 삭제되었습니다.");
	}
	
	private void update() {

		System.out.println("");
		System.out.println("수정할 정보를 입력해 주세요.");
		System.out.print("이 름 >>");
		String name = scanner.next();
		
		//name 이 이미 등록된 사람인지 확인해야함..
		//get() 메서드로 값을 가져올 때 데이터가 없으면 null 값 반환
		//get(key) 값에 맞는 데이터가 있다면 value 를 반환...
		
		if(phoneBookMap.get(name) == null) {
			System.out.println(name + "씨는 이미 등록된 사람이 아닙니다.");
			return;
		}
		
		System.out.println("전화번호 >> ");
		String tel = scanner.next();
		scanner.nextLine();
		
		System.out.println("주 소 >> ");
		String addr = scanner.nextLine();

		Phone p = new Phone(name, tel, addr);	// Phone 타입의 new 객체 p에 정보저장... 
		
		phoneBookMap.put(name, p);
		System.out.println(name + "씨 전화번호 정보 등록 완료!");
		
	}

	//전화번호 정보를 등록하기 위한 메소드
	private void insert() {
		System.out.println("");
		System.out.println("새롭게 등록할 정보를 입력해 주세요.");
		System.out.print("이 름 >>");
		String name = scanner.next();
		
		//name 이 이미 등록된 사람인지 확인해야함..
		//get() 메서드로 값을 가져올 때 데이터가 없으면 null값 반환
		//get(key) 값에 맞는 데이터가 있다면 value 를 반환...
		if(phoneBookMap.get(name) != null) {
			System.out.println(name + "씨는 이미 등록된 사람입니다.");
			return;
		}
		System.out.println("전화번호 >> ");
		String tel = scanner.next();
		scanner.nextLine();
		
		System.out.println("주 소 >> ");
		String addr = scanner.nextLine();

		Phone p = new Phone(name, tel, addr);
		phoneBookMap.put(name, p);
		System.out.println(name + "씨 전화번호 정보 등록 완료!");
	}
}

class Phone implements Serializable{
	private String name;
	private String tel;
	private String addr;
	
	public String getName() {
		return name;
	}
	
	public void setName(String name) {
		this.name = name;
	}
	
	public String getTel() {
		return tel;
	}
	
	public void setTel(String tel) {
		this.tel = tel;
	}
	
	public String getAddr() {
		return addr;
	}
	
	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	
	public Phone(String name, String tel, String addr) {
		super();
		this.name = name;
		this.tel = tel;
		this.addr = addr;
	}

	@Override
	public String toString() {
		return "Phone [이름: " + name + ", 전화번호: " + tel + ", 주소: " + addr + "]";
	}
	
}