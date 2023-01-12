package com.study.column.mapper;

import com.study.column.library.LibraryDTO;
import com.study.column.library.LibraryCommentDTO;
import com.study.column.fullNotice.FullNoticeDTO;
import com.study.column.library.LibraryFileDTO;
import com.study.column.util.PageDTO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface LibraryMapper {
    List<LibraryDTO> showPostList(PageDTO page) throws Exception;

    void submitPost(LibraryDTO board) throws Exception;

    void submitModifyPost(LibraryDTO board) throws Exception;

    LibraryDTO readPost(int postNum) throws Exception;

    void deletePost(int postNum) throws Exception;

    int countTotalPost(PageDTO page) throws Exception;

    void addComment(LibraryCommentDTO comment) throws Exception;

    List<LibraryCommentDTO> showCommentList(PageDTO page) throws Exception;

    void deleteComment(int commentNum) throws Exception;

    void updateCommentCount(int postNum) throws Exception;

    void updateViews(int postNum) throws Exception;

    int checkViewUserIp(@Param("postNum") int postNum, @Param("ip") String ip) throws Exception;

    void saveViewUserIp(@Param("postNum") int postNum, @Param("ip") String ip) throws Exception;

    List<LibraryDTO> showSelfNoticeList() throws Exception;

    List<FullNoticeDTO> showFullNoticeList() throws Exception;

    int countTotalComment(PageDTO page) throws Exception;

    int getPostNumBeforeInsert() throws Exception;

    void insertBoardFileList(List<LibraryFileDTO> fileList) throws Exception;

    List<LibraryFileDTO> showFileListInPost(int postNum) throws Exception;
}
