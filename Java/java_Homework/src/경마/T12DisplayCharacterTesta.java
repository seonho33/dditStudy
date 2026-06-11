package 경마;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;
import java.util.Scanner;

public class T12DisplayCharacterTesta {
	static int currRank = 1;
	static int playNum;
	
	public static void main(String[] args) {
		List<Horse> horse = new ArrayList<Horse>();
		Scanner scanner = new Scanner(System.in);
		DisplayHorse dh = new DisplayHorse(horse);
		
		System.out.println("몇마리의 말로 경주하겠습니까?");
		playNum = scanner.nextInt();
		
		for(int i=0;i<playNum;i++ ) {
			horse.add(new Horse((i+1)+"번말"));
		}
		
		
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
		System.out.println("\n=================================");
		System.out.println("               결과");
		System.out.println("=================================");		
		for(Horse h : horse) {
			System.out.print("\n"+h.getScore()+"등\t"+h.getName());
		}
		scanner.close();
	}
}



class Horse extends Thread implements Comparable<Horse>{
	private int line;
	private int score;
	private boolean goal;
	private int time;
	
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
			if(line==50) {
				try {
					Thread.sleep(200);
				} catch (InterruptedException e) {
					e.printStackTrace();
				}
				score = T12DisplayCharacterTesta.currRank;
				T12DisplayCharacterTesta.currRank++;
				goal = true;
			}
			try {
				Thread.sleep((int)(Math.random()*401)+200);
			} catch (InterruptedException e) {
				e.printStackTrace();
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
	
	public boolean getGoal() {
		return goal;
	}
}



class DisplayHorse extends Thread{

	private List<Horse> hos;
	
	public DisplayHorse(List<Horse> hos){
		this.hos=hos;
	}

	@Override
	public void run() {
		
		while(T12DisplayCharacterTesta.currRank<=T12DisplayCharacterTesta.playNum) {
			System.out.println("\n\n\n\n\n\n\n\n");
			for(Horse h : hos) {
				System.out.print("\n"+h.getName()+"\t");
				for(int i=0; i<=50;i++) {
					if(i==h.getLine()) {
						System.out.print(">");
					}else {
						System.out.print("-");
					}
				}
				if(h.getGoal()==true) {
					System.out.print("[도착]");
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
