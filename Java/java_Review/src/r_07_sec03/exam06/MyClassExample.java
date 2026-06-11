package r_07_sec03.exam06;

import r_07_sec03.exam04.Audio;

public class MyClassExample {
	public static void main(String[] args) {
		
		Audio A = new Audio();
		System.out.println("1)----------------------------");
		
		Myclass myclass = new Myclass();
		myclass.rc.turnOn();
		myclass.rc.setVolume(5);
		myclass.rc.turnOff();
		
		System.out.println("2)----------------------------");
		Myclass myclass2 = new Myclass(A); 
		
		
		System.out.println("3)----------------------------");
		Myclass myclass3 = new Myclass();
		myclass3.methodA();
		
		System.out.println("4)----------------------------");
		Myclass myclass4 = new Myclass();
		myclass4.methodB(myclass4.rc);
	}
}

