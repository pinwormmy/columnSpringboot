package com.study.demo.board;

import ch.qos.logback.core.CoreConstants;
import com.study.demo.util.PageDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@Slf4j
public class BoardController {
    @Autowired
    BoardService boardService;

    // 페이징+검색 관련 코드 정리해라
    // 다른 사람 한거 참고하랬는데, 참고할만한 자료 찾기도 어렵다
    // 그냥 파라미터 두개(searchType, keyword) 묶는 방법만 클린코드 책에서 찾아보고 묶기 시작
    @GetMapping(value = "/board")
    public String board(PageDTO page, Model model) throws Exception {
        log.info("로그테스트");
        log.debug("현재페이지 {}", page.getRecentPage());
        log.debug("검색타입 {}", page.getSearchType());
        log.debug("검색단어 {}", page.getKeyword());
        List<BoardDTO> postList = boardService.showPostList();
        model.addAttribute("postList", postList);
        page = boardService.pageSetting(page);
        model.addAttribute("page", page);
        return "board";
    }

    @GetMapping(value = "/boardPage")
    public String boardPage(PageDTO page, Model model) throws Exception {
        log.info("로그테스트");
        log.debug("근데 로그 왜 안나오냐");
        log.debug("현재페이지 {}", page.getRecentPage());
        log.debug("검색타입 {}", page.getSearchType());
        log.debug("검색단어 {}", page.getKeyword());
        List<BoardDTO> postList = boardService.showPostList();
        model.addAttribute("postList", postList);
        page = boardService.pageSetting(page);
        model.addAttribute("page", page);
        return "board";
    }

    @GetMapping(value = "/boardSearch")
    public String boardSearch(PageDTO page, Model model) throws Exception {
        log.info("현재페이지 {}", page.getRecentPage());
        log.info("검색타입 {}", page.getSearchType());

        List<BoardDTO> postList = boardService.showPostList();
        model.addAttribute("postList", postList);
        page = boardService.pageSetting(page);
        model.addAttribute("page", page);
        log.info("검색단어 {}", page.getKeyword());
        return "boardSearch";
    }

    @GetMapping(value = "/boardSearchPage")
    public String boardSearchPage(@ModelAttribute PageDTO page, Model model) throws Exception {
        List<BoardDTO> postList = boardService.showPostList();
        model.addAttribute("postList", postList);
        page = boardService.pageSetting(page);
        model.addAttribute("page", page);
        log.info("현재페이지 {}", page.getRecentPage());
        log.info("검색타입 {}", page.getSearchType());
        log.info("검색단어 {}", page.getKeyword());
        return "redirect:/boardSearch";
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