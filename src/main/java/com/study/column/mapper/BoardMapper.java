package com.study.column.mapper;

import com.study.column.board.BoardDTO;
import com.study.column.board.PostCommentDTO;
import com.study.column.board.ViewsDetailDTO;
import com.study.column.fullNotice.FullNoticeDTO;
import com.study.column.util.PageDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BoardMapper {
    List<BoardDTO> showPostList(PageDTO page) throws Exception;

    void submitPost(BoardDTO board) throws Exception;

    void submitModifyPost(BoardDTO board) throws Exception;

    BoardDTO readPost(int postNum) throws Exception;

    void deletePost(int postNum) throws Exception;

    int countTotalPost(PageDTO page) throws Exception;

    void addComment(PostCommentDTO comment) throws Exception;

    List<PostCommentDTO> showCommentList(PageDTO page) throws Exception;

    void deleteComment(int commentNum) throws Exception;

    void updateCommentCount(int postNum) throws Exception;

    void updateViews(int postNum) throws Exception;

    int checkViewUserIp(ViewsDetailDTO viewsDetailDTO) throws Exception;

    void saveViewUserIp(ViewsDetailDTO viewsDetailDTO) throws Exception;

    List<BoardDTO> showSelfNoticeList() throws Exception;

    List<FullNoticeDTO> showFullNoticeList() throws Exception;

    int countTotalComment(PageDTO page) throws Exception;
}
