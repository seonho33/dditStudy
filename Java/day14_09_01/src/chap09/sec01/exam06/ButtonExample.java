package chap09.sec01.exam06;

public class ButtonExample {
	public static void main(String[] args) {
		Button btn = new Button();
		Button.OnClickListener listener = new CallListener();
		
		btn.setOnClikckListener(listener);
		btn.touch();
		
		listener = new MessageListener();
		
		btn.setOnClikckListener(listener);
		btn.touch();
	}
}