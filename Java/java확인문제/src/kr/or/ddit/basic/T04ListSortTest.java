package kr.or.ddit.basic;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class T04ListSortTest {
	public static void main(String[] args) {
		
		List<Member> memList = new ArrayList<Member>();
		memList.add(new Member(1, "홍길동", "010-111-1111"));
		memList.add(new Member(5, "변학도", "010-111-2222"));
		memList.add(new Member(9, "성춘향", "010-111-3333"));
		memList.add(new Member(3, "이순신", "010-111-4444"));
		memList.add(new Member(6, "강감찬", "010-111-5555"));
		memList.add(new Member(2, "일지매", "010-111-6666"));
		
		System.out.println("정렬 전: ");
		for(Member mem : memList) {
			System.out.println(mem);
		}
		
		Collections.sort(memList); // 리스트 정렬하기
		
		System.out.println("정렬 후: ");
		for(Member mem : memList) {
			System.out.println(mem);
		}
		
		Collections.shuffle(memList); // 섞은 후
		
		System.out.println("섞은 후: ");
		for(Member mem : memList) {
			System.out.println(mem);
		}
		
		Collections.sort(memList, new SortNumDesc());
		
		System.out.println("외부정렬자 이용하여 정렬 후: ");
		for(Member mem : memList) {
			System.out.println(mem);
		}
		
		
		
		
		
	}
}

// VO 클래스
class Member implements Comparable<Member> {
	private int num;		// 번호
	private String name;	// 이름
	private String tel;		// 전화번호
	
	public Member(int num, String name, String tel) {
		super();
		this.num = num;
		this.name = name;
		this.tel = tel;
	}
	public int getNum() {
		return num;
	}
	public void setNum(int num) {
		this.num = num;
	}
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
	
	@Override
	public String toString() {
		return "Member [num=" + num + ", name=" + name + ", tel=" + tel + "]";
	}
	
	/**
	 * Member의 회원이름 기준으로 오름차순 정렬이 되도록 하기
	 */
	@Override
	public int compareTo(Member mem) {
		
		return this.getName().compareTo(mem.getName());
	}
}

/**
 * Member의 번호(num)의 내림차순으로 정렬하기 위한 
 * 외부정렬자 클래스
 */
class SortNumDesc implements Comparator<Member> {

	@Override
	public int compare(Member mem1, Member mem2) {
		/*
		if(mem1.getNum() > mem2.getNum()) {
			return -1;
		}else if(mem1.getNum() == mem2.getNum()) {
			return 0;
		}else {
			return 1;
		}
		*/
		
		return Integer.valueOf(mem1.getNum())
						.compareTo(mem2.getNum()) * -1;
		
		
		
	}
	
}


