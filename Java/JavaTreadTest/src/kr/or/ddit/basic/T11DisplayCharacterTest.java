package kr.or.ddit.basic;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class T11DisplayCharacterTest {
/*	
	3개(명)의 스레드가 각각 알파벳 대문자를 출력하는데 출력을 끝낸 순서대로
	결과를 나타내는 프로그램 작성하기
*/	
	static int currRank = 1;
	
	public static void main(String[] args) {
		List<DisplayCharacter> disCharList = new ArrayList<DisplayCharacter>();
		disCharList.add(new DisplayCharacter("홍길동"));
		disCharList.add(new DisplayCharacter("변학도"));
		disCharList.add(new DisplayCharacter("성춘향"));
		disCharList.add(new DisplayCharacter("일지매"));
		
		for(Thread th : disCharList) {
			th.start();
		}
		for(Thread th : disCharList) {
			try {
				th.join();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		
		System.out.println("=====================");
		
		Collections.sort(disCharList);
		
		for(DisplayCharacter th : disCharList) {
			System.out.println(th.getRank()+"등 " + th.getName());
		}
	
	}
}

//알파벳 대문자를 출력하는 스레드

class DisplayCharacter extends Thread implements Comparable<DisplayCharacter>{
	
	private String name;	//스레드 이름
	private int rank;
	
	public DisplayCharacter(String name) {
		super(name);	//스레드의 이름 설정하기
		this.name = name;
	}
	
	@Override
	public void run() {
		for(char ch='A'; ch<='Z'; ch++) {
			
			try {
				Thread.sleep((int)(Math.random()*301)+200);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			System.out.println(name + "의 출력문자 : " + ch);
		}
		rank = T11DisplayCharacterTest.currRank++;
	}

	public int getRank() {
		return rank;
	}

	public void setRank(int rank) {
		this.rank = rank;
	}

	@Override
	public int compareTo(DisplayCharacter o) {

	//	return Integer.valueOf(this.getRank()).compareTo(o.getRank());
		if(this.getRank()-o.getRank()<0) {
			return -1;
		}else if(this.getRank()-o.getRank()==0) {
			return 0;
		}else {
			return 1;
		}
	}
}

