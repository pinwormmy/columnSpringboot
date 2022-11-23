package com.study.column.openColumn;

import lombok.Data;

import java.util.Date;

@Data
public class OpenColumnDTO {

    private int postNum;
    private String title;
    private String content;
    private String writer;
    private Date regDate;
    private int views;
    private int commentCount;
    private int notice;
}
