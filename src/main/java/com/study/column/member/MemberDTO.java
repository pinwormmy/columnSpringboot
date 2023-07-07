package com.study.column.member;

import lombok.Data;

import java.util.Date;

@Data
public class MemberDTO {
    private String id;
    private String pw;
    private String nickName;
    private String realName;
    private String email;
    private String phone;
    private int grade;
    private Date regDate;
    private String resetToken;
}
