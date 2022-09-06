package com.study.demo.board;

import com.study.demo.mapper.BoardMapper;
import com.study.demo.util.PageDTO;
import com.study.demo.util.PageService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class BoardServiceImpl implements BoardService{
    @Autowired
    BoardMapper boardMapper;
    @Override
    public List<BoardDTO> showPostList(PageDTO page) throws Exception {
        return boardMapper.showPostList(page);
    }

    @Override
    public void submitPost(BoardDTO board) throws Exception {
        boardMapper.submitPost(board);
    }

    @Override
    public BoardDTO readPost(int postNum) throws Exception {
        return boardMapper.readPost(postNum);
    }

    @Override
    public void submitModifyPost(BoardDTO post) throws Exception {
        boardMapper.submitModifyPost(post);
    }

    @Override
    public void deletePost(int postNum) throws Exception {
        boardMapper.deletePost(postNum);
    }

    @Override
    public PageDTO pageSetting(PageDTO page) throws Exception {
        checkPageAndKeyword(page);
        return utilLoadingForPage(page);
    }

    private void checkPageAndKeyword(PageDTO page) {
        if(page.getRecentPage() < 1) { page.setRecentPage(1); }
        if(page.getSearchType() == null) { page.setSearchType("title"); }
        if(page.getKeyword() == null) { page.setKeyword(""); }
    }

    private PageDTO utilLoadingForPage(PageDTO page) throws Exception {
        log.debug("서비스단계에서 검색어 확인 : {}", page.getKeyword());
        page.setTotalPostCount(countTotalPost(page));
        PageService util = initPageUtil();
        return util.calculatePage(page);
    }

    @Override
    public int countTotalPost(PageDTO page) throws Exception {
        return boardMapper.countTotalPost(page);
    }

    private PageService initPageUtil() {
        PageService util = new PageService();
        util.setDISPLAY_POST_LIMIT(10);
        util.setPAGESET_LIMIT(10);
        return util;
    }

    @Override
    public void addComment(PostCommentDTO comment) throws Exception {
        boardMapper.addComment(comment);
    }

    @Override
    public List<PostCommentDTO> showCommentList(int postNum) throws Exception {
        return boardMapper.showCommentList(postNum);
    }

    @Override
    public void deleteComment(int commentNum) throws Exception {
        boardMapper.deleteComment(commentNum);
    }

    @Override
    public void updateCommentCount(int postNum) throws Exception {
        boardMapper.updateCommentCount(postNum);
    }
}
