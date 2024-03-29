package com.study.column.mapper;

import com.study.column.video.VideoDTO;
import com.study.column.video.VideoCommentDTO;
import com.study.column.fullNotice.FullNoticeDTO;
import com.study.column.util.PageDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface VideoMapper {
    List<VideoDTO> showPostList(PageDTO page) throws Exception;

    void submitPost(VideoDTO board) throws Exception;

    void submitModifyPost(VideoDTO board) throws Exception;

    VideoDTO readPost(int postNum) throws Exception;

    void deletePost(int postNum) throws Exception;

    int countTotalPost(PageDTO page) throws Exception;

    void addComment(VideoCommentDTO comment) throws Exception;

    List<VideoCommentDTO> showCommentList(PageDTO page) throws Exception;

    void deleteComment(int commentNum) throws Exception;

    void updateCommentCount(int postNum) throws Exception;

    void updateViews(int postNum) throws Exception;

    int checkViewUserIp(@Param("postNum") int postNum, @Param("ip") String ip) throws Exception;

    void saveViewUserIp(@Param("postNum") int postNum, @Param("ip") String ip) throws Exception;

    List<VideoDTO> showSelfNoticeList() throws Exception;

    List<FullNoticeDTO> showFullNoticeList() throws Exception;

    int countTotalComment(PageDTO page) throws Exception;
}
