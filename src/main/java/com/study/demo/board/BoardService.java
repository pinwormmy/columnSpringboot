package com.study.demo.board;

import com.study.demo.fullNotice.FullNoticeDTO;
import com.study.demo.util.PageDTO;

import java.util.List;

public interface BoardService {
    List<BoardDTO> showPostList(PageDTO page) throws Exception;

    void submitPost(BoardDTO board) throws Exception;

    BoardDTO readPost(int postNum) throws Exception;

    void submitModifyPost(BoardDTO post) throws Exception;

    void deletePost(int postNum) throws Exception;

    PageDTO pageSetting(PageDTO page) throws Exception;

    int countTotalPost(PageDTO page) throws Exception;

    void addComment(PostCommentDTO comment) throws Exception;

    List<PostCommentDTO> showCommentList(int postNum) throws Exception;

    void deleteComment(int commentNum) throws Exception;

    void updateCommentCount(int postNum) throws Exception;

    void updateViews(int postNum) throws Exception;

    int checkViewUserIp(int postNum, String ip) throws Exception;

    void saveViewUserIp(int postNum, String ip) throws Exception;

    List<BoardDTO> showSelfNoticeList() throws Exception;

    List<FullNoticeDTO> showFullNoticeList() throws Exception;
}
