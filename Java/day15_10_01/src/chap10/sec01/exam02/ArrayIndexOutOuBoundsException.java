package chap10.sec01.exam02;

public class ArrayIndexOutOuBoundsException {
	public static void main(String[] args) {
		System.out.println("args배열의 크기 : "+args.length);
		
		String data1 = args[0];
		String data2 = args[1];
		
		System.out.println("arg[0]: "+ data1);
		System.out.println("arg[1]: "+ data2);
	}
}
