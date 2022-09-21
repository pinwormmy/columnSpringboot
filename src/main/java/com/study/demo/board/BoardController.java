package com.study.demo.board;

import com.study.demo.util.PageDTO;
import com.study.demo.util.IpService;
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
public class BoardController {
    @Autowired
    BoardService boardService;
    @GetMapping(value = "/list")
    public String board(PageDTO page, Model model) throws Exception {
        model.addAttribute("fullNoticeList", boardService.showFullNoticeList());
        model.addAttribute("selfNoticeList", boardService.showSelfNoticeList());
        model.addAttribute("page", boardService.pageSetting(page));
        model.addAttribute("postList", boardService.showPostList(page));
        return "board/board";
    }

    @RequestMapping("/readPost")
    @Transactional
    public String post(Model model, HttpServletRequest request) throws Exception {
        int postNum = Integer.parseInt(request.getParameter("postNum"));
        checkIpAndUpdateViews(request, postNum);
        model.addAttribute("post", boardService.readPost(postNum));
        return "board/readPost";
    }
    private void checkIpAndUpdateViews(HttpServletRequest request, int postNum) throws Exception {
        String ip = IpService.getRemoteIP(request);
        if(boardService.checkViewUserIp(postNum, ip) == 0) {
            boardService.saveViewUserIp(postNum, ip);
            boardService.updateViews(postNum);
        }
    }

    @RequestMapping("/writePost")
    public String writePost() {
        return "board/writePost";
    }

    @RequestMapping("/submitPost")
    public String submitPost(BoardDTO post) throws Exception {
        boardService.submitPost(post);
        return "redirect:/board/board";
    }

    @RequestMapping("/deletePost")
    public String deletePost(int postNum) throws Exception {
        boardService.deletePost(postNum);
        return "redirect:/board/board";
    }

    @RequestMapping(value = "/modifyPost")
    public String modifyPost(Model model, int postNum) throws Exception {
        model.addAttribute("post", boardService.readPost(postNum));
        return "board/modifyPost";
    }

    @RequestMapping(value = "/submitModifyPost")
    public String submitModifyPost(BoardDTO post) throws Exception {
        boardService.submitModifyPost(post);
        return "redirect:/board/readPost?postNum=" + post.getPostNum();
    }

    @RequestMapping(value = "/addComment")
    @ResponseBody
    public void addComment(@RequestBody PostCommentDTO comment) throws Exception {
        log.debug("댓글 인수 확인(댓글내용) : {}", comment.getContent());
        boardService.addComment(comment);
    }

    @RequestMapping(value = "/showCommentList")
    @ResponseBody
    public List<PostCommentDTO> showCommentList(PageDTO page) throws Exception {
        page = boardService.pageSetting((page));
        return boardService.showCommentList(page);
    }

    @RequestMapping(value = "/deleteComment")
    @ResponseBody
    public void deleteComment(int commentNum) throws Exception {
        boardService.deleteComment(commentNum);
    }

    @RequestMapping(value = "/updateCommentCount")
    @ResponseBody
    public void updateCommentCount(int postNum) throws Exception {
        boardService.updateCommentCount(postNum);
    }
}