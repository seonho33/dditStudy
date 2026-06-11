package 계산기_DSH;

public class Calculator {

	void powerOn() {
		System.out.println("전원을 켭니다.");
	}
	double plus(double x, double y) {
		double reslut= x+y;
		return reslut;
	}
	double minuse(double x, double y) {
		double result = x - y;
		return result;
	}
	double multi (double x, double y) {
		double result = x*y;
		return result;
	}
	static double div (double x, double y) {
		double result = x/y;
		return result;
	}
	void powerOff() {
		System.out.println("전원을 끕니다.");
	}
}
