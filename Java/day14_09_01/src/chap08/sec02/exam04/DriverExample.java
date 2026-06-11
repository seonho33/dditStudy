package chap08.sec02.exam04;

import chap08.sec02.exam02.Taxi;
import chap08.sec02.exam03.Bus;

public class DriverExample {
	public static void main(String[] args) {
		Driver driver = new Driver();
		
		Bus bus = new Bus();
		Taxi taxi = new Taxi();
		
		driver.drive(bus);
		driver.drive(taxi);
	}
}