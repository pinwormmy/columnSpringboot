package com.study.column.board;

import com.study.column.member.MemberDTO;
import com.study.column.util.CookieUtils;
import com.study.column.util.IpService;
import com.study.column.util.PageDTO;
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
import javax.servlet.http.HttpSession;
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
        log.debug(page.toString());
        return "board/board";
    }

    @GetMapping("/readPost")
    public String post(Model model, HttpServletRequest request, HttpServletResponse response) throws Exception {
        int postNum = Integer.parseInt(request.getParameter("postNum"));
        logIpAndUpdateViews(request, response, postNum);
        model.addAttribute("post", boardService.readPost(postNum));
        model.addAttribute("viewsDetails", boardService.getViewsDetailsByPostNum(postNum));
        return "board/readPost";
    }
    private void logIpAndUpdateViews(HttpServletRequest request, HttpServletResponse response, int postNum) throws Exception {
        String ip = IpService.getRemoteIP(request);
        HttpSession session = request.getSession();
        MemberDTO memberDTO = (MemberDTO) session.getAttribute("member");
        String realName = null;
        if (memberDTO != null) {
            realName = memberDTO.getRealName();
        }
        log.debug("조회로그 : 로그인한 아이디값 받아오기: {}", realName);

        ViewsDetailDTO viewsDetailDTO = new ViewsDetailDTO();
        viewsDetailDTO.setPostNum(postNum);
        viewsDetailDTO.setIp(ip);
        viewsDetailDTO.setRealName(realName);

        Cookie postViewCookie = CookieUtils.getPostViewCookie(request, postNum);
        if (postViewCookie == null) {
            if (boardService.checkViewUserIp(viewsDetailDTO) == 0) {
                boardService.saveViewUserIp(viewsDetailDTO);
                boardService.updateViews(postNum);
            } else {
                boardService.saveViewUserIp(viewsDetailDTO);
            }
            response.addCookie(CookieUtils.createPostViewCookie(postNum));
        } else {
            // 쿠키가 존재하므로, 같은 사용자가 5분 이내에 접속한 것으로 판단하고 기록하지 않습니다.
            log.debug("조회로그 : 5분 이내에 이미 조회한 사용자로 판단되어 기록을 생략합니다.");
        }
    }

    @RequestMapping("/writePost")
    public String writePost() {
        return "board/writePost";
    }

    @RequestMapping("/submitPost")
    public String submitPost(BoardDTO post) throws Exception {
        boardService.submitPost(post);
        return "redirect:/board/list";
    }

    @RequestMapping("/deletePost")
    public String deletePost(int postNum) throws Exception {
        boardService.deletePost(postNum);
        return "redirect:/board/list";
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

    @RequestMapping(value = "/commentPageSetting")
    @ResponseBody
    public PageDTO commentPageSetting(@RequestBody PageDTO page) throws Exception {
        return boardService.pageSetting(page);
    }

    @RequestMapping(value = "/showCommentList")
    @ResponseBody
    public List<PostCommentDTO> showCommentList(@RequestBody PageDTO page) throws Exception {
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