package r_07_sec03.exam06;

import r_07_sec03.exam03.RemoteControl;
import r_07_sec03.exam04.Audio;
import r_07_sec03.exam04.Television;

public class Myclass {
	//필드
	RemoteControl rc = new Television();
	
	//생성자
	Myclass(){
	}
	
	Myclass(RemoteControl rc){
		this.rc=rc;
		rc.turnOn();
		rc.setVolume(5);
		rc.turnOff();
	}
	
	//메소드
	void methodA() {
		RemoteControl rc =new Audio();
		rc.turnOn();
		rc.setVolume(5);
		rc.turnOn();
	}
	
	void methodB(RemoteControl rc) {
		rc.turnOn();
		rc.setVolume(5);
		rc.turnOff();
	}
}
