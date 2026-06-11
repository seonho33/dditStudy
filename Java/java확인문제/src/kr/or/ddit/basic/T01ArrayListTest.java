package kr.or.ddit.basic;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;

public class T01ArrayListTest {
	public static void main(String[] args) {
		// 기본 용량 : 10
		List list1 = new LinkedList();
		
		// add()메서드를 이용하여 데이터를 추가한다.
		list1.add(new String("aaa"));
		list1.add("bbb");
		list1.add(111);
		list1.add('k');
		list1.add(true);
		list1.add(3.14);
		
		
		
		// size() => 데이터 개수
		System.out.println("size => " + list1.size());
		System.out.println("list1 => " + list1);
		
		// get()으로 데이터 꺼내오기
		System.out.println("첫번째 자료: " + list1.get(0));
		
		// 데이터 끼워넣기
		list1.add(0, "zzz");
		System.out.println("list1(끼워넣기 후) => " + list1);
		
		// 데이터 변경하기 : set()메서드 이용
		String temp = (String) list1.set(0, "YYY");
		System.out.println("temp => " + temp);
		System.out.println("list1(데이터 변경 후) => " + list1); 
		
		// 데이터 삭제하기
		list1.remove(0);
		System.out.println("list1(데이터 삭제 후) => " + list1);
		
		list1.remove("bbb");
		System.out.println("list1 => (bbb 삭제 후) " + list1);
		System.out.println("==============================");
		
		list1.remove(Integer.valueOf(111));
		System.out.println("list1 => (111 삭제 후) " + list1);
		
		///////////////////////////
		
		// 제너릭을 지정하여 선언할 수 있다.
		List<String> list2 = new ArrayList<String>();
		list2.add("AAA");
		list2.add("BBB");
		list2.add("CCC");
		list2.add("DDD");
		list2.add("EEE");
		
		for(String str : list2) {
			System.out.println(str);
		}
		System.out.println("-------------------------");
		
		// contains(비교객체) => 리스트에 '비교객체'가 있으면 true
		//                    없으면 false가 반환됨.
		System.out.println(list2.contains("DDD"));
		System.out.println(list2.contains("ZZZ"));
		
		// indexOf(비교객체) => 리스트에 '비교객체'를 찾아서 해당
		//                    인덱스값을 반환한다. 없으면 -1 반환함.
		System.out.println("DDD의 index값 : " 
				+ list2.indexOf("DDD"));
		System.out.println("ZZZ의 index값 : " 
				+ list2.indexOf("ZZZ"));
///////////////////////////
		
		for(int i=0; i<list2.size(); i++) {
			list2.remove(i);
		}
		
		//list2.clear();
		
		System.out.println("전체 삭제후 : " + list2.size());
		
		
		
		List<String> strList = new ArrayList<String>();
		strList.add("홍길동");
		strList.add("홍길동");
		strList.add("홍길동");
		strList.add("홍길동");
		strList.add("홍길동");
		strList.add("홍길동");
		
		System.out.println(strList);
		
		
		
		
		
		
		
		
		
		
	}
}
