package 학생성적정렬;

public class Student {
	private String name;
	private int kor;
	private int eng;
	private int math;
	private int sum;
	
	
	public int getsum() {
		sum=kor+eng+math;
		return sum;
	}
	
	
	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getKor() {
		return kor;
	}

	public void setKor(int kor) {
		this.kor = kor;
		if(kor<0) {
			kor=0;
		}
	}

	public int getEng() {
		return eng;
	}

	public void setEng(int eng) {
		this.eng = eng;
		if(eng<0) {
			eng=0;
		}
	}

	public int getmath() {
		return math;
	}

	public void setmath(int math) {
		this.math = math;
		if(math<0) {
			math=0;
		}
	}
}