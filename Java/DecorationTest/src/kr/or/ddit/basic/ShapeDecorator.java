package kr.or.ddit.basic;

public abstract class ShapeDecorator implements Shape {

	protected Shape decoratedShape;		//기능을 덧붙일 대상 객체
	
	public ShapeDecorator(Shape decoratedShape) {
		super();
		this.decoratedShape = decoratedShape;
	}
	
	@Override
	public void draw() {
		// TODO Auto-generated method stub
		
	}
}
