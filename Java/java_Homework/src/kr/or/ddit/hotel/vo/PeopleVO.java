package kr.or.ddit.hotel.vo;

public class PeopleVO {
	private Integer key;
	private String name;
	
	public PeopleVO(Integer key, String name) {
		super();
		this.key = key;
		this.name = name;
	}

	public Integer getKey() {
		return key;
	}

	public void setKey(Integer key) {
		this.key = key;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	@Override
	public String toString() {
		return "PeopleVO [key=" + key + ", name=" + name + "]";
	}
}
