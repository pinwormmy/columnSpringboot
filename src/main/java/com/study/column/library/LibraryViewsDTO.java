package com.study.column.library;

import lombok.Data;

import java.util.Date;

@Data
public class LibraryViewsDTO {
    private int postNum;
    private String ip;
    private Date regDate;
}
