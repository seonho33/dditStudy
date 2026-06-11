package sec01.exam01;

public class DmbCellphone extends CellPhone {
	//필드
	int channel;
	
	//생성자
	DmbCellphone(String model, String color, int channel){
		this.model = model;
		this.color = color;
		this.channel = channel;
	}
	
	DmbCellphone(String model){
		this.model = model;
		this.color = "흰색";
		this.channel = 0;
	}
	
	DmbCellphone() {
		this.model = "자바폰";
		this.color = "흰색";
		this.channel = 0;
	}
	
	DmbCellphone(String model, String color){
		this.model = model;
		this.color = color;
		this.channel = 0;
	}
	
	
	void turnOnDmb() {
		System.out.println("채널 " + channel + "번 DMB 방송 수신을 시작합니다.");
	}
	void changeChannelDmb(int channel) {
		this.channel = channel;
		System.out.println("채널 " + channel + "번으로 바꿉니다.");
	}
	void turnOffDmb() {
		System.out.println("DMB 방송 수신을 멈춥니다.");
	}
}