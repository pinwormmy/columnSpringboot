package com.study.demo.mapper;

import com.study.demo.board.BoardDTO;
import com.study.demo.board.PostCommentDTO;
import com.study.demo.openColumn.OpenColumnCommentDTO;
import com.study.demo.openColumn.OpenColumnDTO;
import com.study.demo.util.PageDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface OpenColumnMapper {
    List<OpenColumnDTO> showPostList(PageDTO page) throws Exception;

    void submitPost(OpenColumnDTO board) throws Exception;

    void submitModifyPost(OpenColumnDTO postNum) throws Exception;

    OpenColumnDTO readPost(int postNum) throws Exception;

    void deletePost(int postNum) throws Exception;

    int countTotalPost(PageDTO page) throws Exception;

    void addComment(OpenColumnCommentDTO comment) throws Exception;

    List<OpenColumnCommentDTO> showCommentList(int postNum) throws Exception;

    void deleteComment(int commentNum) throws Exception;

    void updateCommentCount(int postNum) throws Exception;

    void updateViews(int postNum) throws Exception;

    int checkViewUserIp(@Param("postNum") int postNum, @Param("ip") String ip) throws Exception;

    void saveViewUserIp(@Param("postNum") int postNum, @Param("ip") String ip) throws Exception;

    List<OpenColumnDTO> showSelfNoticeList() throws Exception;
}
