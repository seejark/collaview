package egovframework.service;

import java.time.LocalDateTime;
import lombok.Data;

@Data
public class BoardVO {
    private String table;
    private int idx;
    private String category;
    private String user;
    private int view;
    private String title;
    private String contents;
    private int good;
    private String register_date;
    private String modify_date;
    private String hidden_date;
    private String del_date;
    
//  dataTables 사용 변수
    private String uploader_type;
    private String uploader;
    private String uploader_img;
    private String uploader_idx;
    private String date;
    private int chat;
    private String img_file;
    private String img_origin;

//  recruit 겸용 변수
    private String start_date;
    private String end_date;
    private String channel;
}
