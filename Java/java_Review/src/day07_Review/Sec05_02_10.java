package day07_Review;

public class Sec05_02_10 {
	public static void main(String[] args) {
		int[] scores = {95,71,84,93,87};
		
		int sum=0;
		for (int i:scores) {
			sum+=i;
		}
		System.out.println("점수총합 : "+sum);
		
		double avg = (double)sum/scores.length;
				System.out.println("점수평균 : " + avg);
	}
}