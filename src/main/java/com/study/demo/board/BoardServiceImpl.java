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
    public void submitModifyPost(BoardDTO post) throws Exception {
        boardMapper.submitModifyPost(post);
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

    @Override
    public List<BoardDTO> showSearchPostList(String searchType, String keyword) throws Exception {
        return boardMapper.showSearchPostList(searchType, keyword);
    }

    @Override
    public PageDTO pageSetting(String searchType, String keyword) throws Exception {
        int recentPage = 1;	// 첫페이지
        return utilLoadingForPage(recentPage, searchType, keyword);
    }

    @Override
    public PageDTO pageSetting(int recentPage, String searchType, String keyword) throws Exception {
        return utilLoadingForPage(recentPage, searchType, keyword);
    }

    private PageDTO utilLoadingForPage(int recentPage, String searchType, String keyword) throws Exception {
        int totalPostCount = countTotalPostForSearch(searchType, keyword);
        PageService util = initPageUtil();
        return util.calculatePage(recentPage, totalPostCount);
    }

    private int countTotalPostForSearch(String searchType, String keyword) throws Exception {
        return boardMapper.countTotalPostForSearch(searchType, keyword);
    }

    private PageService initPageUtil() {
        PageService util = new PageService();
        util.setDISPLAY_POST_LIMIT(5);
        util.setPAGESET_LIMIT(10);
        return util;
    }


}
