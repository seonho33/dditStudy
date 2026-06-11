package r_07_sec03.exam04;

import r_07_sec03.exam03.RemoteControl;

public class Television implements RemoteControl{
	//필드
	private int volume;

	@Override
	public void turnOn() {
		System.out.println("TV전원을 켭니다.");
	}

	@Override
	public void turnOff() {
		System.out.println("TV전원을 끕니다.");
	}

	@Override
	public void setVolume(int volume) {
		if(volume>MAX_VOLUME) {
			this.volume=MAX_VOLUME;
		}else if(volume<MIN_VOLUME) {
			this.volume=MIN_VOLUME;
		}else {
			this.volume=volume;
		}
		System.out.println("현재 TV볼륨 : " + this.volume);
	}
}
