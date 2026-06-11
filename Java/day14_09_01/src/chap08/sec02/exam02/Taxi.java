package chap08.sec02.exam02;

import chap08.sec02.exam03.Vehicle;

public class Taxi implements Vehicle , chap08.sec02.exam02.Vehicle {

	@Override
	public void run() {
		System.out.println("택시가 달립니다.");
	}
}