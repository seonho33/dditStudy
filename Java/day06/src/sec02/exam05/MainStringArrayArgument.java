package sec02.exam05;

public class MainStringArrayArgument {
	public static void main(String[] args) {
		
		System.out.println("length: " + args.length);
String[] Qargs= new String[3];
		System.out.println(Qargs.length);
		if(Qargs.length !=2) {
		
			System.out.println("값의 수가 부족합니다.");
			System.exit(0);
		}
		

		String strNum1 = Qargs[0];
		String strNum2 = Qargs[1];
		
		int num1 = Integer.parseInt(strNum1);
		int num2 = Integer.parseInt(strNum2);
	
		
		int result = num1 + num2;
		System.out.println(num1 + " + " + num2 + " = " + result);
	}
}