package com.study.column.library;

import com.study.column.fullNotice.FullNoticeDTO;
import com.study.column.util.PageDTO;

import java.util.List;

public interface LibraryService {
    List<LibraryDTO> showPostList(PageDTO page) throws Exception;

    void submitPost(LibraryDTO board) throws Exception;

    LibraryDTO readPost(int postNum) throws Exception;

    void submitModifyPost(LibraryDTO post) throws Exception;

    void deletePost(int postNum) throws Exception;

    PageDTO pageSetting(PageDTO page) throws Exception;

    int countTotalPost(PageDTO page) throws Exception;

    void addComment(LibraryCommentDTO comment) throws Exception;

    List<LibraryCommentDTO> showCommentList(PageDTO page) throws Exception;

    void deleteComment(int commentNum) throws Exception;

    void updateCommentCount(int postNum) throws Exception;

    void updateViews(int postNum) throws Exception;

    int checkViewUserIp(int postNum, String ip) throws Exception;

    void saveViewUserIp(int postNum, String ip) throws Exception;

    List<LibraryDTO> showSelfNoticeList() throws Exception;

    List<FullNoticeDTO> showFullNoticeList() throws Exception;
}
