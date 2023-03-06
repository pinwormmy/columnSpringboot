package com.study.column.video;

import com.study.column.util.IpService;
import com.study.column.util.PageDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

@Controller
@Slf4j
@RequestMapping("/video")
public class VideoController {
    @Autowired
    VideoService videoService;
    @GetMapping(value = "/list")
    public String videoBoard(PageDTO page, Model model) throws Exception {
        model.addAttribute("fullNoticeList", videoService.showFullNoticeList());
        model.addAttribute("selfNoticeList", videoService.showSelfNoticeList());
        model.addAttribute("page", videoService.pageSetting(page));
        model.addAttribute("postList", videoService.showPostList(page));
        return "video/videoBoard";
    }

    @RequestMapping("/readPost")
    @Transactional
    public String readPost(Model model, HttpServletRequest request) throws Exception {
        int postNum = Integer.parseInt(request.getParameter("postNum"));
        checkIpAndUpdateViews(request, postNum);
        model.addAttribute("post", videoService.readPost(postNum));
        return "video/readPost";
    }
    private void checkIpAndUpdateViews(HttpServletRequest request, int postNum) throws Exception {
        String ip = IpService.getRemoteIP(request);
        if(videoService.checkViewUserIp(postNum, ip) == 0) {
            videoService.saveViewUserIp(postNum, ip);
            videoService.updateViews(postNum);
        }
    }

    @RequestMapping("/writePost")
    public String writePost() {
        return "video/writePost";
    }

    @RequestMapping("/submitPost")
    public String submitPost(VideoDTO post) throws Exception {
        videoService.submitPost(post);
        return "redirect:/video/list";
    }

    @RequestMapping("/deletePost")
    public String deletePost(int postNum) throws Exception {
        videoService.deletePost(postNum);
        return "redirect:/video/list";
    }

    @RequestMapping(value = "/modifyPost")
    public String modifyPost(Model model, int postNum) throws Exception {
        model.addAttribute("post", videoService.readPost(postNum));
        return "video/modifyPost";
    }

    @RequestMapping(value = "/submitModifyPost")
    public String submitModifyPost(VideoDTO post) throws Exception {
        videoService.submitModifyPost(post);
        return "redirect:/video/readPost?postNum=" + post.getPostNum();
    }

    @RequestMapping(value = "/addComment")
    @ResponseBody
    public void addComment(@RequestBody VideoCommentDTO comment) throws Exception {
        log.debug("댓글 인수 확인(댓글내용) : {}", comment.getContent());
        videoService.addComment(comment);
    }

    @RequestMapping(value = "/commentPageSetting")
    @ResponseBody
    public PageDTO commentPageSetting(@RequestBody PageDTO page) throws Exception {
        return videoService.pageSetting(page);
    }

    @RequestMapping(value = "/showCommentList")
    @ResponseBody
    public List<VideoCommentDTO> showCommentList(@RequestBody PageDTO page) throws Exception {
        return videoService.showCommentList(page);
    }

    @RequestMapping(value = "/deleteComment")
    @ResponseBody
    public void deleteComment(int commentNum) throws Exception {
        videoService.deleteComment(commentNum);
    }

    @RequestMapping(value = "/updateCommentCount")
    @ResponseBody
    public void updateCommentCount(int postNum) throws Exception {
        videoService.updateCommentCount(postNum);
    }
}