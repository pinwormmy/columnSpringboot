package com.study.demo.board;

import lombok.Data;

import java.util.Date;

@Data
public class ViewsDetailDTO {
    private int postNum;
    private String ip;
    private Date regDate;
}
