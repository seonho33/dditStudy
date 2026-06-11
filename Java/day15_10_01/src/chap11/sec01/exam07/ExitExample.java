package chap11.sec01.exam07;

public class ExitExample {
	public static void main(String[] args) {
		for(int i=0;i<10;i++) {
			System.out.print((5-i)+ "...");
			if(i==5) {
				System.out.print("\nSystem.exit\n");
				//System.exit(0);
				break;
				//return; //메서드 하나만 종료....
			}
		}
		System.out.println("마무리 코드");
	}
}
