package GenericEnumTest;

import java.util.ArrayList;
import java.util.List;

public class T04WildCardTest {
/*	
	와일드카드에 대하여...
	
	와일드카드 (?) 는 제너릭 타입을 이용한 타입 안전한 코드를 위해 사용되는
	특별한 종류의 인수(Argument)로서, 변수선언, 객체생성 및 메서드 정의할 때 사용된다. 
	
	<? extends T> 	=> 와일드카드의 상한 제한. T와 그 자손들만 가능
	<? super T> 	=> 와일드카드의 하한 제한. T와 그 조상들만 가능
	<?>				=> 모든 가능한 타입 가능.
*/	
	
	public static <K> void main(String[] args) {
	
		List<String> strList = new ArrayList<String>();
		List<Integer> intList = new ArrayList<Integer>();
		List<?> wildList = new ArrayList<String>();
		List<?> wildList2 = new ArrayList<Integer>();
		
	////////////////////////////////////////////////////////////

		FruitBox<Fruit> fruitBox = new FruitBox<>();
		fruitBox.add(new Apple());
		fruitBox.add(new Grape());
		
		FruitBox<Apple> appleBox = new FruitBox<>();
		appleBox.add(new Apple());
		appleBox.add(new Apple());
		
		FruitBox<Garbage> garbageBox = new FruitBox<>();
		garbageBox.add(new Garbage("음식물"));
		garbageBox.add(new Garbage("담배꽁초"));
		
		
		Juicer.makeJuice(fruitBox);
		Juicer.makeJuice(appleBox );
	}	
}

class Garbage extends Fruit{
	private String name;
	
	public Garbage(String name){
		super(name);
		this.name = name;
	}

	@Override
	public String toString() {
		return "쓰레기 =" + name;
	}

}

class Juicer {
	/*
	 * static <K extends Fruit> void makeJuice(FruitBox<K> box) {
	 */	
	static void makeJuice(FruitBox<? extends Fruit> box) {
	
	String fruitListStr = "";
		
		int cnt = 0;
		
		for(Object f : box.getFruitList()) {
			if(cnt == 0) {
				fruitListStr += f;
			}else {
				fruitListStr += ", " + f;
			}
			cnt++;
		}
		System.out.println(fruitListStr + " => 주스 완성!!!");
	}
}

class Fruit {
	private String name;

	public Fruit(String name) {
		this.name=name;
	}
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "과일[" + name + "]";
	}
}

class Apple extends Fruit {
	public Apple() {
		super("사과");
	}
}

class Grape extends Fruit{
	public Grape() {
		super("포도");
	}
}

/*
	과일상자
	@param <T>
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