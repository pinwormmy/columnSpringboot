package com.study.demo.board;

import com.study.demo.util.PageDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
public class BoardController {
    @Autowired
    BoardService boardService;

    @GetMapping(value = "/board")
    public String board(Model model) throws Exception {
        List<BoardDTO> postList = boardService.showPostList();
        model.addAttribute("postList", postList);
        PageDTO page = boardService.pageSetting();
        model.addAttribute("page", page);
        return "board";
    }

    @GetMapping(value = "/boardPage")
    public String boardPage(Model model, int recentPage) throws Exception {
        List<BoardDTO> postList = boardService.showPostList();
        model.addAttribute("postList", postList);
        PageDTO page = boardService.pageSetting(recentPage);
        model.addAttribute("page", page);
        return "board";
    }

    @GetMapping(value = "/boardSearch")
    public String boardSearch(Model model, String searchType, String keyword) throws Exception {
        List<BoardDTO> postList = boardService.showSearchPostList(searchType, keyword);
        model.addAttribute("postList", postList);
        PageDTO page = boardService.pageSetting();
        model.addAttribute("page", page);
        return "board";
    }

    @RequestMapping("/readPost")
    public String post(Model model, int postNum) throws Exception {
        BoardDTO post = boardService.readPost(postNum);
        model.addAttribute("post", post);
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
        BoardDTO post = boardService.readPost(postNum);
        model.addAttribute("post", post);
        return "modifyPost";
    }

    @RequestMapping(value = "/submitModifyPost")
    public String submitModifyPost(BoardDTO post) throws Exception {
        boardService.submitModifyPost(post);
        return "redirect:/readPost?postNum=" + post.getPostNum();
    }
}