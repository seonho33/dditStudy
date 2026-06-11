package kr.or.ddit.vo.test;

import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import lombok.Data;

@Data
public class TestMemberVO {

	private MultipartFile attachFile;
	private String userId;
	private String password;
	private String userName;
	private String gender;
	private String phone;
	private String phone2;
	private String phone3;
	private String email;
	private String addressPostCode;
	private String addressLocation;
	private String addressDetail;
	private String introduction;
	private List<MultipartFile> attachFileList;
}
