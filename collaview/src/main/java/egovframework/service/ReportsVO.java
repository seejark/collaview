package egovframework.service;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class ReportsVO {
	private Integer idx;
	private String category;
	private String page;
	private String table;
	private Integer num;
	private String user;
	private String Contents;
	private String answer;
	private String email_chk;
	private LocalDateTime register_date; 
	private LocalDateTime answer_date; 
}
