package chap10.sec01.exam02;

public class ArrayIndexOutOufBoundsExceptoneExample {
	public static void main(String[] args) {
		if(args.length==2) {
			String data1= args[0];
			String data2=args[2];
			System.out.println("args[0]: " +data1);
			System.out.println("args[1]: " +data2);
		}else {
			System.out.println("두 개의 실행 매개값이 필요합니다.");
			System.out.println(args.length);
		}
	}
}