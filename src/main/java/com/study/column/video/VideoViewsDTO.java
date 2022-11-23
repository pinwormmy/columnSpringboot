package com.study.column.video;

import lombok.Data;

import java.util.Date;

@Data
public class VideoViewsDTO {
    private int postNum;
    private String ip;
    private Date regDate;
}
