package egovframework.service;

import java.time.LocalDateTime;
import lombok.Data;

@Data
public class BoardSearchVO {
    private int idx;
    private String category;
    private int firstIndex;
    private int pageUnit;
}
