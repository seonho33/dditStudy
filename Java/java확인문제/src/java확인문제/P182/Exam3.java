package java확인문제.P182;

public class Exam3 {
	public static void main(String[] args) {
		
		int dic1 = 0;
		int dic2 = 0;
		
		while(dic1+dic2!=5) {
			dic2 = (int)(Math.random()*6+1);
			dic1 = (int)(Math.random()*6+1);
			System.out.println("("+dic1+","+dic2+")");
		}
		
	}
}
