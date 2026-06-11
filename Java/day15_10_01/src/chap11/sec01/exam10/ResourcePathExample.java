package chap11.sec01.exam10;

import chap11.sec01.exam09.Car;

public class ResourcePathExample {
	public static void main(String[] args) {
		Class clazz = Car.class;
		
		String photo1Path = clazz.getResource("photo1.jpg").getPath();
		String photo2Path = clazz.getResource("images/photo.jpg").getPath();
		
		System.out.println(photo1Path);
		System.out.println(photo2Path);
	}
}
