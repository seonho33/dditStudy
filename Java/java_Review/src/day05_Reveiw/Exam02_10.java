package day05_Reveiw;

public class Exam02_10 {
	public static void main(String[] args) {
		for(int i = 1 ; i <= 10; i++) {
			if(i%2 !=0) {
				continue;  //아래쪽 하지않고 다시 FOR문으로 ...
			}
			System.out.println(i);
		}
	}
}
