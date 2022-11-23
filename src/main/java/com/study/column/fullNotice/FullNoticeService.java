package com.study.column.fullNotice;

import com.study.column.util.PageDTO;

import java.util.List;

public interface FullNoticeService {
    List<FullNoticeDTO> showPostList(PageDTO page) throws Exception;

    void submitPost(FullNoticeDTO board) throws Exception;

    FullNoticeDTO readPost(int postNum) throws Exception;

    void submitModifyPost(FullNoticeDTO post) throws Exception;

    void deletePost(int postNum) throws Exception;

    PageDTO pageSetting(PageDTO page) throws Exception;

    int countTotalPost(PageDTO page) throws Exception;

    void addComment(FullNoticeCommentDTO comment) throws Exception;

    List<FullNoticeCommentDTO> showCommentList(int postNum) throws Exception;

    void deleteComment(int commentNum) throws Exception;

    void updateCommentCount(int postNum) throws Exception;

    void updateViews(int postNum) throws Exception;

    int checkViewUserIp(int postNum, String ip) throws Exception;

    void saveViewUserIp(int postNum, String ip) throws Exception;

    List<FullNoticeDTO> showSelfNoticeList() throws Exception;
}
