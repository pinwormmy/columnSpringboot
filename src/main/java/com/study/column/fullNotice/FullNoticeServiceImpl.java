package com.study.column.fullNotice;

import com.study.column.board.BoardDTO;
import com.study.column.mapper.FullNoticeMapper;
import com.study.column.openColumn.OpenColumnDTO;
import com.study.column.util.PageDTO;
import com.study.column.util.PageService;
import com.study.column.video.VideoDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class FullNoticeServiceImpl implements FullNoticeService {
    @Autowired
    FullNoticeMapper fullNoticeMapper;

    @Override
    public List<BoardDTO> showBoardList() throws Exception {
        return fullNoticeMapper.showBoardList();
    }

    @Override
    public List<OpenColumnDTO> showOpencolumnList() throws Exception {
        return fullNoticeMapper.showOpencolumnList();
    }

    @Override
    public List<VideoDTO> showVideoList() throws Exception {
        return fullNoticeMapper.showVideoList();
    }

    @Override
    public void submitPost(FullNoticeDTO board) throws Exception {
        fullNoticeMapper.submitPost(board);
    }

    @Override
    public FullNoticeDTO readPost(int postNum) throws Exception {
        return fullNoticeMapper.readPost(postNum);
    }

    @Override
    public void submitModifyPost(FullNoticeDTO post) throws Exception {
        fullNoticeMapper.submitModifyPost(post);
    }

    @Override
    public void deletePost(int postNum) throws Exception {
        fullNoticeMapper.deletePost(postNum);
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
        return fullNoticeMapper.countTotalPost(page);
    }

    private PageService initPageUtil() {
        PageService util = new PageService();
        util.setDISPLAY_POST_LIMIT(10);
        util.setPAGESET_LIMIT(10);
        return util;
    }

    @Override
    public void addComment(FullNoticeCommentDTO comment) throws Exception {
        fullNoticeMapper.addComment(comment);
    }

    @Override
    public List<FullNoticeCommentDTO> showCommentList(PageDTO page) throws Exception {
        return fullNoticeMapper.showCommentList(page);
    }

    @Override
    public void deleteComment(int commentNum) throws Exception {
        fullNoticeMapper.deleteComment(commentNum);
    }

    @Override
    public void updateCommentCount(int postNum) throws Exception {
        fullNoticeMapper.updateCommentCount(postNum);
    }

    @Override
    public void updateViews(int postNum) throws Exception {
        fullNoticeMapper.updateViews(postNum);
    }

    @Override
    public int checkViewUserIp(int postNum, String ip) throws Exception {
        return fullNoticeMapper.checkViewUserIp(postNum, ip);
    }

    @Override
    public void saveViewUserIp(int postNum, String ip) throws Exception {
        fullNoticeMapper.saveViewUserIp(postNum, ip);
    }

    @Override
    public List<FullNoticeDTO> showSelfNoticeList() throws Exception {
        return fullNoticeMapper.showSelfNoticeList();
    }
}
