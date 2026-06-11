package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class Member {
	private String userId = "a001";
	private String userName = "hongkd";
	private String password = "1234";
	private int coin;
	
	private Date dateOfBirth;
	
	private String email;
	private String gender;
	private String developer;
	private String nationality;
	private boolean foreigner;
	private Address address;
	
	private String hobby;
	private String[] hobbyArray;
	private List<String> hobbyList;
	private String cars;
	private String[] carArray;
	private List<String> carList;
	private List<Card> cardList;
	
	private String introduction;
	private String birthDay;
}
