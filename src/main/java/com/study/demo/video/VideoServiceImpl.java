package com.study.demo.video;

import com.study.demo.board.BoardDTO;
import com.study.demo.mapper.VideoMapper;
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
}
