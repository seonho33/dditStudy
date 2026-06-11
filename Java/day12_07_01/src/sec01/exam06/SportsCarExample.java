package sec01.exam06;

public class SportsCarExample {
	public static void main(String[] args) {
		
		Car car = new Car();
		car.speed = 10;
		car.speedUp();
		car.stop();
		
		SportsCar sportscar = new SportsCar();
		sportscar.speed = 10;
		sportscar.speedUp();
		sportscar.stop();
		
	}
}
