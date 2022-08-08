package com.study.demo.video;

import lombok.Data;

import java.util.Date;

@Data
public class VideoDTO {

    private int videoNum;
    private String title;
    private String videoUrl;
    private Date regDate;
}
