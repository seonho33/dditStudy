package kr.or.ddit.basic;

import javax.swing.JOptionPane;

public class T07ThreadTest {
	public static boolean timeOut;
	public static String player = "";
	
	public static void main(String[] args) {
		
		Thread game = new GameStart();
		Thread cnt1 = new CountDown1();
		
		game.start();
		cnt1.start();
	}
}





class GameStart extends Thread{

	@Override
	public void run() {
		while(true) {
		T07ThreadTest.player = JOptionPane.showInputDialog("가위,바위,보 중 입력하십시오.");
		if(T07ThreadTest.player.equals("가위")||T07ThreadTest.player.equals("바위")||T07ThreadTest.player.equals("보")) {
			break;
		}
		}
		String[] computerData = {"가위","바위","보"};
		int comIndex = (int)(Math.random()*3);
		String com = computerData[comIndex];
		
		System.out.println("컴퓨터\t: " + com);
		System.out.println("당신\t: " + T07ThreadTest.player);
		
		if(T07ThreadTest.player.equals(com)) {
			System.out.println("비겼습니다");
			}else if((T07ThreadTest.player.equals("가위")&&com.equals("보"))
					||(T07ThreadTest.player.equals("바위")&&com.equals("가위"))
					||(T07ThreadTest.player.equals("보")&&com.equals("바위"))){
				System.out.println("당신이 이겼습니다.");
			}else {
				System.out.println("당신이 졌습니다.");
			}
		System.exit(0);
		}
	}
	
	

class CountDown1 extends Thread{

	@Override
	public void run() {
		
		for(int i=5; i>=1; i--) {
			System.out.println(i);
			try {
				Thread.sleep(1000);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		System.out.println("제한시간이 종료되었습니다.");
		System.exit(0);
	}
}	
