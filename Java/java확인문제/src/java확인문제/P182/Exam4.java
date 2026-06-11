package java확인문제.P182;

public class Exam4 {
	public static void main(String[] args) {
		for(int x = 1; x<=10;x++) {
			for(int y=1; y<=10;y++) {
				if(4*x+5*y==60) {
					System.out.print("("+x+","+y+")");
				}
			}
		}
	}
}
