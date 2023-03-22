package com.study.column.board;

import lombok.Getter;
import lombok.Setter;

import java.time.LocalDateTime;


@Getter
@Setter
public class ViewsDetailDTO {
    private int postNum;
    private String ip;
    private LocalDateTime regDate;
    private String realName;
}
