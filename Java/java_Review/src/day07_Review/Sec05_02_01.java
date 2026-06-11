package day07_Review;

public class Sec05_02_01 {
	public static void main(String[] args) {
		int[] scores = { 83, 90 ,87};
		
		for(int i=0; i<scores.length; i++) {
			System.out.println("scores["+i+"] : " + scores[i]);
		}
		int sum = 0;
		for(int i=0;i<3;i++) {
			sum+=scores[i];
		}

		System.out.println("총합 : " + sum);
		double avg = (double) sum/3;
		System.out.println("평균 : " + avg);
	}
}