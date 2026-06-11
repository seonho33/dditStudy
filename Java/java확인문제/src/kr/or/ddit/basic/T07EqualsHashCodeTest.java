package kr.or.ddit.basic;

import java.util.HashSet;
import java.util.Objects;
import java.util.Set;

public class T07EqualsHashCodeTest {
/*
   해시는 해시함수를 사용하여 빠른 데이터 탐색을 가능하게 해주는
   자료구조이다. 해시함수(hash function)은 임의의 데이터를
   고정된 길이(크기)의 데이터로 매핑해 주는 함수이다.
   해시함수에 의해 얻어지는 값은 해시값 또는 해시코드 라고 부른다.
   
   HashSet, HashMap, Hashtable 과 같은 객체들은 사용할 경우
   원소의 객체가 서로 같은지를 비교하기 위해 equals()와 hashCode()
   메서드를 호출한다. 그래서 객체가 같은지 여부를 제대로 결정하려면
   두 메서드를 재정의 해주어야 한다. 같은지 여부는 데이터를 추가할 때
   검사한다.
   
   - equals() 메서드는 두 객체의 내용(값)이 같은지 비교하는 
     메서드이고,
   - hashCode()메서드는 객체에 대한 해시코드 값을 반환하는 
     메서드이다.
   - equals() 와 hashCode()메서드에 관련된 규칙
   1. 두 객체가 같으면 반드시 같은 해시값을 가져야 한다.
   2. 두 객체가 같으면 equals()메서드를 호출했을 때 true를 반환한다.
     즉, 객체 a, b가 같다면 a.equals(b)와 b.equals(a) 
     모두 true 이다.
   3. 두 객체의 해시값이 같다고 해서 두 객체가 반드시 
      같은 객체는 아니다. 하지만, 두 객체가 같으면 반드시 해시값이
      같아야 한다.
   4. equals()메서드를 재정의 해야 하면 반드시 hashCode()메서드도
      재정의 해주어야 한다.
   5. hashCode() 는 기본적으로 힙메모리에 존재하는 객체의 메모리주소
      정보를 기반으로 한 정수값을 반환한다.
      그러므로 재정의 하지 않으면 다른 힙메모리의 두 객체는 절대로 
      같은 해시값을 반환하지 않는다.
      
    - hashCode()메서드에서 사용하는 '해싱 알고리즘'에서 서로 다른
     객체에 대하여 같은 해시값을 만들어 낼 수 있다(해시값 충돌)
     그래서 다른 객체라 하더라도 같은 해시값이 나올 수 있다.  
*/
	
	public static void main(String[] args) {
		
		System.out.println("Aa".hashCode());
		System.out.println("AA".hashCode());
		System.out.println("BB".hashCode());
		
		Person p1 = new Person(1, "홍길동");
		Person p2 = new Person(1, "홍길동");
		Person p3 = new Person(1, "이순신");
		
		System.out.println("p1.equals(p2) : " 
				+ p1.equals(p2));
		System.out.println("p1 == p2 :" + (p1 == p2));
		
		Set<Person> hSet = new HashSet<Person>();
		
		System.out.println("add(p1) 성공여부 : "
				+ hSet.add(p1));
		System.out.println("add(p2) 성공여부 : "
				+ hSet.add(p2));
		System.out.println("add(p3) 성공여부 : "
				+ hSet.add(p3));
		
		System.out.println("현재 모든 데이터 출력:");
		for(Person p : hSet) {
			System.out.println(p);
		}
		
		
		
		
		
		
		
		
		
	}
}

class Person {
	private int id;
	private String name;
	public Person(int id, String name) {
		super();
		this.id = id;
		this.name = name;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	@Override
	public String toString() {
		return "Person [id=" + id + ", name=" + name + "]";
	}
	
	@Override
	public int hashCode() {
		return Objects.hash(id, name);
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

