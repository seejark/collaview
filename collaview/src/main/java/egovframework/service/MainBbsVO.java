package egovframework.service;

import lombok.Data;

@Data
public class MainBbsVO {
	private String table;
	private Integer idx;
	private String category;
	private String title;
	private String contents;
	private Integer view;
	private String chat;
}
