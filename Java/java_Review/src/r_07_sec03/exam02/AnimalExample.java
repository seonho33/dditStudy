package r_07_sec03.exam02;

public class AnimalExample {
	public static void main(String[] args) {
		Dog dog = new Dog();
		Cat cat = new Cat();
		Bird bird = new Bird("조류");
		
		dog.sound();
		cat.sound();
		bird.sound();
		
		System.out.println(dog.kind);
		System.out.println(cat.kind);
		System.out.println(bird.kind);
		
		//변수의 자동타입변환
		Animal animal = null;
		animal = new Dog();
		animal.sound();
		
		animal = new Cat();
		animal.sound();
		animal = new Bird();
		animal.sound();

		//메소드의 다형성
		animalSound(new Dog());
		animalSound(new Cat());
		animalSound(new Bird());
		
	}
	public static void animalSound(Animal animal) {
		System.out.println(animal.kind);
		animal.sound();
	}
}
