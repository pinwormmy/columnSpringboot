package com.study.demo.video;

import com.study.demo.board.BoardDTO;
import com.study.demo.util.PageDTO;

import java.rmi.server.ExportException;
import java.util.List;

public interface VideoService {
    void submitVideoPost(VideoDTO video) throws Exception;

    List<VideoDTO> showVideoList(PageDTO page) throws Exception;

    void deleteVideoPost(int videoNum) throws Exception;

    PageDTO pageSetting(PageDTO page) throws Exception;

    public int countTotalPost(PageDTO page) throws Exception;
}
