package com.study.demo.board;

import java.util.List;

public interface BoardService {
    public List<BoardDTO> showPostList() throws Exception;

    void submitPost(BoardDTO board) throws Exception;

    BoardDTO readPost(int postNum) throws Exception;

    void deletePost(int postNum) throws Exception;
}
