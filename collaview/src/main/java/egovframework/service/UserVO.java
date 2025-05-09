package egovframework.service;

import java.util.Date;

import lombok.Data;

@Data
public class UserVO {
	private Integer idx;
	private String id;
	private String name;
	private String nick;
	private String phone;
	private Date birth;
	private String email;
	private String company_chk;
	private String artist_chk;
	private String profile_file;
	private String profile_origin;
	private String privacy_chk;
	private String terms_chk;
	private String register_date;
	private String modify_date;
	
	private String user;
	private String admin;
	
	private double score;
}
