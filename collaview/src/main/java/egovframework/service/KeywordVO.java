package egovframework.service;

import java.time.LocalDateTime;

import lombok.Data;

@Data
public class KeywordVO {
	private Integer idx;                
    private String name;               
    private String category;             
    private LocalDateTime register_date;  
}
