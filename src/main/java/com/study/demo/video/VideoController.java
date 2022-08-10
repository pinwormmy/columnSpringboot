package com.study.demo.video;

import com.study.demo.board.BoardDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class VideoController {

    @Autowired
    VideoService videoService;

    @GetMapping(value = "/videoBoard")
    public String videoBoard(Model model) throws Exception {
        List<BoardDTO> videoList = videoService.showVideoList();
        model.addAttribute("videoList", videoList);
        return "videoBoard";
    }

    @RequestMapping("/writeVideoPost")
    public String writeVideoPost() {
        return "writeVideoPost";
    }

    @RequestMapping("/submitVideoPost")
    public String submitVideoPost(VideoDTO video) throws Exception {
        videoService.submitVideoPost(video);
        return "redirect:/videoBoard";
    }
}
