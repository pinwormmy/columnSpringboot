package com.study.demo.mapper;

import com.study.demo.video.VideoDTO;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface VideoMapper {
    void submitVideoPost(VideoDTO video) throws Exception;
}
