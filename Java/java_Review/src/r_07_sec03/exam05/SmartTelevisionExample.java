package r_07_sec03.exam05;

import r_07_sec03.exam03.RemoteControl;
import r_07_sec03.exam04.Searchable;

public class SmartTelevisionExample {
	public static void main(String[] args) {
		SmartTelevision tv = new SmartTelevision();
		
		RemoteControl rc = tv;
		Searchable searchable = tv;
		
	}
}
