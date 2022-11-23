package com.study.column.openColumn;

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
@RequestMapping("/openColumn")
public class OpenColumnController {
    @Autowired
    OpenColumnService openColumnService;

    @GetMapping(value = "/list")
    public String list(PageDTO page, Model model) throws Exception {
        model.addAttribute("fullNoticeList", openColumnService.showFullNoticeList());
        model.addAttribute("selfNoticeList", openColumnService.showSelfNoticeList());
        model.addAttribute("page", openColumnService.pageSetting(page));
        model.addAttribute("postList", openColumnService.showPostList(page));
        return "openColumn/openColumn";
    }

    @RequestMapping("/readPost")
    @Transactional
    public String readPost(Model model, HttpServletRequest request) throws Exception {
        int postNum = Integer.parseInt(request.getParameter("postNum"));
        checkIpAndUpdateViews(request, postNum);
        model.addAttribute("post", openColumnService.readPost(postNum));
        return "openColumn/readPost";
    }

    private void checkIpAndUpdateViews(HttpServletRequest request, int postNum) throws Exception {
        String ip = IpService.getRemoteIP(request);
        if(openColumnService.checkViewUserIp(postNum, ip) == 0) {
            openColumnService.saveViewUserIp(postNum, ip);
            openColumnService.updateViews(postNum);
        }
    }

    @RequestMapping("/writePost")
    public String writePost() {
        return "openColumn/writePost";
    }

    @RequestMapping("/submitPost")
    public String submitPost(OpenColumnDTO post) throws Exception {
        openColumnService.submitPost(post);
        return "redirect:/openColumn/list";
    }

    @RequestMapping("/deletePost")
    public String deletePost(int postNum) throws Exception {
        openColumnService.deletePost(postNum);
        return "redirect:/openColumn/list";
    }

    @RequestMapping(value = "/modifyPost")
    public String modifyPost(Model model, int postNum) throws Exception {
        model.addAttribute("post", openColumnService.readPost(postNum));
        return "openColumn/modifyPost";
    }

    @RequestMapping(value = "/submitModifyPost")
    public String submitModifyPost(OpenColumnDTO post) throws Exception {
        openColumnService.submitModifyPost(post);
        return "redirect:/openColumn/readPost?postNum=" + post.getPostNum();
    }

    @RequestMapping(value = "/addComment")
    @ResponseBody
    public void addComment(@RequestBody OpenColumnCommentDTO comment) throws Exception {
        log.debug("댓글 인수 확인(댓글내용) : {}", comment.getContent());
        openColumnService.addComment(comment);
    }

    @RequestMapping(value = "/commentPageSetting")
    @ResponseBody
    public PageDTO commentPageSetting(@RequestBody PageDTO page) throws Exception {
        return openColumnService.pageSetting(page);
    }

    @RequestMapping(value = "/showCommentList")
    @ResponseBody
    public List<OpenColumnCommentDTO> showCommentList(int postNum) throws Exception {
        return openColumnService.showCommentList(postNum);
    }

    @RequestMapping(value = "/deleteComment")
    @ResponseBody
    public void deleteComment(int commentNum) throws Exception {
        openColumnService.deleteComment(commentNum);
    }

    @RequestMapping(value = "/updateCommentCount")
    @ResponseBody
    public void updateCommentCount(int postNum) throws Exception {
        openColumnService.updateCommentCount(postNum);
    }
}