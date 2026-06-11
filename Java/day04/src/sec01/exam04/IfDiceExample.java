package sec01.exam04;

public class IfDiceExample {
	public static void main(String[] args) {
		int num = (int) (Math.random()*6) +1;
		
		if(num==1) {
			System.out.println("1이 나왔습니다.");
		}
		if(num==2) {
			System.out.println("2가 나왔습니다.");
		}
		if(num==3) {
			System.out.println("3이 나왔습니다.");
		}
		if(num==4) {
			System.out.println("4가 나왔습니다.");
		}
		if(num==5) {
			System.out.println("5가 나왔습니다.");
		}
		if(num==6) {
			System.out.println("6이 나왔습니다.");
		}
	}
}