package r_07_sec03.exam05;

import r_07_sec03.exam03.RemoteControl;
import r_07_sec03.exam04.Searchable;

public class SmartTelevision implements RemoteControl,Searchable{
	private int volume;

	@Override
	public void search(String url) {
		System.out.println(url + "을 검색합니다.");
	}

	@Override
	public void turnOn() {
		System.out.println("스마트티비를 켭니다.");
	}

	@Override
	public void turnOff() {
		System.out.println("스마트티비를 끕니다.");
	}

	@Override
	public void setVolume(int volume) {
		if(volume<MIN_VOLUME) {
			volume=MIN_VOLUME;
		}else if(volume>MAX_VOLUME) {
			volume=MAX_VOLUME;
		}else {
			this.volume=volume;
		}
		System.out.println("현재 볼륨 : " + this.volume+"입니다.");
	}
	
}
