package com.study.column.board;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class BoardDTO {

    private int postNum;
    private String title;
    private String content;
    private String writer;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date regDate;
    private int views;
    private int commentCount;
    private int notice; // 0: 일반글 1:공지
}
