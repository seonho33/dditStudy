package 학생리스트정렬;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.List;

public class ListStudent {
	/*	시작하기전
	만들어야할 클래스...
	1.student(implements comparable) 학번의 오름차순
	2.comparators(역순을 위해)
	3.실행클래스
*/
	public static void main(String[] args) {
		List<Student> student = new ArrayList<Student>();
		student.add(new Student("25-11","홍길동",80,90,100));
		student.add(new Student("25-13", "성춘향", 80, 100, 70));
		student.add(new Student("25-15", "변학도", 50, 60, 70));
		student.add(new Student("25-10", "일지매", 60, 70, 50));
		student.add(new Student("25-19", "강감찬", 100, 80, 90));
		
		System.out.println("정렬 전");
		for(Student str : student) {
			System.out.println(str);
		}
		Collections.sort(student);			// 학번으로 정렬하기
		System.out.println("학번으로 정렬");
		for(Student str : student) {
			System.out.println(str);
		}
												// 총점으로 정렬하기 정렬하고 for문으로 등수부여,if문으로 동점 등수부여...
		System.out.println("==총점으로 정렬==");
		Collections.sort(student, new ScoreDesc());	//내가 재정의한 외부정렬자
		for(int i=0;i<student.size();i++) {
			if(i>=1&&student.get(i).getScore()==student.get(i-1).getScore()) {
				System.out.println((i)+"등 " +student.get(i));
			}else {
			System.out.println((i+1)+"등 "+student.get(i));
			}
		}
	}
}


class Student implements Comparable<Student>{
	
	private String studentNo;		//학번
	private String studentName;		//이름
	private int	kor;				//국어성적
	private int eng;				//영어성적
	private int math;				//수학성적
	private int score;				//성적=kor+eng+mathe 는 생성자 단계에서 정리함 
	
	//getter setter 굳이 쓸필요없음...
	
	public String getStudentNo() {
		return studentNo;
	}

	public void setStudentNo(String studentNo) {
		this.studentNo = studentNo;
	}

	public String getStudentName() {
		return studentName;
	}

	public void setStudentName(String studentName) {
		this.studentName = studentName;
	}

	public int getKor() {
		return kor;
	}

	public void setKor(int kor) {
		this.kor = kor;
	}

	public int getEng() {
		return eng;
	}

	public void setEng(int eng) {
		this.eng = eng;
	}

	public int getMath() {
		return math;
	}

	public void setMath(int math) {
		this.math = math;
	}

	public int getScore() {
		return score;
	}

	public void setScore(int score) {
		this.score = score;
	}

	public Student(String studentNo, String studnetName, int kor, int eng, int math) {
		this.studentNo = studentNo;
		this.studentName = studnetName;
		this.kor = kor;
		this.eng = eng;
		this.math = math;
		this.score=(kor+eng+math);
	}
	
	@Override						//collections.sort(list Student타입) 했을 시 List 안의 정보를 학번순으로 정렬하도록 오버라이드...
	public int compareTo(Student stu) {

		return this.studentNo.compareTo(stu.studentNo);
	}

	@Override	//list 항목을 꺼내올때 참조번호가 아니라 원하는 필드값이 toString 되도록 String의 toString 메서드도 재정의
	public String toString() {
		return "[학번: " + studentNo + ", 이름: " + studentName + ", 국어: " + kor + ", 영어: " + eng
				+ ", 수학: " + math + ", 총점: " + score + "]";
	}
}

class ScoreDesc implements Comparator<Student>{			// 학생의 점수를 내림차순으로 정렬하도록 Comparator 를 재정의+if문으로 같다면 학번의 내림차순으로 정렬하도록 함...

	@Override
	public int compare(Student score1, Student score2) {
		if(score1.getScore()==score2.getScore()) {
			return new String(score1.getStudentNo()).compareTo(score2.getStudentNo())*-1;
		}
		return new Integer(score1.getScore()).compareTo(score2.getScore())*-1;
	}
	
}


