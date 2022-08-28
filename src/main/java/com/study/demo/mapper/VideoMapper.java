package com.study.demo.mapper;

import com.study.demo.board.BoardDTO;
import com.study.demo.util.PageDTO;
import com.study.demo.video.VideoDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface VideoMapper {
    void submitVideoPost(VideoDTO video) throws Exception;

    List<VideoDTO> showVideoList() throws Exception;

    void deleteVideoPost(int videoNum) throws Exception;

    int countTotalPost(PageDTO page) throws Exception;
}
