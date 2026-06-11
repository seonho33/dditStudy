package day05_Reveiw;

public class Exam02_02 {
	public static void main(String[] args) {
		int sum=1;
		
		for(int j=1,i=2; j<=4; j++) {
			sum*=i;
		}
		
		System.out.println("2의 4승: " + sum);
	}
}
