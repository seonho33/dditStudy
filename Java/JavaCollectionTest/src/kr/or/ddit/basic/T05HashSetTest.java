package kr.or.ddit.basic;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.Iterator;
import java.util.List;
import java.util.Set;

public class T05HashSetTest {
	public static void main(String[] args) {
/*		List 와 Set의 차이점
		
		1. List
		 - 인덱스(순서) 개념이 존재한다.
		 - 중복되는 데이터를 저장할 수 있다.
		 
		2. Set
		 - 입력한 데이터의 인덱스(순서) 개념이 없다.
		 - 중복되는 데이터를 저장할 수 없다.	*/
		Set hs1 = new HashSet();
		
		//Set에 데이터를 추가할 때에도 add()메서드를 사용한다.
		hs1.add("DD");
		hs1.add("Aa");
		hs1.add(2);
		hs1.add("CC");
		hs1.add("BB");
		hs1.add(1);
		hs1.add(3);
		
		System.out.println("Set 데이터 : " + hs1);
		System.out.println();
		//Set은 중복을 허용하지 않기 때문에 이미 존재하는 데이터를 add하면 false를 반환하고, 데이터는 추가되지 않는다.
		
		boolean isAdd = hs1.add("FF");
		System.out.println("중복되지 않을 때 : " + isAdd);
		System.out.println("Set 데이터 : " + hs1);
		System.out.println();
		
		isAdd = hs1.add("CC");
		System.out.println("중복될 때 " + isAdd);
		System.out.println("Set 데이터 : " + hs1);
		System.out.println();
		
		/* Set 데이터를 수정하려면 수정하는 명령이 따로 없기때문에 해당 데이터를 삭제한 후 새로운 데이터를 추가해주어야한다.
		 * 삭제하는 메서드
		 * 1)clear() =>전체 데이터 삭제
		 * 2)remove(삭제할데이터) => 해당 데이터 삭제			 */
		
		// 예)'FF'를 'EE'로 수정하기
		hs1.remove("FF");	//FF 자료삭제
		System.out.println("삭제 후 Set데이터 : " + hs1);
		System.out.println();
		
		hs1.add("EE");	//EE자료 추가
		System.out.println("추가 후 Set데이터 : " + hs1);
		System.out.println();
		
		// hs1.clear(); <<전체 데이터 삭제
		System.out.println("Set의 데이터 개수 : " + hs1.size());
		System.out.println();
		
		// Set 은 데이터의 인덱스를 사용할 수 없기 때문에
		// Iterator 객체를 사용하여 하나씩 접근해야 한다.
		// Set의 데이터를 접근하기 위한 Iterator객체를 가져오려면
		// Set객체의 iterator()메서드를 호출하면 된다.
		
		Iterator it = hs1.iterator();
		
		// 데이터 개수만큼 반복하며
		while(it.hasNext()) {	//hasnext() : 다음에 꺼낼 데이터가 있는지 없는지 확인
			System.out.println(it.next());	//다음데이터 꺼내기...
		}
		System.out.println("향상된 for문 이용해서 꺼내기");
		for(Object obj : hs1) {
			System.out.println(obj);
		}
		
		// 1~100 사이의 중복되지 않는 정수 5개 만들기
		Set<Integer> intRnd = new HashSet<Integer>();
		
		while(intRnd.size()<5) {
			int num = (int)(Math.random()*100)+1;
			intRnd.add(num);
		}
		System.out.println("만들어진 난수들 : " + intRnd);
		
		//Collection 유형의 객체들은 서로다른 자료구조로 쉽게
		//변형해서 사용할 수 있다.
		//생성자의 매개변수로 넣어서 생성해 주면 된다.
		List<Integer> intRndList = new ArrayList<Integer>(intRnd);
		System.out.println("리스트 안의 데이터 꺼내기");
		for(int i=0; i<intRndList.size();i++) {
			System.out.println(intRndList.get(i));
		}
	}
}
