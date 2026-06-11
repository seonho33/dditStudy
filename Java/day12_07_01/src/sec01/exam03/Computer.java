package sec01.exam03;

public class Computer extends Calculator {
	
	
	@Override
	double areaCircle(double r) {
		// TODO Auto-generated method stub
		System.out.println("Computer 객체의 areaCircle() 실행");
		return Math.PI*r*r;
	}
	
}
