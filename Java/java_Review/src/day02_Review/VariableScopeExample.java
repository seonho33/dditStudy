package day02_Review;

public class VariableScopeExample {
	public static void main(String[] args) {
		int v1 = 15;
		int v2 = 0;
		if(v1>10) {
/*		int v2; 			변수선언은 해당 블록에서만 유효함*/
			v2 = v1 -10;
		}
		int v3 = v1 + v2 +5; //변환은 블록이 지나서도 유효 v2= 5
		
		System.out.println(v3);
	}
}