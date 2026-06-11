package day08_Review;

import java.util.Arrays;
import java.util.Scanner;

public class BubbleSortPractice {
	public static void main(String[] args) {
		Scanner scanner = new Scanner(System.in);
		
		System.out.println("정렬할 숫자의 갯수를 입력하십시오.");
		int k = scanner.nextInt();
		int[] arr1= new int[k];
		
		for(int i=0;i<arr1.length;i++) {
			System.out.println((i+1)+"번째 숫자를 입력하십시오.");
			arr1[i]=scanner.nextInt();
		}
		
		for(int i=0;i<arr1.length-1;i++) {
			for(int j=0;j<arr1.length-1-i;j++) {
				if(arr1[j]>arr1[j+1]) {
					
					int temp = arr1[j];
					arr1[j] = arr1[j+1];
					arr1[j+1]=temp;
				}
				System.out.println(Arrays.toString(arr1));
			}
			System.out.println("====================");
		}
		System.out.println();
		for(int i:arr1) {
			System.out.print(i+" ");
		}
		scanner.close();
	}
}

