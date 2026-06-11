package r_08_sec02.exam01;

public class CarExample {
	public static void main(String[] args) {
		Car car = new Car();
		
		car.run();
		
		car.forntLeftTire = new KumhoTire();
		car.forntRightTire = new KumhoTire();
		
		car.run();
	}
}
