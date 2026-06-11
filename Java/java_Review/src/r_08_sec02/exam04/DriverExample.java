package r_08_sec02.exam04;

import r_08_sec02.exam03.Bus;
import r_08_sec02.exam03.Taxi;

public class DriverExample {
	public static void main(String[] args) {
		Driver driver = new Driver();
		
		Bus bus = new Bus();
		Taxi taxi = new Taxi();
		
		driver.drive(bus);
		driver.drive(taxi);
	}
}
