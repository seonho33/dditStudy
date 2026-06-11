package sec01.exam01;

public class IfExample {
	public static void main(String[] args) {
		int score = 93;
		
		if(score>=90) {
			System.out.println("점수가 90보다 틉니다.");
			System.out.println("등급은 A입니다.");
		}

		if(score<90)
			System.out.println("점수가 90보다 작습니다."); // 여기까지만 두번째 if문, {}로 묶여있지 않다면 다음 세미콜론까지만 if문

		System.out.println("등급은 B입니다.");
	}
}