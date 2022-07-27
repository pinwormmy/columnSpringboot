package com.study.demo.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class BoardController {

    @RequestMapping("/columnList")
    public String columnList() {
        return "columnList";
    }

    @RequestMapping("/column")
    public String column() {
        return "column";
    }

}