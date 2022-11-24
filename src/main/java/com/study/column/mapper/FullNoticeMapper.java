package com.study.column.mapper;

import com.study.column.board.BoardDTO;
import com.study.column.fullNotice.FullNoticeDTO;
import com.study.column.fullNotice.FullNoticeCommentDTO;
import com.study.column.openColumn.OpenColumnDTO;
import com.study.column.util.PageDTO;
import com.study.column.video.VideoDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface FullNoticeMapper {
    List<BoardDTO> showBoardList() throws Exception;

    List<OpenColumnDTO> showOpencolumnList() throws Exception;

    List<VideoDTO> showVideoList() throws Exception;

    void submitPost(FullNoticeDTO board) throws Exception;

    void submitModifyPost(FullNoticeDTO board) throws Exception;

    FullNoticeDTO readPost(int postNum) throws Exception;

    void deletePost(int postNum) throws Exception;

    int countTotalPost(PageDTO page) throws Exception;

    void addComment(FullNoticeCommentDTO comment) throws Exception;

    List<FullNoticeCommentDTO> showCommentList(int postNum) throws Exception;

    void deleteComment(int commentNum) throws Exception;

    void updateCommentCount(int postNum) throws Exception;

    void updateViews(int postNum) throws Exception;

    int checkViewUserIp(@Param("postNum") int postNum, @Param("ip") String ip) throws Exception;

    void saveViewUserIp(@Param("postNum") int postNum, @Param("ip") String ip) throws Exception;

    List<FullNoticeDTO> showSelfNoticeList() throws Exception;
}
