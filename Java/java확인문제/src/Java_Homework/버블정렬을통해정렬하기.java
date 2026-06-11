package Java_Homework;

import java.util.Scanner;
import java.util.Arrays;

public class 버블정렬을통해정렬하기 { 
	
	
	public static void main(String[] args) {
		
		Scanner scanner = new Scanner(System.in);
		
		System.out.println("몇 개의 점수를 입력하시겠습니까?");
		
		int k = scanner.nextInt();
		
		int[] intArr = new int[k];
		int mod = 0;
		
		for(int j=0;j<intArr.length;j++) {
			System.out.println( (j+1) +"번째 점수를 입력하십시오.");
			intArr[j]=scanner.nextInt();
		}
		
		int[] newIntArr = new int[intArr.length];					//등수 구할때를 위해 백업하기
		System.arraycopy(intArr, 0, newIntArr, 0, intArr.length);
		
		do {
		System.out.println("\n하고싶은 과정을 선택하십시오.\n 1.정렬 2.총합 3.평균 4.등수 5.종료");
		mod = scanner.nextInt();
		switch(mod) {
			case 1: BubbleSort(intArr);				 //버블정렬
			break;
			
			case 2: SumIntArr(intArr);				 //총합 구하기
			break;
			
			case 3: AvgIntArr(intArr);				 //평균구하기
			break;
			
			case 4: RankIntArr(intArr, newIntArr);	 //등수구하기
			break;
			
			default:
			System.out.println("정해진 숫자만 입력해 주십시오");
			break;
			}
		} while(mod!=5);
		
		System.out.println("종료합니다.");
	}

	private static void BubbleSort(int[] intArr) {
		
		System.out.println("정렬 전 점수 \n" + Arrays.toString(intArr) + "\n");
				for(int i=0; i<intArr.length-1;i++) {	
					for(int j=0; j<intArr.length-1-i;j++) {
						if(intArr[j]>intArr[j+1]) {		
							
							int temp = intArr[j];
							intArr[j]= intArr[j+1];
							intArr[j+1]= temp;
						}
						System.out.println(Arrays.toString(intArr));
					}
					System.out.println("-----------------------");
				}
				System.out.println("정렬 후 점수 \n " + Arrays.toString(intArr));
		}
	

	private static void SumIntArr(int[] intArr) {
		
		int sum =0;
		for(int score : intArr) {
			sum += score;
		}
		System.out.println("점수의 총 합은 "+ sum + "점 입니다.");
	}
	
	private static void AvgIntArr(int[] intArr) {
		
		int sum =0;
		for(int score : intArr) {
			sum += score;
		}
		int avg=sum/intArr.length;
		System.out.println("점수의 평균은 "+avg+"점 입니다.");
	}
	
	private static void RankIntArr(int[] intArr, int[] newIntArr) {
		
		Scanner scanner = new Scanner(System.in);
		
		for(int i=0; i<intArr.length-1;i++) {	
			for(int j=0; j<intArr.length-1-i;j++) {
				if(intArr[j]<intArr[j+1]) {		
					
					int temp = intArr[j];
					intArr[j]= intArr[j+1];
					intArr[j+1]= temp;}
			}
		}
		System.out.println("몇번째 점수의 등수를 구하겠습니까?");
		System.out.println(Arrays.toString(newIntArr));
		int R = scanner.nextInt();
		int O = 0;
		for(;intArr[O]!=newIntArr[R-1];O++) {
			
		}
		System.out.println(R + "번째 점수인 " + newIntArr[R-1] + "점은 " + (O+1) +"등 입니다.");
	}
	
}
	