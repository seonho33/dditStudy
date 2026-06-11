package 영어단어섞기_DSH;

import java.util.Scanner;

public class MathRandom을이용해단어섞기 {
	public static void main(String[] args) {
		
		Scanner scanner = new Scanner(System.in);
		int i = 0;
		String[] area = {"A","B","C","D","E","F","G","H","I","J"};
		
		while(true) {
		
		System.out.println("\n섞고싶은 번호를 적어주세요\n종료하고 싶다면 11을 눌러주세요.");
		
		for(int j=0;j<area.length;j++) {
		System.out.print((j+1)+ "." + area[j] + " ");}
		
		int num = (int)( Math.random()*10);
		i = scanner.nextInt();
		if(i==11) {
			System.out.println("종료합니다.");
			break;
		}
		i = i-1;
			String n = area[num];
			area[num]=area[i];
			area[i]=n;
		
			int count = 1;
		for(String j : area) {
		System.out.print(count+"."+j+" ");
		count++;
		}
				System.out.println("\n바뀐번호 : "+(i+1)+"."+area[num] + " , "+(num+1)+"."+n+"\n");
	}
scanner.close();
	}
	
}