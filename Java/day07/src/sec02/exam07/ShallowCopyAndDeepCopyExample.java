package sec02.exam07;

public class ShallowCopyAndDeepCopyExample {
	public static void main(String[] args) {
/*		ShallowCopy(얕은 복사)
		DeepCopy(깊은 복사)*/
		
		int x = 1 ;
		int y = x ;
		
		System.out.println(y);
		
		int[] intArr = {1,2,3};
		System.out.println("intArr.length: " + intArr.length);
		
		for(int i =0;i<intArr.length;i++) {
			System.out.println("intArr[" + i + "]= " + intArr[i]);
			
		}
		
		
		int[] intArr2 = intArr;
		
		for(int i = 0;i<intArr2.length;i++)
			System.out.println("intArr2[" + i + "]=" + intArr2[i]);
		
		
		
		
		
	}
}
