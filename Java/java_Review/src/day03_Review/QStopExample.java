package day03_Review;

import java.io.IOException;

public class QStopExample {
	public static void main(String[] args) throws IOException {
		int keyCode;
		
		while(true) {
			keyCode = System.in.read();
			if(keyCode ==113) {
				break;
			}
		}
		System.out.println("종료");
	}
}
