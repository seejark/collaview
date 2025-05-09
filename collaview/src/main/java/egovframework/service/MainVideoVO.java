package egovframework.service;

import lombok.Data;

@Data
public class MainVideoVO {
	private Integer idx;
	private String title;
	private String file_type;
	private String file;
	private Integer channel;
	private String ch_name;
	private String level;
	private Integer rank;
	private Integer bookmark;
}
