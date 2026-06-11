package sec01.exam06;

public class SportsCar extends Car{
	@Override
	public void speedUp() {speed +=10;
	System.out.println("현재속도 : " + speed);
	}
/*	@Override
	public void stop() {
		System.out.println("스포츠카를 멈춤");
		speed = 0;
	}  final method 이기때문에 Override가 불가능함 */
}