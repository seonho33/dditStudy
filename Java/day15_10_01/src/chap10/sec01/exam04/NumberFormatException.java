package chap10.sec01.exam04;

public class NumberFormatException {
	public static void main(String[] args) {
		String data1 = "100";
		String data2 = "a200";
		
		int value1 = Integer.parseInt(data1);
		int value2 = Integer.parseInt(data2);
		
		int result = value1+value2;
		System.out.println(result);
		
	}
}
