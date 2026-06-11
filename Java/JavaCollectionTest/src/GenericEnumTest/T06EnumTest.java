package GenericEnumTest;

class Flower {
	static final int ROSE = 1;
	static final int TULIP =2;
}

class Animal {
	static final int LION = 1;
	static final int TIGER =2;
}

public class T06EnumTest {
	
	/*
	 * 열거형을 선언하는 방법
	 * enum 열거형이름 { 상수값1, 상수값2, ...,상수값n};
	*/
	
	// City 열거형 객체 선언 (기본값을 이용하는 열거형)
	public enum City {서울, 부산, 대구, 광주, 대전};
	
	public enum HomeTown {부산, 목포, 여수, 대전, 대구, 광주, 울산};
	
	// 데이터값을 임의로 지정한 열거형 객체 선언
	public enum Season{
		봄("3월부터 5월까지",1), 여름("6월부터 8월까지",2), 가을("9월부터 11월까지",3), 겨울("12월부터 2월까지",4);
		
		//괄호속의 값이 저장될 변수 선언
		private String str;
		private int num;
		//생성자 만들기(열거형의 생성자는 제어자가 묵시적으로 'private' 이다.)
		Season(String data,int num){	// ==>private Season(String data){ 와 같음
			str = data;
			this.num = num;
		}
		public String getStr() {
			return str;
		}
	}
	
	public static void main(String[] args) {
		
		/* int a = Animal.LION;
		 * 
		 * if(a==Flower.ROSE) {
		 * 
		 * System.out.println("장미입니다."); } */
		/*
			열거형에서 사용되는 주요 메서드
			
			1. name() => 열거형 상수의 이름을 문자열로 반환한다.
			2. ordinal() => 열거형 상수가 정의된 순서값을 반환한다.
							(기본적으로 0부터 시작)
			3. valueOf("열거형상수이름") => 지정된 열거형에서 '열거형상수이름'과 일치하는 열거형 상수를 반환한다.
			
		*/
		//열거형 객체변수 선언
		City myCity1;
		City myCity2;
		
		//열거형 객체변수에 값 저장하기
		myCity1 = City.서울;
		myCity2 = City.valueOf("서울");
		
		System.out.println("myCity1 : " + myCity1.name());
		System.out.println("myCity2의 ordinal : " + myCity2.ordinal());
		System.out.println(City.valueOf("대전"));
		System.out.println("============================");
		
		Season ss = Season.겨울;
		System.out.println("name => " + ss.name());
		System.out.println("ordinal => " + ss.ordinal());
		System.out.println("getter메서드 => " + ss.getStr());
		System.out.println("------------------------------");
		
		//열거형이름.values() => 열거형상수 객체배열을 리턴함.
		Season[] enumArr = Season.values();
		for(Season ss2 : enumArr) {
			System.out.println(ss2.name() + " : " + ss2.getStr());
		}
		
		for(City city : City.values()) {
			System.out.println(city.name() + " : " + city.ordinal());
		}
		
		///////////////////////////////////////////////////////
		
		City myCity = City.대구;
		
		System.out.println(myCity == City.서울);
		System.out.println(myCity == City.대전);
		System.out.println(myCity == City.대구);
		
		System.out.println("대구 ==> " + myCity.compareTo(City.대구));
		System.out.println("부산 ==> " + myCity.compareTo(City.부산));
		System.out.println("서울 ==> " + myCity.compareTo(City.서울));
		
	}
}