package com.study.demo.video;

import com.study.demo.board.BoardDTO;
import com.study.demo.mapper.VideoMapper;
import com.study.demo.util.PageDTO;
import com.study.demo.util.PageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class VideoServiceImpl implements VideoService{

    @Autowired
    VideoMapper videoMapper;
    @Override
    public void submitVideoPost(VideoDTO video) throws Exception {
        videoMapper.submitVideoPost(video);
    }

    @Override
    public List<BoardDTO> showVideoList() throws Exception {
        return videoMapper.showVideoList();
    }

    @Override
    public void deleteVideoPost(int videoNum) throws Exception {
        videoMapper.deleteVideoPost(videoNum);
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
        return videoMapper.countTotalPost();
    }

    private PageService initPageUtil() {
        PageService util = new PageService();
        util.setDISPLAY_POST_LIMIT(5);
        util.setPAGESET_LIMIT(10);
        return util;
    }
}
