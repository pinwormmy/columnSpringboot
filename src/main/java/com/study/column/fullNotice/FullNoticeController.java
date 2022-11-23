package com.study.column.fullNotice;

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
@RequestMapping("/fullNotice")
public class FullNoticeController {
    @Autowired
    FullNoticeService fullNoticeService;

    @GetMapping(value = "/list")
    public String list(PageDTO page, Model model) throws Exception {
        model.addAttribute("fullNoticeList", fullNoticeService.showSelfNoticeList());
        model.addAttribute("page", fullNoticeService.pageSetting(page));
        model.addAttribute("postList", fullNoticeService.showPostList(page));
        return "fullNotice/fullNotice";
    }

    @RequestMapping("/readPost")
    @Transactional
    public String readPost(Model model, HttpServletRequest request) throws Exception {
        int postNum = Integer.parseInt(request.getParameter("postNum"));
        checkIpAndUpdateViews(request, postNum);
        model.addAttribute("post", fullNoticeService.readPost(postNum));
        return "fullNotice/readPost";
    }

    private void checkIpAndUpdateViews(HttpServletRequest request, int postNum) throws Exception {
        String ip = IpService.getRemoteIP(request);
        if(fullNoticeService.checkViewUserIp(postNum, ip) == 0) {
            fullNoticeService.saveViewUserIp(postNum, ip);
            fullNoticeService.updateViews(postNum);
        }
    }

    @RequestMapping("/writePost")
    public String writePost() {
        return "fullNotice/writePost";
    }

    @RequestMapping("/submitPost")
    public String submitPost(FullNoticeDTO post) throws Exception {
        fullNoticeService.submitPost(post);
        return "redirect:/fullNotice/list";
    }

    @RequestMapping("/deletePost")
    public String deletePost(int postNum) throws Exception {
        fullNoticeService.deletePost(postNum);
        return "redirect:/fullNotice/list";
    }

    @RequestMapping(value = "/modifyPost")
    public String modifyPost(Model model, int postNum) throws Exception {
        model.addAttribute("post", fullNoticeService.readPost(postNum));
        return "fullNotice/modifyPost";
    }

    @RequestMapping(value = "/submitModifyPost")
    public String submitModifyPost(FullNoticeDTO post) throws Exception {
        fullNoticeService.submitModifyPost(post);
        return "redirect:/fullNotice/readFullNotice?postNum=" + post.getPostNum();
    }

    @RequestMapping(value = "/addComment")
    @ResponseBody
    public void addComment(@RequestBody FullNoticeCommentDTO comment) throws Exception {
        log.debug("댓글 인수 확인(댓글내용) : {}", comment.getContent());
        fullNoticeService.addComment(comment);
    }

    @RequestMapping(value = "/showCommentList")
    @ResponseBody
    public List<FullNoticeCommentDTO> showCommentList(int postNum) throws Exception {
        return fullNoticeService.showCommentList(postNum);
    }

    @RequestMapping(value = "/deleteComment")
    @ResponseBody
    public void deleteComment(int commentNum) throws Exception {
        fullNoticeService.deleteComment(commentNum);
    }

    @RequestMapping(value = "/updateCommentCount")
    @ResponseBody
    public void updateCommentCount(int postNum) throws Exception {
        fullNoticeService.updateCommentCount(postNum);
    }
}