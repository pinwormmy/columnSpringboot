package com.study.demo.video;

import com.study.demo.board.BoardDTO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class VideoController {

    @GetMapping(value = "/videoBoard")
    public String videoBoard(Model model) throws Exception {
        //List<BoardDTO> postList = boardService.showPostList();
        //model.addAttribute("postList", postList);
        return "videoBoard";
    }

    @RequestMapping("/writeVideoPost")
    public String writeVideoPost() {
        return "writeVideoPost";
    }
}
