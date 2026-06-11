package r_07_sec01.exam03;

public class Computer extends Calculator{
	@Override
	double areaCircle(double r) {
		System.out.println("Coumputer 객체의 areaCircle() 실행");
		return Math.PI*r*r;
	}
}