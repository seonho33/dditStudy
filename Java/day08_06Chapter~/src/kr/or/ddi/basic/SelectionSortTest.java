package kr.or.ddi.basic;

import java.util.Arrays;

public class SelectionSortTest {
	public static void main(String[] args) {
		
		int[] intArr = {5,7,9,0,3,1,6,2,4,8};
		
		System.out.println("정렬 전 : " + Arrays.toString(intArr));
		
		selectionSort(intArr); // 선택 정렬 시작
		
		System.out.println("정렬 후 : " + Arrays.toString(intArr));
		
		
		
	}

	/**
	 * 선택정렬: 가장 작은 수를 선택하여 차례대로 좌측부터 채워(바꿔)가며 정렬한다
	 * @param intArr 정렬시킬 배열
	 */
	
	private static void selectionSort(int[] intArr) {
		// TODO Auto-generated method stub
		for(int i = 0 ; i < intArr.length; i++) {
			
			int minIndex = i;
			
			for(int j=i+1; j<intArr.length;j++) {
				if(intArr[minIndex] > intArr[j]) {
					minIndex=j;
				}
			}
			
			//스와핑 작업...
			int temp = intArr[i];
			intArr[i] = intArr[minIndex];
			intArr[minIndex]=temp;
		
		}
				
	}
}