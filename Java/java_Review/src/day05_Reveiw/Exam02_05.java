package day05_Reveiw;

public class Exam02_05 {
	public static void main(String[] args) {
		for(int m=2;m<=19;m++) {
			System.out.println("*** " + m + "단 ***");
			for( int n=1; n<=9; n++) {
				System.out.println(m + "x" + n + " = " + (m*n));
			}
		}
	}
}
