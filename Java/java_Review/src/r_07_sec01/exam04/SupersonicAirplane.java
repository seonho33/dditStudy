package r_07_sec01.exam04;

public class SupersonicAirplane extends Airplane {
	public static final int NORMAL = 1;
	public static final int SUPERSONIC = 2;
	public int flymode = NORMAL;
	
	@Override
	public void fly() {
		if(flymode == SUPERSONIC) {
			System.out.println("초음속비행입니다.");
		}else {
			super.fly();
		}
	}
}
