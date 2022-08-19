package com.study.demo.util;

import lombok.Data;

@Data
public class PageDTO {

    private int pageBeginPoint;
    private int postEndPoint;
    private int postBeginPoint;
    private int pageEndPoint;
    private int prevPageSetPoint;
    private int nextPageSetPoint;
    private int totalPage;

}
