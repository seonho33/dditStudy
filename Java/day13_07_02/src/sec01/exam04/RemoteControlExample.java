package sec01.exam04;

import sec01.exam02.RemoteControl;

public class RemoteControlExample {
	public static void main(String[] args) {
		RemoteControl rc = null;
		rc = new Television();
		rc.turnOn();
		rc.SetVolume(5);
		rc.turnOff();
		System.out.println("------------------");
		
		rc = new Audio();
		rc.turnOn();
		rc.SetVolume(5);
		rc.turnOff();
		System.out.println("------------------");
	}
}