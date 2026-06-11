package kr.or.ddi.basic;

import java.util.Arrays;

public class BubbleSortTest {
	public static void main(String[] args) {
		
		int intArr[] = {9,8,7,6,5,4,3,2,1,0};
		
		System.out.println("정렬 전 : \n" + Arrays.toString(intArr));
		
		bubbleSort(intArr);
		
		System.out.println("정렬 후 : \n" + Arrays.toString(intArr));
		}
	
	/**
	 * 버블정렬: 처음부터 차례대로 인접한 두 수를 비교하여 왼쪽 수가 더 큰 경우
	 * 자리를 바꾸는 정렬 기법
	 * (원소의 이동의 거품이 수면으로 올라오는 듯한 모습을 보이기 때문에 지어진 이름)
	 * 
	 */
	private static void bubbleSort(int[] intArr) {

		for(int i=0; i<intArr.length-1; i++) {
			for(int j=0; j<intArr.length-1-i; j++) {
				if(intArr[j] > intArr[j+1]) { // 왼쪽 수가 더 큰경우..
					//스와핑
					int temp = intArr[j];
					intArr[j]=intArr[j+1];
					intArr[j+1]=temp;
				}
				System.out.println(Arrays.toString(intArr));
			}
			System.out.println("-----------------------------");
		}
		
	}
}

