package com.study.column.library;

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
@RequestMapping("/board")
public class LibraryController {
    @Autowired
    LibraryService libraryService;
    @GetMapping(value = "/list")
    public String board(PageDTO page, Model model) throws Exception {
        model.addAttribute("fullNoticeList", libraryService.showFullNoticeList());
        model.addAttribute("selfNoticeList", libraryService.showSelfNoticeList());
        model.addAttribute("page", libraryService.pageSetting(page));
        model.addAttribute("postList", libraryService.showPostList(page));
        log.debug(page.toString());
        return "board/board";
    }

    @RequestMapping("/readPost")
    @Transactional
    public String post(Model model, HttpServletRequest request) throws Exception {
        int postNum = Integer.parseInt(request.getParameter("postNum"));
        checkIpAndUpdateViews(request, postNum);
        model.addAttribute("post", libraryService.readPost(postNum));
        return "board/readPost";
    }
    private void checkIpAndUpdateViews(HttpServletRequest request, int postNum) throws Exception {
        String ip = IpService.getRemoteIP(request);
        if(libraryService.checkViewUserIp(postNum, ip) == 0) {
            libraryService.saveViewUserIp(postNum, ip);
            libraryService.updateViews(postNum);
        }
    }

    @RequestMapping("/writePost")
    public String writePost() {
        return "board/writePost";
    }

    @RequestMapping("/submitPost")
    public String submitPost(LibraryDTO post) throws Exception {
        libraryService.submitPost(post);
        return "redirect:/board/list";
    }

    @RequestMapping("/deletePost")
    public String deletePost(int postNum) throws Exception {
        libraryService.deletePost(postNum);
        return "redirect:/board/list";
    }

    @RequestMapping(value = "/modifyPost")
    public String modifyPost(Model model, int postNum) throws Exception {
        model.addAttribute("post", libraryService.readPost(postNum));
        return "board/modifyPost";
    }

    @RequestMapping(value = "/submitModifyPost")
    public String submitModifyPost(LibraryDTO post) throws Exception {
        libraryService.submitModifyPost(post);
        return "redirect:/board/readPost?postNum=" + post.getPostNum();
    }

    @RequestMapping(value = "/addComment")
    @ResponseBody
    public void addComment(@RequestBody LibraryCommentDTO comment) throws Exception {
        log.debug("댓글 인수 확인(댓글내용) : {}", comment.getContent());
        libraryService.addComment(comment);
    }

    @RequestMapping(value = "/commentPageSetting")
    @ResponseBody
    public PageDTO commentPageSetting(@RequestBody PageDTO page) throws Exception {
        return libraryService.pageSetting(page);
    }

    @RequestMapping(value = "/showCommentList")
    @ResponseBody
    public List<LibraryCommentDTO> showCommentList(@RequestBody PageDTO page) throws Exception {
        return libraryService.showCommentList(page);
    }

    @RequestMapping(value = "/deleteComment")
    @ResponseBody
    public void deleteComment(int commentNum) throws Exception {
        libraryService.deleteComment(commentNum);
    }

    @RequestMapping(value = "/updateCommentCount")
    @ResponseBody
    public void updateCommentCount(int postNum) throws Exception {
        libraryService.updateCommentCount(postNum);
    }
}