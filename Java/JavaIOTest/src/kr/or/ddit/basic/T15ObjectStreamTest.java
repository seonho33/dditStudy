package kr.or.ddit.basic;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.EOFException;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.io.Serializable;

/*
	객체 입출력 스트림 예제(직렬화와 역 직렬화)
*/
public class T15ObjectStreamTest {
	public static void main(String[] args) {
		
		//Member 인스턴스 생성
		Member mem1 = new Member("홍길동", 20, "대전");
		Member mem2 = new Member("성춘향", 30, "서울");
		Member mem3 = new Member("일지매", 40, "대구");
		Member mem4 = new Member("변학도", 50, "부산");
		
		try(ObjectOutputStream oos = new ObjectOutputStream(new BufferedOutputStream( new FileOutputStream("d:/D_Other/memObj.bin")));
			//객체를 파일로 저장하기 위한 OutputStream
			) {
			//객체를 파일로 저장하기
			//쓰기 작업
			oos.writeObject(mem1);	//직렬화
			oos.writeObject(mem2);	//직렬화
			oos.writeObject(mem3);	//직렬화
			oos.writeObject(mem4);	//직렬화
			
			System.out.println("쓰기 작업 완료...!");
			
		} catch (IOException e) {
			e.printStackTrace();
		}
		
		try (ObjectInputStream ois = new ObjectInputStream(new BufferedInputStream(new FileInputStream("d:/D_Other/memObj.bin")));)
		{	
			Object obj = null;
			while((obj = ois.readObject())!=null) {	//역직렬화 
				// 읽어온 객체를 원래의 타입으로 캐스팅하여 사용한다.
				Member mem = (Member) obj;
				System.out.println("이름 : " + mem.getName());
				System.out.println("나이 : " + mem.getAge());
				System.out.println("주소 : " + mem.getAddr());
				
				System.out.println("-------------------------------------------");
			}
		} catch(EOFException e) {
			System.out.println("파일을 모두 읽었습니다.");
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
}

/*
	회원정보 VO
*/

class Member implements Serializable {
	//자바는 Serializable 인터페이스를 구현한 객체만 직렬화 할 수 있더록 제한하고 있음
	//구현안하면 NotSerializable 예외 발생함...
	/*
		transient => 직렬화가 되지 않았으면 하는 멤버변수에 지정한다.
					(static 필드도 직렬화 대상이 아니다.)
					직렬화가 되지 않는 멤버변수는 기본값으로 저장된다.
					(참조형 변수: null, 숫자형 변수: 0)
	*/
	transient private String name;
	private int age;
	private String addr;
	
	public Member(String name, int age, String addr) {
		super();
		this.name = name;
		this.age = age;
		this.addr = addr;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}
	
	
}