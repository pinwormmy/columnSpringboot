package com.study.demo.mapper;

import com.study.demo.board.BoardDTO;
import com.study.demo.video.VideoDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface VideoMapper {
    void submitVideoPost(VideoDTO video) throws Exception;

    List<BoardDTO> showVideoList() throws Exception;
}
