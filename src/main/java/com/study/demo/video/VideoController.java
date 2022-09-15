package com.study.demo.video;

import com.study.demo.board.BoardDTO;
import com.study.demo.util.PageDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@Slf4j
public class VideoController {

    @Autowired
    VideoService videoService;

    @GetMapping(value = "/videoBoard")
    public String videoBoard(PageDTO page, Model model) throws Exception {
        model.addAttribute("page", videoService.pageSetting(page));
        model.addAttribute("videoList", videoService.showVideoList(page));
        return "video/videoBoard";
    }

    @RequestMapping("/writeVideoPost")
    public String writeVideoPost() {
        return "video/writeVideoPost";
    }

    @RequestMapping("/readVideo")
    public String readVideoPost(Model model, VideoDTO video) {
        model.addAttribute("video", video);
        return "video/readVideo";
    }

    @RequestMapping("/submitVideoPost")
    public String submitVideoPost(VideoDTO video) throws Exception {
        videoService.submitVideoPost(video);
        return "redirect:/video/videoBoard";
    }

    @RequestMapping("/deleteVideoPost")
    public String deletePost(int videoNum) throws Exception {
        videoService.deleteVideoPost(videoNum);
        return "redirect:/video/videoBoard";
    }
}
