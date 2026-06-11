package r_07_sec02.exam03;

public class HankookTire extends Tire {
	//필드
	//생성자(부모클래스의 생성자가 받는 파라미터값이 있기때문에 기본생성자로 생략되지 않으므로 직접 호출해야함...
	
	public HankookTire(String location, int maxRotation) {
		super(location,maxRotation);
	}
	
	public boolean roll() {
		++accumulatedRotation;
		if(accumulatedRotation<maxRotation) {
			System.out.println(location + " HankookTire 수명: "+ (maxRotation-accumulatedRotation) + "회");
			return true;
		}else {
			System.out.println("***"+location +" HankookTire 펑크 ***");
			return false;
		}
	}
}
