package sec02.exam06;

public class ArrayInArrayExample {
	public static void main(String[] args) {
		
		int[][] mathScores = new int[2][3];
		mathScores[0][1]=3;
		int sum1 = 0;
		
		
		for(int i=0;i<mathScores.length; i++) {
			for(int k=0;k<mathScores[i].length;k++) {
				sum1 += mathScores[i][k];
				System.out.println("mathScores["+i+"]["+k+"]="+mathScores[i][k]);
			}
		}	
		
		System.out.println(sum1);
		System.out.println();
		
		int[][] englishScores = new int[2][];
		englishScores[0] = new int[2];
		englishScores[1] = new int[3];
		for(int i = 0; i < englishScores.length; i ++) {
			for(int k = 0; k< englishScores[i].length; k++) {
				System.out.println("englishScores[" + i + "][" + k + "]=" +englishScores[i][k]);
			}
		}
		System.out.println();
		
		int[][] javaScores = new int[][] {{95,80},{92,96,80},{1}};
		for(int i=0; i<javaScores.length; i++) {
			for(int k=0; k<javaScores[i].length;k++) {
				System.out.println("javaScores["+ i + "][" + k + "]= " +javaScores[i][k]);
			}
		}
		System.out.println(javaScores.length+javaScores[1].length);
	}
}
