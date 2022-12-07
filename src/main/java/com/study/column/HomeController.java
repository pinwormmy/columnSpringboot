package com.study.column;

import com.study.column.fullNotice.FullNoticeService;
import com.study.column.util.PageDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

    @Autowired
    FullNoticeService fullNoticeService;

    @RequestMapping("/")
    public String home(PageDTO page, Model model) throws Exception {
        model.addAttribute("boardList", fullNoticeService.showBoardList());
        model.addAttribute("opencolumnList", fullNoticeService.showOpencolumnList());
        model.addAttribute("videoList", fullNoticeService.showVideoList());
        model.addAttribute("libraryList", fullNoticeService.showVideoList());
        return "index";
    }

}