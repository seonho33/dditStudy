package sec01.exam05;

import sec01.exam02.RemoteControl;

public class SmartTelevision implements RemoteControl, Searchable {
	private int volume;
	
	public void turnOn() {
		System.out.println("TV를 켭니다.");
	}
	public void turnOff() {
		System.out.println("TV를 끕니다.");
	}
	public void SetVolume(int volume) {
		if(volume>RemoteControl.MAX_VOLUME) {
			volume=RemoteControl.MAX_VOLUME;
		}else if(volume<RemoteControl.MIN_VOLUME) {
			volume=RemoteControl.MIN_VOLUME;
		}else {
			this.volume=volume;
		}
		System.out.println("현재 TV 볼륨: " + volume);
	}
	
	public void search(String url) {
		System.out.println(url + "을 검색합니다.");
	}
}