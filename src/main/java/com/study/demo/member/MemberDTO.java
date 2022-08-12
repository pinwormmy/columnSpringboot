package com.study.demo.member;

import lombok.Data;

@Data
public class MemberDTO {
    private String id;
    private String pw;
    private String nickName;
    private String email;
    private int memberLevel;
}
