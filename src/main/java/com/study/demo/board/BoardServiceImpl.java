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
    public PageDTO pageSetting(PageDTO page) throws Exception {
        page = checkPageAndKeyword(page);
        return utilLoadingForPage(page);
    }

    private PageDTO checkPageAndKeyword(PageDTO page) {
        if(page.getRecentPage() < 1) { page.setRecentPage(1); }
        if(page.getSearchType() == null) { page.setSearchType("title"); }
        if(page.getKeyword() == null) { page.setKeyword(""); }
        return page;
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

    private PageDTO utilLoadingForPage(PageDTO page) throws Exception {
        log.info("키워트 확인 : {}", page.getKeyword());
        int totalPostCount = countTotalPost2(page);
        PageService util = initPageUtil();
        return util.calculatePage(page.getRecentPage(), totalPostCount);
    }

    private int countTotalPostForSearch(String searchType, String keyword) throws Exception {
        return boardMapper.countTotalPostForSearch(searchType, keyword);
    }

    private int countTotalPost2(PageDTO page) throws Exception {
        return boardMapper.countTotalPost2(page);
    }

    private PageService initPageUtil() {
        PageService util = new PageService();
        util.setDISPLAY_POST_LIMIT(5);
        util.setPAGESET_LIMIT(10);
        return util;
    }


}
