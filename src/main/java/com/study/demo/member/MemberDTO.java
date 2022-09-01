package com.study.demo.member;

import lombok.Data;

import java.util.Date;

@Data
public class MemberDTO {
    private String id;
    private String pw;
    private String nickName;
    private String email;
    private Date regDate;
    private int memberLevel;
}
