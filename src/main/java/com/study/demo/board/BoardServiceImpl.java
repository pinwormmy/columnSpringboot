package com.study.demo.board;

import com.study.demo.mapper.BoardMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BoardServiceImpl implements BoardService{
    @Autowired
    BoardMapper boardMapper;
    @Override
    public List<BoardDTO> showPostList() throws Exception {
        return boardMapper.showPostList();
    }
}
