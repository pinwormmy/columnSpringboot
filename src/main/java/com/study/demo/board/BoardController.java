package com.study.demo.board;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class BoardController {
    @Autowired
    BoardService boardService;

    @GetMapping(value = "/board")
    public String board(Model model) throws Exception {
        List<BoardDTO> postList = boardService.showPostList();
        model.addAttribute("postList", postList);
        return "board";
    }

    @RequestMapping("/post")
    public String post() {
        return "post";
    }

}