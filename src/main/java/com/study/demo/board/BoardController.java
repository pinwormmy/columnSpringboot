package com.study.demo.board;

import com.study.demo.util.PageDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.List;

@Controller
@Slf4j
public class BoardController {
    @Autowired
    BoardService boardService;

    @GetMapping(value = "/board")
    public String board(PageDTO page, Model model) throws Exception {
        model.addAttribute("page", boardService.pageSetting(page));
        model.addAttribute("postList", boardService.showPostList(page));
        return "board";
    }

    @RequestMapping("/readPost")
    public String post(Model model, int postNum, HttpServletRequest request, HttpServletResponse response) throws Exception {
        // 조회수 중복방지 쿠키. 코드 정리 필요
        Cookie viewsCookie = null;
        Cookie[] cookies = request.getCookies();
        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if (cookie.getName().equals("viewsCookie")) {
                    log.debug("cookie.getName : {}", cookie.getName());
                    log.debug("cookie.getValue : {}", cookie.getValue());
                    viewsCookie = cookie;
                }
            }
        }
        if (viewsCookie != null) {
            if(!viewsCookie.getValue().contains(request.getParameter("postNum"))) {
                viewsCookie.setValue(viewsCookie.getValue() + "_" + request.getParameter("postNum"));
                viewsCookie.setMaxAge(60 * 60 * 24 * 31);  // 1달
                response.addCookie(viewsCookie);
                log.debug("쿠키값갱신 : ", viewsCookie.getValue());
                boardService.updateViews(postNum);
            }
        } else {
            Cookie newCookie = new Cookie("viewsCookie", request.getParameter("postNum"));
            newCookie.setMaxAge(60 * 60 * 24 * 31);
            response.addCookie(newCookie);
            log.debug("(신규)쿠키값갱신 : ", newCookie.getValue());
            boardService.updateViews(postNum);
        }

        model.addAttribute("post", boardService.readPost(postNum));
        return "readPost";
    }

    @RequestMapping("/writePost")
    public String writePost() {
        return "writePost";
    }

    @RequestMapping("/submitPost")
    public String submitPost(BoardDTO post) throws Exception {
        boardService.submitPost(post);
        return "redirect:/board";
    }

    @RequestMapping("/deletePost")
    public String deletePost(int postNum) throws Exception {
        boardService.deletePost(postNum);
        return "redirect:/board";
    }

    @RequestMapping(value = "/modifyPost")
    public String modifyPost(Model model, int postNum) throws Exception {
        model.addAttribute("post", boardService.readPost(postNum));
        return "modifyPost";
    }

    @RequestMapping(value = "/submitModifyPost")
    public String submitModifyPost(BoardDTO post) throws Exception {
        boardService.submitModifyPost(post);
        return "redirect:/readPost?postNum=" + post.getPostNum();
    }

    @RequestMapping(value = "/addComment")
    @ResponseBody
    public void addComment(@RequestBody PostCommentDTO comment) throws Exception {
        log.debug("댓글 인수 확인(댓글내용) : {}", comment.getContent());
        boardService.addComment(comment);
    }

    @RequestMapping(value = "/showCommentList")
    @ResponseBody
    public List<PostCommentDTO> showCommentList(int postNum) throws Exception {
        return boardService.showCommentList(postNum);
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