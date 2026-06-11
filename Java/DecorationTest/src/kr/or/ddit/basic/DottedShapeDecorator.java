package kr.or.ddit.basic;

public class DottedShapeDecorator extends ShapeDecorator{

	public DottedShapeDecorator(Shape decoratedShape) {
		super(decoratedShape);
	}
	
	@Override
	public void draw() {
		decoratedShape.draw(); // 기본 기능 호출..
		
		executeExtraFunc();		// 기본 객체가 가지지 못한 추가 기능...
	}

	private void executeExtraFunc() {
		System.out.println("경계선을 점선으로 설정합니다.");
	}
}
