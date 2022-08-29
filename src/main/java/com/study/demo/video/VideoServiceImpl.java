package com.study.demo.video;

import com.study.demo.board.BoardDTO;
import com.study.demo.mapper.VideoMapper;
import com.study.demo.util.PageDTO;
import com.study.demo.util.PageService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class VideoServiceImpl implements VideoService{

    @Autowired
    VideoMapper videoMapper;
    @Override
    public void submitVideoPost(VideoDTO video) throws Exception {
        videoMapper.submitVideoPost(video);
    }

    @Override
    public List<VideoDTO> showVideoList(PageDTO page) throws Exception {
        return videoMapper.showVideoList(page);
    }

    @Override
    public void deleteVideoPost(int videoNum) throws Exception {
        videoMapper.deleteVideoPost(videoNum);
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
        log.info("서비스단계에서 검색어 확인 : {}", page.getKeyword());
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
        util.setDISPLAY_POST_LIMIT(5);
        util.setPAGESET_LIMIT(10);
        return util;
    }
}
