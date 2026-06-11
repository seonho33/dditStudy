package chap08.sec02.exam04;

import chap08.sec02.exam03.Bus;
import chap08.sec02.exam03.Vehicle;

public class Driver {
	public void drive(Vehicle vehicle) {
	if(vehicle instanceof Bus) {				//drive()에서 받은 Vehicle 객체의 vehicle Bus 객체로 캐스팅이 가능하다면(버스객체가 먼저 Vehicle 객체로 프로모션한 객체라면) 실행
												//하지만 drive(Vehicle vehicle)로 받으면서 Vehicle을 implement 한 Bus타입이 Vehicle 타입으로 프로모션한다.
			Bus bus = (Bus) vehicle;
			bus.checkFare();
		}
		vehicle.run();
	}
}