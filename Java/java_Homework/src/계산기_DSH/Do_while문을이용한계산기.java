package 계산기_DSH;

import java.util.Scanner;

public class Do_while문을이용한계산기 {
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		
		Calculator myCalc = new Calculator();
		
		myCalc.powerOn();
		double x = Double.parseDouble(scanner.nextLine());
		
		String z;
		double y;
		
		Outter : do {
			z = scanner.nextLine();
				switch(z) {
				case "+" :
					 y = Double.parseDouble(scanner.nextLine());
					double result = myCalc.plus(x, y);
					x=result;
					System.out.println(result + "\n종료하시려면 Q 초기화 하시려면 X를 누르십시오.");
				break;
				
				case "-" :
					 y = Double.parseDouble(scanner.nextLine());
					double result2 = myCalc.minuse(x, y);
					x=result2;
					System.out.println(result2 + "\n종료하시려면 Q 초기화 하시려면 X를 누르십시오.");
				break;
				
				case "*" : 
					 y = Double.parseDouble(scanner.nextLine());
					double result3 = myCalc.multi(x, y);
					x=result3;
					System.out.println(result3 + "\n종료하시려면 Q 초기화 하시려면 X를 누르십시오.");
				break;
				
				case "/" :
					 y = Double.parseDouble(scanner.nextLine());
					double result4 = Calculator.div(x, y);
					x=result4;
					System.out.println(result4 + "\n종료하시려면 Q 초기화 하시려면 X를 누르십시오.");
				break;
				
				case "x":
				case "X":
					String p;
					p=scanner.nextLine();
					if(p.equals("q")||p.equals("Q")) {
					break Outter; 
					}
					x=Double.parseDouble(p);
					break;
				
				case "q":
				case "Q":
					break;
				
					
				default : 
					System.out.println("연산자를 다시 입력하십시오");
				break;
				}
		}while(!z.equals("Q")&&!z.equals("q"));
		myCalc.powerOff();
		scanner.close();
	}
}