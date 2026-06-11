package kr.or.ddit.basic;

import javax.swing.JOptionPane;

/*
	단일 스레드 환경에서의 사용자 입력 처리예제
*/

public class T05ThreadTest {
	
	static int timeOut=0;
	
	public static void main(String[] args) {
		Thread th1 = new MyThread();
		
		th1.start();
		String str = JOptionPane.showInputDialog("아무거나 입력하세요");
		if(timeOut ==0) {
		System.out.println("입력한 값은 " + str + "입니다.");
		}else {
			System.out.println("입력 시간이 지났습니다.");
		}
	}
	
	static void methodA() {
		timeOut=1;
	}
	static int methodB() {
		
		return 0;
	}
}

class MyThread extends Thread {

	@Override
	public void run() {
		for(int i = 10; i>=1; i--) {
			System.out.println(i);
			try {
				Thread.sleep(500);
			} catch (InterruptedException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		T05ThreadTest.methodA();
	}
}
