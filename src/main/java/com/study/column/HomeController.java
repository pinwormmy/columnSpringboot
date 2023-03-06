package com.study.column;

import com.study.column.board.BoardService;
import com.study.column.fullNotice.FullNoticeService;
import com.study.column.library.LibraryService;
import com.study.column.openColumn.OpenColumnService;
import com.study.column.util.PageDTO;
import com.study.column.video.VideoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

    @Autowired
    BoardService boardService;
    @Autowired
    OpenColumnService openColumnService;
    @Autowired
    VideoService videoService;
    @Autowired
    LibraryService libraryService;

    @RequestMapping("/")
    public String home(PageDTO page, Model model) throws Exception {
        model.addAttribute("page", boardService.pageSetting(page));
        model.addAttribute("boardList", boardService.showPostList(page));
        model.addAttribute("opencolumnList", openColumnService.showPostList(page));
        model.addAttribute("videoList", videoService.showPostList(page));
        model.addAttribute("libraryList", libraryService.showPostList(page));

        return "index";
    }

}