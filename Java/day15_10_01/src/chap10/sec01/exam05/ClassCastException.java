package chap10.sec01.exam05;

import sec03.exam02.Animal;
import sec03.exam02.Cat;
import sec03.exam02.Dog;

public class ClassCastException {
	public static void main(String[] args) {
		Animal	dog = new Dog(); 
		changeDog(dog);
		
		Cat cat = new Cat();
		changeDog(cat);
	}
	
	public static void changeDog(Animal animal) {
		if(animal instanceof Dog){
		Dog p = (Dog) animal;
		System.out.println("변환 성공");
		}else {
			System.out.println("변환 실패");
		}
	}
}