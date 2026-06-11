package sec01.exam06;

import sec01.exam02.RemoteControl;
import sec01.exam04.Audio;
import sec01.exam04.Television;

public class MyClass {
	//필드
	RemoteControl rc = new Television();
	
	//생성자
	public MyClass() {
	}
	
	MyClass(RemoteControl rc){
		this.rc=rc;
		rc.turnOn();
		rc.SetVolume(5);
	}
	
	//메소드
	void methodA() {
		RemoteControl rc = new Audio();
		rc.turnOn();
		rc.SetVolume(5);
	}
	void methodB(RemoteControl rc) {
		rc.turnOn();
		rc.SetVolume(5);
	}
}
