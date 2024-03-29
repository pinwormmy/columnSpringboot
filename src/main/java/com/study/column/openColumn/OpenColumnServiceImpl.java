package com.study.column.openColumn;

import com.study.column.fullNotice.FullNoticeDTO;
import com.study.column.mapper.OpenColumnMapper;
import com.study.column.util.PageDTO;
import com.study.column.util.PageService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class OpenColumnServiceImpl implements OpenColumnService {
    @Autowired
    OpenColumnMapper openColumnMapper;
    @Override
    public List<OpenColumnDTO> showPostList(PageDTO page) throws Exception {
        return openColumnMapper.showPostList(page);
    }

    @Override
    public void submitPost(OpenColumnDTO board) throws Exception {
        openColumnMapper.submitPost(board);
    }

    @Override
    public OpenColumnDTO readPost(int postNum) throws Exception {
        return openColumnMapper.readPost(postNum);
    }

    @Override
    public void submitModifyPost(OpenColumnDTO post) throws Exception {
        openColumnMapper.submitModifyPost(post);
    }

    @Override
    public void deletePost(int postNum) throws Exception {
        openColumnMapper.deletePost(postNum);
    }

    @Override
    public PageDTO pageSetting(PageDTO page) throws Exception {
        checkPageAndKeyword(page);
        return utilLoadingForPage(page);
    }

    @Override
    public PageDTO commentPageSetting(PageDTO page) throws Exception {
        if(page.getRecentPage() < 1) { page.setRecentPage(1); }
        return utilLoadingForCommentPage(page);
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

    private PageDTO utilLoadingForCommentPage(PageDTO page) throws Exception {
        page.setTotalPostCount(countTotalComment(page)); // 총댓글수 의미
        PageService util = initPageUtil();
        log.debug("서비스단계 댓글페이지 로직 확인 : {}", page);
        return util.calculatePage(page);
    }

    @Override
    public int countTotalPost(PageDTO page) throws Exception {
        return openColumnMapper.countTotalPost(page);
    }

    public int countTotalComment(PageDTO page) throws Exception {
        return openColumnMapper.countTotalComment(page);
    }

    private PageService initPageUtil() {
        PageService util = new PageService();
        util.setDISPLAY_POST_LIMIT(10);
        util.setPAGESET_LIMIT(10);
        return util;
    }

    @Override
    public void addComment(OpenColumnCommentDTO comment) throws Exception {
        openColumnMapper.addComment(comment);
    }

    @Override
    public List<OpenColumnCommentDTO> showCommentList(PageDTO page) throws Exception {
        return openColumnMapper.showCommentList(page);
    }

    @Override
    public void deleteComment(int commentNum) throws Exception {
        openColumnMapper.deleteComment(commentNum);
    }

    @Override
    public void updateCommentCount(int postNum) throws Exception {
        openColumnMapper.updateCommentCount(postNum);
    }

    @Override
    public void updateViews(int postNum) throws Exception {
        openColumnMapper.updateViews(postNum);
    }

    @Override
    public int checkViewUserIp(int postNum, String ip) throws Exception {
        return openColumnMapper.checkViewUserIp(postNum, ip);
    }

    @Override
    public void saveViewUserIp(int postNum, String ip) throws Exception {
        openColumnMapper.saveViewUserIp(postNum, ip);
    }

    @Override
    public List<OpenColumnDTO> showSelfNoticeList() throws Exception {
        return openColumnMapper.showSelfNoticeList();
    }

    @Override
    public List<FullNoticeDTO> showFullNoticeList() throws Exception {
        return openColumnMapper.showFullNoticeList();
    }

}
