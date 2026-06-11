package r_07_sec01.exam01;

public class DmbCellPhoneExample {
	public static void main(String[] args) {
		//DmbCellphone 객체생성
		DmbCellPhone dmbCellPhone = new DmbCellPhone("자바폰", "검정", 10);
		
		//Cellphone 클래스로부터 상속받은 필드
		System.out.println("모델: " + dmbCellPhone.model);
		System.out.println("색상: " + dmbCellPhone.color);
		
		//DmbCellPhone 클래스의 필드
		System.out.println("채널: " + dmbCellPhone.channel);
		
		//CellPhone 클래스로부터 상속받은 메소드 호출
		dmbCellPhone.powerOn();
		dmbCellPhone.bell();
		dmbCellPhone.sendVoice("여보세요");
		dmbCellPhone.receiveVoice("안녕하세요 저는 홍길동입니다.");
		dmbCellPhone.sendVoice("아 네");
		dmbCellPhone.hangUp();
		
		//dmb 클래스의 메소드 호출
		dmbCellPhone.turnOnDmb();
		dmbCellPhone.changeChannelDmb(15);
		dmbCellPhone.turnOffDmb();
	}
}
