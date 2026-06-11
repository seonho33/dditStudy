package kr.or.ddit.basic;

import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

public class T08HashCode {
	public static void main(String[] args) {
		System.out.println("Aa".hashCode());
		System.out.println("AA".hashCode());
		System.out.println("BB".hashCode());
		
		Person p1 = new Person(1,"홍길동");
		Person p2 = new Person(1,"홍길동");
		Person p3 = new Person(1,"이순신");
		
		System.out.println("p1.equals(p2) : " +p1.equals(p2));
		System.out.println("p1==p2:"+(p1==p2));

		Set<Person> hSet = new HashSet<Person>();
		
		System.out.println("add(p1) 성공여부 : " + hSet.add(p1));
		System.out.println("add(p2) 성공여부 : " + hSet.add(p2));
		System.out.println("add(p3) 성공여부 : " + hSet.add(p3));
	}
}


	class Person {
		private int id;
		private String name;
		
	public Person(int id,String name){
		this.id=id;
		this.name=name;
	}
	
	

	public int getId() {
		return id;
	}



	public void setI(int id) {
		this.id = id;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



	 @Override 
	 public int hashCode() {
		 
	return Objects.hash(id,name);
	}



	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Person other = (Person) obj;
		return id == other.id && Objects.equals(name, other.name);
	}



}