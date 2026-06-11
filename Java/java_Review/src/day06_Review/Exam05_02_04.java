package day06_Review;

public class Exam05_02_04 {
	public static void main(String[] args) {
		int[] scores = {83,90,87};
		
		int sum=0;
		for(int i =0;i<scores.length;i++) {
			sum += scores[i];
		}
		System.out.println("총합 : " + sum);
		
		int sum2 = Exam05_02_02.add(scores);
		System.out.println("총합 : " + sum2);
		
		double avg = (double)sum/scores.length;
		System.out.println("평균 : " + avg);
		
	}
}