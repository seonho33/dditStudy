package day03_Review;

public class CastingExample {
	public static void main(String[] args) {
		int intValue = 44032;
		char charValue = (char) intValue;
		System.out.println(charValue);
		
		long longValue = 500;
		intValue = (int) longValue;
		System.out.println(intValue);
		
		double doublevalue = 3.14;
		intValue= (int) doublevalue;
		System.out.println(intValue);
		
		byte byteValue = 3;
		char charValue1 = (char)byteValue;
		System.out.println(charValue1);
		
	}
}
