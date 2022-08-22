package com.study.demo.video;

import com.study.demo.board.BoardDTO;
import com.study.demo.util.PageDTO;
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
        PageDTO page = videoService.pageSetting();
        model.addAttribute("page", page);
        return "videoBoard";
    }

    @GetMapping(value = "/videoBoardPage")
    public String videoBoardPage(Model model, int recentPage) throws Exception {
        List<BoardDTO> videoList = videoService.showVideoList();
        model.addAttribute("videoList", videoList);
        PageDTO page = videoService.pageSetting(recentPage);
        model.addAttribute("page", page);
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

    @RequestMapping("/deleteVideoPost")
    public String deletePost(int videoNum) throws Exception {
        videoService.deleteVideoPost(videoNum);
        return "redirect:/videoBoard";
    }
}
