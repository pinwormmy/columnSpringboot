package com.study.demo.openColumn;

import com.study.demo.util.PageDTO;

import java.util.List;

public interface OpenColumnService {
    List<OpenColumnDTO> showPostList(PageDTO page) throws Exception;

    void submitPost(OpenColumnDTO board) throws Exception;

    OpenColumnDTO readPost(int postNum) throws Exception;

    void submitModifyPost(OpenColumnDTO post) throws Exception;

    void deletePost(int postNum) throws Exception;

    PageDTO pageSetting(PageDTO page) throws Exception;

    int countTotalPost(PageDTO page) throws Exception;

    void addComment(OpenColumnCommentDTO comment) throws Exception;

    List<OpenColumnCommentDTO> showCommentList(int postNum) throws Exception;

    void deleteComment(int commentNum) throws Exception;

    void updateCommentCount(int postNum) throws Exception;

    void updateViews(int postNum) throws Exception;

    int checkViewUserIp(int postNum, String ip) throws Exception;

    void saveViewUserIp(int postNum, String ip) throws Exception;

    List<OpenColumnDTO> showSelfNoticeList() throws Exception;
}
