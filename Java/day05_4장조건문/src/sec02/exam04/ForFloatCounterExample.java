package sec02.exam04;

public class ForFloatCounterExample {
	public static void main(String[] args) {
		for(float x= 0.1f; x<=1 ; x+=0.1f) {
			System.out.printf("%4.1f\n",x);
		}
	}
}
