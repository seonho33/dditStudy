package chap11.sec01.exam16;

public class StringIndexOfExample {
	public static void main(String[] args) {
		String subject = "자바 프로그래밍";
		
		int location = subject.indexOf("프로그래밍");
		System.out.println(location);		//"프로그래밍"이 3번째 글자부터 시작
		
		if(subject.indexOf("자바")!=-1) {
			System.out.println("자바와 관련된 책이군요");
		}else {
			System.out.println("자바와 관련없는 책이군요");
		}
	}
}
