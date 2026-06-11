package kr.or.ddit.reflection;

import java.io.Serializable;

import kr.or.ddit.basic.PrintAnnotation;

public class SampleVO implements Serializable {
	private String id;
	private String name;
	private int age;
	
	public SampleVO(String id, String name, int age) {
		super();
		this.id = id;
		this.name = name;
		this.age = age;
	}
	
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
	@PrintAnnotation
	public String getName() {
		return name;
	}
	@PrintAnnotation
	public void setName(String name) {
		this.name = name;
	}

	public int getAge() {
		return age;
	}

	public void setAge(int age) {
		this.age = age;
	}
}
