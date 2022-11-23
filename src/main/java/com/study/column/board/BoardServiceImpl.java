package com.study.column.board;

import com.study.column.fullNotice.FullNoticeDTO;
import com.study.column.mapper.BoardMapper;
import com.study.column.util.PageDTO;
import com.study.column.util.PageService;
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
        if(page.getPostNum() != 0) {return boardMapper.countTotalComment(page);}
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
    public List<PostCommentDTO> showCommentList(PageDTO page) throws Exception {
        return boardMapper.showCommentList(page);
    }

    @Override
    public void deleteComment(int commentNum) throws Exception {
        boardMapper.deleteComment(commentNum);
    }

    @Override
    public void updateCommentCount(int postNum) throws Exception {
        boardMapper.updateCommentCount(postNum);
    }

    @Override
    public void updateViews(int postNum) throws Exception {
        boardMapper.updateViews(postNum);
    }

    @Override
    public int checkViewUserIp(int postNum, String ip) throws Exception {
        return boardMapper.checkViewUserIp(postNum, ip);
    }

    @Override
    public void saveViewUserIp(int postNum, String ip) throws Exception {
        boardMapper.saveViewUserIp(postNum, ip);
    }

    @Override
    public List<BoardDTO> showSelfNoticeList() throws Exception {
        return boardMapper.showSelfNoticeList();
    }

    @Override
    public List<FullNoticeDTO> showFullNoticeList() throws Exception {
        return boardMapper.showFullNoticeList();
    }
}
