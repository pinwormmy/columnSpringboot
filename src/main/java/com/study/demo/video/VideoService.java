package com.study.demo.video;

import com.study.demo.board.BoardDTO;

import java.util.List;

public interface VideoService {
    void submitVideoPost(VideoDTO video) throws Exception;

    List<BoardDTO> showVideoList() throws Exception;
}
