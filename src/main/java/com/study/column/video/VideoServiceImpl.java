package com.study.column.video;

import com.study.column.fullNotice.FullNoticeDTO;
import com.study.column.mapper.VideoMapper;
import com.study.column.util.PageDTO;
import com.study.column.util.PageService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class VideoServiceImpl implements VideoService {
    @Autowired
    VideoMapper videoMapper;
    @Override
    public List<VideoDTO> showPostList(PageDTO page) throws Exception {
        return videoMapper.showPostList(page);
    }

    @Override
    public void submitPost(VideoDTO board) throws Exception {
        videoMapper.submitPost(board);
    }

    @Override
    public VideoDTO readPost(int postNum) throws Exception {
        return videoMapper.readPost(postNum);
    }

    @Override
    public void submitModifyPost(VideoDTO post) throws Exception {
        videoMapper.submitModifyPost(post);
    }

    @Override
    public void deletePost(int postNum) throws Exception {
        videoMapper.deletePost(postNum);
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
        return videoMapper.countTotalPost(page);
    }

    private PageService initPageUtil() {
        PageService util = new PageService();
        util.setDISPLAY_POST_LIMIT(10);
        util.setPAGESET_LIMIT(10);
        return util;
    }

    @Override
    public void addComment(VideoCommentDTO comment) throws Exception {
        videoMapper.addComment(comment);
    }

    @Override
    public List<VideoCommentDTO> showCommentList(PageDTO page) throws Exception {
        return videoMapper.showCommentList(page);
    }

    @Override
    public void deleteComment(int commentNum) throws Exception {
        videoMapper.deleteComment(commentNum);
    }

    @Override
    public void updateCommentCount(int postNum) throws Exception {
        videoMapper.updateCommentCount(postNum);
    }

    @Override
    public void updateViews(int postNum) throws Exception {
        videoMapper.updateViews(postNum);
    }

    @Override
    public int checkViewUserIp(int postNum, String ip) throws Exception {
        return videoMapper.checkViewUserIp(postNum, ip);
    }

    @Override
    public void saveViewUserIp(int postNum, String ip) throws Exception {
        videoMapper.saveViewUserIp(postNum, ip);
    }

    @Override
    public List<VideoDTO> showSelfNoticeList() throws Exception {
        return videoMapper.showSelfNoticeList();
    }

    @Override
    public List<FullNoticeDTO> showFullNoticeList() throws Exception {
        return videoMapper.showFullNoticeList();
    }
}
