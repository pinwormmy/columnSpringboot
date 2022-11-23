package com.study.column.video;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.study.column.member.MemberDTO;
import lombok.Data;

import java.util.Date;

@Data
public class VideoCommentDTO {

    private int postNum;
    private int commentNum;
    private String id;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+9")
    private Date regDate;
    private String content;

    private MemberDTO memberDTO;

}
