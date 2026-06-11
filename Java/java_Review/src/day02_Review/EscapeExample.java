package day02_Review;

public class EscapeExample {
	public static void main(String[] args) {
		System.out.println("번호\t이름\t직업");
		System.out.println("행 단위 출력");
		System.out.print("행 단위 출력\n");
		System.out.println("우리는 \"개발자\" 입니다.");
		System.out.println("봄\\여름\\가을\\겨울");
		System.out.println("\u0041");
/* 

\n	줄바꿈	"Hello\nWorld"
\t	탭	"A\tB"
\\	백슬래시	"C:\\temp"
\'	작은따옴표	'\''
\"	큰따옴표	"She said \"Hi\""
\\uXXXX	유니코드 문자	'\u0041' = 'A' 

*/
	
	}
}
