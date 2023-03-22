package com.study.column.board;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.study.column.member.MemberDTO;
import lombok.Getter;
import lombok.Setter;

import java.util.Date;

@Getter
@Setter
public class PostCommentDTO {

    private int postNum;
    private int commentNum;
    private String id;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+9")
    private Date regDate;
    private String content;

    private MemberDTO memberDTO;

}
