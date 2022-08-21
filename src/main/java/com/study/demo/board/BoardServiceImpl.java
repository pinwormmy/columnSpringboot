package com.study.demo.board;

import com.study.demo.mapper.BoardMapper;
import com.study.demo.util.PageDTO;
import com.study.demo.util.PageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardServiceImpl implements BoardService{
    @Autowired
    BoardMapper boardMapper;
    @Override
    public List<BoardDTO> showPostList() throws Exception {
        return boardMapper.showPostList();
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
    public void deletePost(int postNum) throws Exception {
        boardMapper.deletePost(postNum);
    }

    @Override
    public PageDTO pageSetting() throws Exception {
        int recentPage = 1;	// 첫페이지
        return utilLoadingForPage(recentPage);
    }

    @Override
    public PageDTO pageSetting(int recentPage) throws Exception {
        return utilLoadingForPage(recentPage);
    }

    private PageDTO utilLoadingForPage(int recentPage) throws Exception {
        int totalPostCount = countTotalPost();
        PageService util = initPageUtil();
        return util.calculatePage(recentPage, totalPostCount);
    }

    @Override
    public int countTotalPost() throws Exception {
        return boardMapper.countTotalPost();
    }

    private PageService initPageUtil() {
        PageService util = new PageService();
        util.setDISPLAY_POST_LIMIT(5);
        util.setPAGESET_LIMIT(10);
        return util;
    }
}
