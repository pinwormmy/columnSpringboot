package com.study.column.board;

import lombok.Getter;
import lombok.Setter;

import java.util.Date;


@Getter
@Setter
public class ViewsDetailDTO {
    private int postNum;
    private String ip;
    private Date regDate;
    private String realName;
}
