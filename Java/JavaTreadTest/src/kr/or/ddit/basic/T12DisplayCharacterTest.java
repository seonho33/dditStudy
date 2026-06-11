package kr.or.ddit.basic;

import java.util.ArrayList;
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
		
		DisplayHorse dc = new DisplayHorse(horse.get(0));
		horse.get(0).start();
		dc.start();
	}
}



class Horse extends Thread{				//run 하면 랜덤한 숫자만큼 sleep하고 line 을 1씩 증가시킴..
	private String name;
	private int line;
	
	public int getLine() {
		return line;
	}

	public Horse(String name) {
		super(name);
		this.name = name;
	}
	
	@Override
	public void run() {					//변수 line 이 1씩 증가함...
		for(int i=0;i<=50;i++) {
			line=i;
			try {
				Thread.sleep((int)(Math.random()*301)+200);
			} catch (InterruptedException e) {
				e.printStackTrace();
			}
		}
	}
}

class DisplayHorse extends Thread{

	private Horse str;
	
	public DisplayHorse(Horse str){
		this.str=str;
	}

	@Override
	public void run() {
		while(true) {
			System.out.print(str.getName() + " ");
			for(int i=1; i<=50;i++) {
				if(i==str.getLine()) {
					System.out.print(">");
					if(str.getLine()==50) {
						return;
					}
				}else {
					System.out.print("-");
				}
			}
			try {
				Thread.sleep(200);
		} catch (InterruptedException e) {
			e.printStackTrace();
		}
		System.out.println();
		}
	}
}


//if문을 써서 - or > 이 출력되어야함.. 