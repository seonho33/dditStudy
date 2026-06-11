package kr.or.ddit.basic;

import java.util.LinkedList;

public class T02LinkedListTest {
	public static void main(String[] args) {
		/*
			stack => 후입선출(LIFO)의 자료구조
			Queue => 선입선출(FIFO)의 자료구조
			Deque => 양끝의 어느 쪽에서든 데이터의 입출력이 가능한 자료구조
					 (ex: ArrayDeque)
		*/

		LinkedList<String> stack = new LinkedList<String>();
		
		/*
			stack 방식의 데이터 처리를 위한 메서드
			1) 데이터 입력 : push(저장할 값)
			2) 데이터 꺼내기 : pop() => 데이터를 꺼내온 후 stack 에서 데이터를 삭제한다.
		*/
	
		stack.push("홍길동");
		stack.push("일지매");
		stack.push("변학도");
		stack.push("강감찬");
		System.out.println("현재 stack 안의 데이터들 : " + stack);
		
		String data = stack.pop();
		System.out.println("꺼내온 데이터: " + data);
		System.out.println("꺼내온 데이터: " + stack.pop());
		System.out.println("현재 stack안의 데이터들 : " + stack);
		
		stack.push("성춘향");
		System.out.println("현재 stack안의 데이터들 : " + stack); 
		System.out.println("꺼내온 데이터: " + stack.pop());
		System.out.println("================================");
		System.out.println();
		///////////////////////////////////////////
		LinkedList<String> queue = new LinkedList<String>();
		
		/*
			Queue 방식의 데이터 처리를 위한 메서드
			1)데이터 입력 : offer(저장할 값)
			2)데이터 꺼내기 : poll() => 데이터를 꺼내온 후 Queue에서 데이터를 제거한다
		*/
		
		queue.offer("홍길동");
		queue.offer("일지매");
		queue.offer("변학도");
		queue.offer("강감찬");
		System.out.println("현재 Queue 안의 데이터들 : " + queue);
		
		String temp = queue.poll();
		System.out.println("꺼내온 데이터 : " + temp);
		System.out.println("꺼내온 데이터 : " + queue.poll());
		System.out.println("현재 Queue안의 데이터들 : " + queue);
		
		if(queue.offer("성춘향")) {
			System.out.println("신규 데이터 : 성춘향");
		}
		System.out.println("현재 Queue안의 데이터 : " + queue);
		System.out.println("꺼내온 데이터: " + queue.poll());
		System.out.println("==================================");
		System.out.println();

	}
}
