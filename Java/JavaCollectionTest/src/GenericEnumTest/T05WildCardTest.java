package GenericEnumTest;

import java.util.ArrayList;
import java.util.List;

public class T05WildCardTest {
	
	//장바구니 항복조회를 위한 메서드1
	public static void displayCartItemInfo1(Cart<?> cart) {
		System.out.println("== 장바구니에 담긴 항목들 ==");
		for(Object obj : cart.getCartList()) {
			System.out.println(obj);
		}
		System.out.println("-----------------------");
	}

		public static void displayCartItemInfo2(Cart<? extends Drink> cart) {
			System.out.println("== 장바구니에 담긴 항목들 ==");
			for(Object obj : cart.getCartList()) {
				System.out.println(obj);
			}
			System.out.println("-----------------------");			
	}

	public static void displayCartItemInfo3(Cart<? super Meat> cart) {
		System.out.println("== 장바구니에 담긴 항목들 ==");
		for(Object obj : cart.getCartList()) {
			System.out.println(obj);
		}
		System.out.println("-----------------------");		
	}
	
	
	public static void main(String[] args) {
		
		Cart<Food> foodCart = new Cart<>();
		foodCart.addItem(new Meat("소고기등심", 100000));
		foodCart.addItem(new Meat("이베리코", 100000));
		foodCart.addItem(new Juice("망고주스", 3000));
		foodCart.addItem(new Coffee("아이스아메리카노", 2000));
		
		Cart<Meat> meatCart = new Cart<>();
		meatCart.addItem(new Meat("소고기등심",100000));
		meatCart.addItem(new Meat("이베리코",100000));
		
		Cart<Drink> drinkCart = new Cart<>();
		drinkCart.addItem(new Juice("망고주스", 3000));
		
		displayCartItemInfo1(meatCart);
		displayCartItemInfo1(drinkCart);
		displayCartItemInfo1(foodCart);
		
		//displayCartItemInfo2(meatCart);
		displayCartItemInfo2(drinkCart);
		//displayCartItemInfo2(foodCart);

		displayCartItemInfo3(meatCart);
		//displayCartItemInfo3(drinkCart);
		displayCartItemInfo3(foodCart);
	}
}

class Food {
	private String name;		// 음식 이름
	private int price;			// 음식 가격
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public Food(String name, int price) {
		super();
		this.name = name;
		this.price = price;
	}
	
	@Override
	public String toString() {
		return this.name + "(" + this.price + "원)";
	}
}

class Meat extends Food {

	public Meat(String name, int price) {
		super(name, price);
	}
}

class Drink extends Food {

	public Drink(String name, int price) {
		super(name, price);
	}
}

class Juice extends Drink {

	public Juice(String name, int price) {
		super(name, price);
	}
}

class Coffee extends Drink {

	public Coffee(String name, int price) {
		super(name, price);
	}
}

/*
	장바구니
	<T> 항목
*/

class Cart<T> {
	private List<T> cartList;
	
	public Cart() {
		cartList = new ArrayList<>();
	}

	public List<T> getCartList() {
		return cartList;
	}
	
	public void addItem(T item) {
		this.cartList.add(item);
	}
}