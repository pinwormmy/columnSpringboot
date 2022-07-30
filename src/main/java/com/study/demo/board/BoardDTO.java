package com.study.demo.board;

import lombok.Data;

import java.util.Date;

@Data
public class BoardDTO {

    private int postNum;
    private String title;
    private String content;
    private String writer;
    private Date regDate;
    private int views;
}
