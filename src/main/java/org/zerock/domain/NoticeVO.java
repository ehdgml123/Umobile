package org.zerock.domain;

import java.time.LocalDateTime;
import java.util.Date;

import org.springframework.format.annotation.DateTimeFormat;

import lombok.Data;

@Data
public class NoticeVO {

    private Long nno;
    private String title;
    private String content;
    private String writer;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date createdDate;
    private Date modifiedDate;
    private Date regdate;
    private String regdateString;

}
