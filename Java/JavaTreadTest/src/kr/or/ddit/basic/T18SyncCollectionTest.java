package kr.or.ddit.basic;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class T18SyncCollectionTest {
/*
	Vector, Hashtable 등의 예전부터 존재하던 Collection 클래스들은 내부에
	동기화 처리가 되어 있다. 그런데 최근 새로 구성된 Collection 클래스들은 
	동기화 처리가 되어있지 않다. 그래서 동기화가 필요한 경우에 해당 컬렉션 객체를
	동기화 처리하여 사용해야 한다.
*/	
	//동기화 처리를 하지 않을 경우
	private static List<Integer> list1 = new ArrayList<Integer>();

	//동기화 처리를 했을 경우
	private static List<Integer> list2 = Collections.synchronizedList(new ArrayList<>());
	
	public static void main(String[] args) {
		
		Runnable r = new Runnable() {
			
			@Override
			public void run() {
				
				for(int i=1; i<=10000;i++) {
					list2.add(i);
				}
			}
		};
		
		Thread[] ths = new Thread[] {
				new Thread(r), new Thread(r),
				new Thread(r), new Thread(r), new Thread(r)
		};
		
		for(Thread th : ths) {
			th.start();
		}
		
		for(Thread th : ths) {
			try {
				th.join();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		
		System.out.println("list1의 개수 : " + list1.size());
		System.out.println("list2의 개수 : " + list2.size());
		
	}
}
