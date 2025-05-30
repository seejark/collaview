package egovframework.service;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class UserInputVO {
	private String idx;
	private String id;
	private String pw;
	private String name;
	private String nick;
	private String phone;
	private String birth;
	private String email;
	private String company_chk;
	private String artist_chk;
	private String profile_file;
	private String profile_origin;
	private String privacy_chk;
	private String terms_chk;
}
