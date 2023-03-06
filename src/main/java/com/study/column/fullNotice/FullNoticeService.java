package com.study.column.fullNotice;

import com.study.column.board.BoardDTO;
import com.study.column.library.LibraryDTO;
import com.study.column.openColumn.OpenColumnDTO;
import com.study.column.util.PageDTO;
import com.study.column.video.VideoDTO;

import java.util.List;

public interface FullNoticeService {
    List<BoardDTO> showBoardList() throws Exception;

    List<OpenColumnDTO> showOpencolumnList() throws Exception;

    List<VideoDTO> showVideoList() throws Exception;

    List<LibraryDTO> showLibraryList() throws Exception;

    void submitPost(FullNoticeDTO board) throws Exception;

    FullNoticeDTO readPost(int postNum) throws Exception;

    void submitModifyPost(FullNoticeDTO post) throws Exception;

    void deletePost(int postNum) throws Exception;

    PageDTO pageSetting(PageDTO page) throws Exception;

    int countTotalPost(PageDTO page) throws Exception;

    void addComment(FullNoticeCommentDTO comment) throws Exception;

    List<FullNoticeCommentDTO> showCommentList(PageDTO page) throws Exception;

    void deleteComment(int commentNum) throws Exception;

    void updateCommentCount(int postNum) throws Exception;

    void updateViews(int postNum) throws Exception;

    int checkViewUserIp(int postNum, String ip) throws Exception;

    void saveViewUserIp(int postNum, String ip) throws Exception;

    List<FullNoticeDTO> showSelfNoticeList() throws Exception;
}
