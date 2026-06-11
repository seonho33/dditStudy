package chap08.sec02.exam05;

public class ImplementationC implements InterfaceC {
	
	@Override
	public void methodA() {
		System.out.println("ImplementationC-mathodA() 실행");
	}

	@Override
	public void methodB() {
		System.out.println("ImplementationC-mathodB() 실행");
	}

	@Override
	public void methodC() {
		System.out.println("ImplemnetationC-mathodC() 실행");
	}

}
