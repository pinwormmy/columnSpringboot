package com.study.demo.board;

import com.study.demo.util.PageDTO;

import java.util.List;

public interface BoardService {
    public List<BoardDTO> showPostList() throws Exception;

    void submitPost(BoardDTO board) throws Exception;

    BoardDTO readPost(int postNum) throws Exception;

    void submitModifyPost(BoardDTO post) throws Exception;

    void deletePost(int postNum) throws Exception;

    PageDTO pageSetting() throws Exception;

    PageDTO pageSetting(int recentPage) throws Exception;

    public int countTotalPost() throws Exception;

    List<BoardDTO> showSearchPostList(String searchType, String keyword) throws Exception;

    PageDTO pageSetting(int recentPage, String searchType, String keyword) throws Exception;

    PageDTO pageSetting(String searchType, String keyword) throws Exception;
}
