package r_07_sec03.exam01;

public class PhoneExample {
	public static void main(String[] args) {
		Phone phone = new Phone();
		
		Smartphone smartphone = new Smartphone("홍길동");
		smartphone.turnOn();
		smartphone.internetSearch();
		smartphone.turnOff();
		phone.turnOn();
		phone.turnOff();
	}
}
