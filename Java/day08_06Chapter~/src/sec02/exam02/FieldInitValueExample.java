package sec02.exam02;

public class FieldInitValueExample {
	public static void main(String[] args) {
		FieldInitValue fiv = new FieldInitValue();
		
		System.out.println("byteField: " + fiv.byteField);					//byte
		System.out.println("shortField: " + fiv.shortField);				//short
		System.out.println("intField: " + fiv.intField);					//int
		System.out.println("longField: " + fiv.longField);					//long
		System.out.println("booleanField: " + fiv.booleanField);			//boolean
		System.out.println("charField: " + fiv.charField);					//char
		System.out.println("floatField: " + fiv.floatField);				//float
		System.out.println("doubleField: " + fiv.doubleField);				//double
		System.out.println("arrField: " + fiv.arrField);					//배열
		System.out.println("referenceField: " + fiv.referenceField);		//참조
	}
}