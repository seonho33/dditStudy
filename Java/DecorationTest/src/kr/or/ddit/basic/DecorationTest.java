package kr.or.ddit.basic;

public class DecorationTest {
	public static void main(String[] args) {
		Shape circle = new Circle();
		circle.draw();
		
		Shape rect = new Rectangle();
		rect.draw();
		
		System.out.println("----------------------------");
		
		Shape blueCircle = new BlueShapeDecorator(new Circle());
		blueCircle.draw();
		
		System.out.println("-----------------------------");

		Shape dotteRect = new DottedShapeDecorator(new Rectangle());
		dotteRect.draw();
		
		System.out.println("-----------------------------");
		Shape dbc = new DottedShapeDecorator(new BlueShapeDecorator(new Rectangle()));
		dbc.draw();
	}
}
