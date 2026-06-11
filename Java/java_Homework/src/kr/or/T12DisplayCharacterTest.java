package kr.or;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

public class T12DisplayCharacterTest {
	static int currRank = 1;
	public static void main(String[] args) {
		List<Horse> horse = new ArrayList<Horse>();
		horse.add(new Horse("1번말"));
		horse.add(new Horse("2번말"));
		horse.add(new Horse("3번말"));
		horse.add(new Horse("4번말"));
		horse.add(new Horse("5번말"));
		horse.add(new Horse("6번말"));
		horse.add(new Horse("7번말"));
		horse.add(new Horse("8번말"));
		horse.add(new Horse("9번말"));
		horse.add(new Horse("10번말"));
		DisplayHorse dh = new DisplayHorse(horse);
		
		for(Thread h : horse) {
			h.start();
		}
		
		dh.start();
		
		for(Thread h : horse) {
			try {
				h.join();
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
		
		Collections.sort(horse);
		System.out.println("\n\n=================================");
		for(Horse h : horse) {
			System.out.print("\n"+h.getScore()+"등\t"+h.getName());
		}
	}
}



class Horse extends Thread implements Comparable<Horse>{
	private int line;
	private int score;

	public Horse(String name) {
		super(name);
	}
	
	@Override
	public int compareTo(Horse horse2) {
		return Integer.valueOf(this.getScore()).compareTo(horse2.getScore());
	}

	@Override
	public void run() {	
		for(int i=0;i<=50;i++) {
			line=i;
			try {
				Thread.sleep((int)(Math.random()*401)+300);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
			if(line==50) {
				score = T12DisplayCharacterTest.currRank;
				T12DisplayCharacterTest.currRank++;
			}
		}
	}
	
	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public int getLine() {
		return line;
	}

}



class DisplayHorse extends Thread{

	private List<Horse> hos;
	
	public DisplayHorse(List<Horse> hos){
		this.hos=hos;
	}

	@Override
	public void run() {
		while(T12DisplayCharacterTest.currRank<=10) {
			System.out.println("\n\n\n\n\n\n");
			for(Horse h : hos) {
				System.out.print("\n"+h.getName()+"\t");
				for(int i=0; i<=50;i++) {
					if(i==h.getLine()) {
						System.out.print(">");
					}else {
						System.out.print("-");
					}
				}
			}
		try {
			Thread.sleep(200);
		} catch (InterruptedException e) {
			e.printStackTrace();
			}
		}
	}
}
