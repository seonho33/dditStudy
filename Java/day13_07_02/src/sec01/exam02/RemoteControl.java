package sec01.exam02;

public interface RemoteControl {
	public int MAX_VOLUME =10;
	public int MIN_VOLUME=0;

	//추상메서드
	public void turnOn();
	public void turnOff();
	public void SetVolume(int volume);
}
