package r_07_sec01.exam02;

public class StudentExample {
	public static void main(String[] args) {
		Student student = new Student("홍길동", "1234", 1);
		System.out.println("name : " + student.name);
		System.out.println("ssn : " + student.ssn);
		System.out.println("studentNo : "+student.studentNo);
	}
}
