package 학생성적정렬;

import java.util.Scanner;
import java.util.Arrays;

public class 버블정렬과제1 { 
	
	
	public static void main(String[] args) {
		
		Scanner scanner = new Scanner(System.in);
		
		System.out.println("몇 명의 점수를 입력하시겠습니까?");
		
		int k = Integer.parseInt(scanner.nextLine());
		int[] intArr = new int[k];
		String[] NameArr = new String[k];		
		int mod = 0;
		
		for(int j=0;j<intArr.length;j++) {
			System.out.println((j+1 + "번째 이름을 입력하십시오."));
			NameArr[j]=scanner.nextLine();
			System.out.println( (NameArr[j]) +"의 점수를 입력하십시오.");
			intArr[j]=Integer.parseInt(scanner.nextLine());
		}
		do {
		System.out.println("\n하고싶은 과정을 선택하십시오.\n 1.정렬 2.총합 3.평균 4.등수 5.종료");
		mod = scanner.nextInt();
		switch(mod) {
			case 1: BubbleSort(intArr, NameArr);				 //버블정렬
			break;
					
			case 2: SumIntArr(intArr);				 //총합 구하기
			break;
			
			case 3: AvgIntArr(intArr);				 //평균구하기
			break;
			
			case 4: RankIntArr(intArr, NameArr);	 //등수구하기
			break;
			
			case 5:
			break;
			
			default:
			System.out.println("정해진 숫자만 입력해 주십시오");
			break;
			}
		} while(mod!=5);
		
		System.out.println("종료합니다.");
		scanner.close();
	}

	public static void BubbleSort(int[] intArr, String[] NameArr) {
			System.out.println("정렬 전 점수");
		
		for(int no = 0; no<=intArr.length-1;no++) {

			System.out.print((no+1)+"." + NameArr[no] + intArr[no]+"점 " );
			
		}
		
				for(int i=0; i<intArr.length-1;i++) {	
					for(int j=0; j<intArr.length-1-i;j++) {
						if(intArr[j]>intArr[j+1]) {		
							
							int temp = intArr[j];
							intArr[j]= intArr[j+1];
							intArr[j+1]= temp;
							
							String temp2 = NameArr[j];
							NameArr[j]= NameArr[j+1];
							NameArr[j+1]=temp2;
									
						}
						System.out.println(Arrays.toString(intArr));
					}
					System.out.println("-----------------------");
				}
				System.out.println("정렬 후 점수 \n ");
				
				for(int no1 = 0; no1<=intArr.length-1;no1++) {
				System.out.print((no1+1)+"." + NameArr[no1] + intArr[no1]+"점 " );}
				System.out.println();
		}
	
	public static void SumIntArr(int[] intArr) {
		
		int sum =0;
		for(int score : intArr) {
			sum += score;
		}
		System.out.println("점수의 총 합은 "+ sum + "점 입니다.");
	}
	
	public static void AvgIntArr(int[] intArr) {
		
		int sum =0;
		for(int score : intArr) {
			sum += score;
		}
		int avg=sum/intArr.length;
		System.out.println("점수의 평균은 "+avg+"점 입니다.");
	}
	
	public static void RankIntArr(int[] intArr, String[] NameArr) {
		
		Scanner scanner = new Scanner(System.in);
		
		for(int i=0; i<intArr.length-1;i++) {	
			for(int j=0; j<intArr.length-1-i;j++) {
				if(intArr[j]<intArr[j+1]) {		
					
					int temp = intArr[j];
					intArr[j]= intArr[j+1];
					intArr[j+1]= temp;}
					
					String temp2 = NameArr[j];
					NameArr[j]= NameArr[j+1];
					NameArr[j+1]=temp2;
			}
		}
		for(int k=0;k<intArr.length;k++) {
		System.out.print((k+1)+"등 "+NameArr[k]+" "+intArr[k]+"점\n");
		}
	}
}