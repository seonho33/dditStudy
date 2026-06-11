package Java_Homework;

import java.util.ArrayList;
import java.util.List;

public class T04WildCardTest {
/*
 	와일드카드에 대하여...
 	
 	와일드카드(?)는 제너릭 타입을 이용한 타입 안전한 코드를 위해 사용되는 특별한
 	종류의 인수(Argument)로서, 변수선언, 객체생성 및 메서드 정의할 때 사용된다.
 	
 	<? extends T> => 와일드카드의 상한 제한. T와 그 자손들만 가능
 	<? super T>   => 와일드카드의 하한 제한. T와 그 조상들만 가능
 	<?>			  => 모든 가능한 타입 가능.
*/
	public static void main(String[] args) {
		
		List<String> strList = new ArrayList<String>();
		List<Integer> intList = new ArrayList<Integer>();
		
		List<?> strList2 = new ArrayList<String>();
		List<?> intList2 = new ArrayList<Integer>();
		
		
		
	}
}

class Fruit {
	private String name; // 과일이름

	public Fruit(String name) {
		super();
		this.name = name;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	@Override
	public String toString() {
		return "과일(" + name + ")";
	}
}

class Apple extends Fruit {

	public Apple() {
		super("사과");
	}
}

class Grape extends Fruit {

	public Grape() {
		super("포도");
	}
}

/**
 * 과일상자
 * @param <T>
 */
class FruitBox<T> {
	private List<T> fruitList;
	
	public FruitBox() {
		fruitList = new ArrayList<>();
	}

	public List<T> getFruitList() {
		return fruitList;
	}
	
	public void add(T fruit) {
		fruitList.add(fruit);
	}
	
}


