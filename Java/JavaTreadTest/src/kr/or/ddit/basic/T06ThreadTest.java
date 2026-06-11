package kr.or.ddit.basic;

import javax.swing.JOptionPane;

public class T06ThreadTest {
	// 입력 여부를 확인하기 위한 공통변수 선언(스레드간 정보 공유용)
	public static boolean intputCheak;
	
	public static void main(String[] args) {
		
		Thread th1 = new DataInput();
		Thread th2 = new CountDown();
		
		th1.start();
		th2.start();
		
		try {
			th2.join();
		} catch (InterruptedException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
}
/*
	데이터 입력을 처리하기 위한 스레드
*/
class DataInput extends Thread{

	@Override
	public void run() {
		String str = JOptionPane.showInputDialog("10초 안에 아무거나 입력하십시오.");

		if(T06ThreadTest.intputCheak == false) {
		T06ThreadTest.intputCheak=true;	//입력 완료
		System.out.println("입력된 값은 " + str + "입니다.");
		}else {
			System.out.println("입력 시간이 지났습니다.");
		}
	}
}

class CountDown extends Thread {

	@Override
	public void run() {
		
		for(int i=10;i>=1;i--) {
			
			// 사용자 입력이 완료되었는지 여부를 확인하고 완료 되었다면 
			// 현재 스레드를 종료시킨다.
			
			if(T06ThreadTest.intputCheak==false) {
			System.out.println(i);
			try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();}
			}else {
				return;
			}
		}
		System.out.println("10초가 지났습니다. 프로그램을 종료합니다.");
		T06ThreadTest.intputCheak=true;
		System.exit(0);
	}
}