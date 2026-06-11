package sec01.exam05;

import sec01.exam02.RemoteControl;

public class SmartTelevisionExample {
	public static void main(String[] args) {
		SmartTelevision tv = new SmartTelevision();
		
		RemoteControl rc = tv;
		rc.turnOn();
		rc.SetVolume(5);
		rc.turnOff();
		
		Searchable searchable = tv;
		searchable.search("A305");
	}
}