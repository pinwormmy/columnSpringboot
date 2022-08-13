package com.study.demo.video;

import com.study.demo.board.BoardDTO;

import java.rmi.server.ExportException;
import java.util.List;

public interface VideoService {
    void submitVideoPost(VideoDTO video) throws Exception;

    List<BoardDTO> showVideoList() throws Exception;

    void deleteVideoPost(int videoNum) throws Exception;
}
