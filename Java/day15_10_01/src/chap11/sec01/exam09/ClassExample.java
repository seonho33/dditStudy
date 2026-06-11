package chap11.sec01.exam09;

public class ClassExample {
	public static void main(String[] args) throws Exception {
		//첫번째 방법
		Class clazz1 = Car.class;
		
		//두번째 방법
		Class clazz2 = Class.forName("chap11.sec01.exam09.Car");
		
		//세번째 방법
		
		Car car = new Car();
		Class clazz3 = car.getClass();
		
		System.out.println(clazz1.getName());
		System.out.println(clazz2.getSimpleName());
		System.out.println(clazz3.getPackage().getName());
		System.out.println(clazz1.toString());
		System.out.println(clazz2.toString());
		System.out.println(clazz1.equals(clazz3));
		System.out.println(car.toString());
	}
}