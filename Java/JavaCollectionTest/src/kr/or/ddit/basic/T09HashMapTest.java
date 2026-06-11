package kr.or.ddit.basic;

import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;
import java.util.Set;

public class T09HashMapTest {
/*
	map => key 값과 value 값을 한 쌍으로 관리하는 객체
		=> key 값은 중복을 허용하지 않고 인덱스개념이 존재하지 않음.
		=> value 값은 중복을 허용한다.
*/
	
	public static void main(String[] args) {
		Map<String, String> hMap = new HashMap<String, String>();
		
		//데이터 추가하기 => put(key 값, value 값);
		hMap.put("name", "홍길동");
		hMap.put("addr", "대전");
		hMap.put("tel", "010-1234-5678");
		
		//데이터 수정하기 	=> 데이터를 저장할 때 key 값이 같으면 나중에 입력한 value 값이 저장된다.
		//			 	=> put(수정할 key 값, 새로운 value 값)
		hMap.put("addr", "서울");
		System.out.println("hMap => " + hMap);
		
		
		//데이터 삭제하기 	=> remove(삭제할 key 값)
		hMap.remove("name");
		System.out.println("hMap => " + hMap);
		
		
		//데이터 읽기 		=> get (key 값)
		System.out.println("addr=" + hMap.get("addr"));
		System.out.println("=============================");

		
		//key 값들을 읽어와 모든 데이터를 출력하는 방법
		//방법 1. keySet() 메서드를 사용한다.
		Set<String> keySet = hMap.keySet();
		
		System.out.println("Iterator 이용하기");
		Iterator<String> it = keySet.iterator();
		while(it.hasNext()) {
			String key = it.next();
			System.out.println(key + " : " + hMap.get(key));
		}
		System.out.println("-------------------------------------");
		System.out.println("향상된 for문(for-each문) 이용");
		
		for(String key : keySet) {
			System.out.println(key + " : " + hMap.get(key));
		}
		System.out.println("-------------------------------------");
		
		//방법 2. value 값들만 읽어와 출력하기 => values() 이용
		System.out.println("values()메서드를 사용하기");
		for(String value : hMap.values()) {
			System.out.println(value);
		}
		System.out.println("-------------------------------------");

		//방법 3. Map 관련 클래스에는 Map.Entry 타입의 내부 클래스가 
		//		 정의되어 있다. 이 Entry 타입의 객체를 Set 형식으로
		//		 제공하는 메서드를 이용하는 방법 => entrySet()메서드
		System.out.println("entrySet()메서드 이용하기");		
		Set entrySet = hMap.entrySet();
		Iterator it2 = entrySet.iterator();
		while(it2.hasNext()) {
			Entry entry = (Entry)it2.next();
			System.out.println("key 값 : " + entry.getKey() + "\t" + "| value 값 : " + entry.getValue());
		}
		Map<Integer, Integer> map2 = new HashMap<Integer, Integer>();
		map2.put(111, 3333);
		
	}
}
