package kr.or.ddi.basic;

import java.util.Arrays;

public class InSertionSortTest {
	public static void main(String[] args) {
		
		int[] intArr = {5,7,9,0,3,1,6,2,4,8};

		System.out.println("정렬 전 : " + Arrays.toString(intArr));
		
		insertionSort(intArr);
	
		System.out.println("정렬 후 : " + Arrays.toString(intArr));
		
	}
/**
 * 삽입정렬 : 선택된 원소의 좌측데이터는 이미 정렬되어 있다고 가정하고
 * 			적절한 위치를 찾아 삽입시킨다.
 * @param intArr
 */
	
	
	private static void insertionSort(int[] intArr) {
		// TODO Auto-generated method stub
		
		for(int i=1;i<intArr.length;i++) {
			for(int j=i; j>0; j--) {
				if(intArr[j]<intArr[j-1]) {
					//현재 데이터보다 왼쪽 데이터가 큰 경우...
					int temp = intArr[j];
					intArr[j]=intArr[j-1];
					intArr[j-1]=temp;
				}else {
					// 현재 데이터보다 왼쪽데이터가 더 작으면 이미 정렬된
					//상태이므로 더 이상 비교할 필요가 없다.
					break;
				}
			}
		}
			
	}
	
	
}
