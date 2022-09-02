package com.study.demo.board;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

@Data
public class PostCommentDTO {

    private int postNum;
    private int commentNum;
    private String writer;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+9")
    private Date regDate;
    private String content;

}
