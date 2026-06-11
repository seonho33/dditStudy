package sec01.exam04;

import sec01.exam02.RemoteControl;

public class Audio implements RemoteControl {
	//필드
	private int volume;

	
	public void turnOn() {
		System.out.println("Audio를 켭니다.");
	}
	
	public void turnOff() {
		System.out.println("Audio를 끕니다.");
	}
	
	public void SetVolume(int volume) {
		if(volume>RemoteControl.MAX_VOLUME) {
			volume = RemoteControl.MAX_VOLUME;
		}else if(volume<RemoteControl.MIN_VOLUME) {
			volume = RemoteControl.MIN_VOLUME;
		}else {
			this.volume = volume;
		}
		System.out.println("현재 Audio 볼륨: " + this.volume);
	}
}