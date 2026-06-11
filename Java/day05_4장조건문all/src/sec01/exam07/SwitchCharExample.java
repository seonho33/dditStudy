package sec01.exam07;

public class SwitchCharExample {
	public static void main(String[] args) {

		int Char_data = (int)(Math.random()*3)+65;
		
		char grade = (char)Char_data ;
		
		switch(grade) {
		case 'A':
		case 'a':
			System.out.println("우수 회원입니다.");
			break;
		case 'B':
		case 'b':
			System.out.println("일반 회원입니다.");
			break;
		default:
			System.out.println("손님입니다.");
		}
	}
}
