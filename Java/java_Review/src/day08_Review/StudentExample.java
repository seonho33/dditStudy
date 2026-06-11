package day08_Review;

public class StudentExample {
	public static void main(String[] args) {
		Student s1 = new Student();
		System.out.println(s1+": s1의 변수가 Student 객체를 참조합니다.");
		
		Student s2=new Student();
		System.out.println(s2+": s2의 변수가 또 다른 Student 객체를 참조합니다.");
	}
}
