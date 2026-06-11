package r_08_sec02.exam04;

import r_08_sec02.exam03.Bus;
import r_08_sec02.exam03.Vehicle;

public class Driver {
	public void drive(Vehicle vehicle) {
		if(vehicle instanceof Bus) {
			Bus bus = (Bus) vehicle;
			bus.checkFare();
		}
		vehicle.run();
	}
}
