package com.study.demo.board;

import lombok.Data;

import java.util.Date;

@Data
public class PostCommentDTO {

    private int postNum;
    private int commentNum;
    private String writer;
    private Date regDate;
    private String content;

}
