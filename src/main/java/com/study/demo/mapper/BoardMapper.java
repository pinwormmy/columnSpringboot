package com.study.demo.mapper;

import com.study.demo.board.BoardDTO;
import com.study.demo.util.PageDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface BoardMapper {
    List<BoardDTO> showPostList(PageDTO page) throws Exception;

    void submitPost(BoardDTO board) throws Exception;

    void submitModifyPost(BoardDTO postNum) throws Exception;

    BoardDTO readPost(int postNum) throws Exception;

    void deletePost(int postNum) throws Exception;

    int countTotalPost(PageDTO page) throws Exception;

}
