package com.study.column.library;

import com.study.column.fullNotice.FullNoticeDTO;
import com.study.column.mapper.LibraryMapper;
import com.study.column.util.PageDTO;
import com.study.column.util.PageService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class LibraryServiceImpl implements LibraryService {
    @Autowired
    LibraryMapper libraryMapper;
    @Override
    public List<LibraryDTO> showPostList(PageDTO page) throws Exception {
        return libraryMapper.showPostList(page);
    }

    @Override
    public void submitPost(LibraryDTO board) throws Exception {
        libraryMapper.submitPost(board);
    }

    @Override
    public LibraryDTO readPost(int postNum) throws Exception {
        return libraryMapper.readPost(postNum);
    }

    @Override
    public void submitModifyPost(LibraryDTO post) throws Exception {
        libraryMapper.submitModifyPost(post);
    }

    @Override
    public void deletePost(int postNum) throws Exception {
        libraryMapper.deletePost(postNum);
    }

    @Override
    public PageDTO pageSetting(PageDTO page) throws Exception {
        checkPageAndKeyword(page);
        return utilLoadingForPage(page);
    }

    private void checkPageAndKeyword(PageDTO page) {
        if(page.getRecentPage() < 1) { page.setRecentPage(1); }
        if(page.getSearchType() == null) { page.setSearchType("title"); }
        if(page.getKeyword() == null) { page.setKeyword(""); }
    }

    private PageDTO utilLoadingForPage(PageDTO page) throws Exception {
        log.debug("서비스단계에서 검색어 확인 : {}", page.getKeyword());
        page.setTotalPostCount(countTotalPost(page));
        PageService util = initPageUtil();
        return util.calculatePage(page);
    }

    @Override
    public int countTotalPost(PageDTO page) throws Exception {
        if(page.getPostNum() != 0) {return libraryMapper.countTotalComment(page);}
        return libraryMapper.countTotalPost(page);
    }

    private PageService initPageUtil() {
        PageService util = new PageService();
        util.setDISPLAY_POST_LIMIT(10);
        util.setPAGESET_LIMIT(10);
        return util;
    }

    @Override
    public void addComment(LibraryCommentDTO comment) throws Exception {
        libraryMapper.addComment(comment);
    }

    @Override
    public List<LibraryCommentDTO> showCommentList(PageDTO page) throws Exception {
        return libraryMapper.showCommentList(page);
    }

    @Override
    public void deleteComment(int commentNum) throws Exception {
        libraryMapper.deleteComment(commentNum);
    }

    @Override
    public void updateCommentCount(int postNum) throws Exception {
        libraryMapper.updateCommentCount(postNum);
    }

    @Override
    public void updateViews(int postNum) throws Exception {
        libraryMapper.updateViews(postNum);
    }

    @Override
    public int checkViewUserIp(int postNum, String ip) throws Exception {
        return libraryMapper.checkViewUserIp(postNum, ip);
    }

    @Override
    public void saveViewUserIp(int postNum, String ip) throws Exception {
        libraryMapper.saveViewUserIp(postNum, ip);
    }

    @Override
    public List<LibraryDTO> showSelfNoticeList() throws Exception {
        return libraryMapper.showSelfNoticeList();
    }

    @Override
    public List<FullNoticeDTO> showFullNoticeList() throws Exception {
        return libraryMapper.showFullNoticeList();
    }

    @Override
    public int getPostNumBeforeInsert() throws Exception {
        return libraryMapper.getPostNumBeforeInsert();
    }

    @Override
    public void insertBoardFileList(List<LibraryFileDTO> fileList) throws Exception {
        libraryMapper.insertBoardFileList(fileList);
    }

    @Override
    public List<LibraryFileDTO> showFileListInPost(int postNum) throws Exception {
        return libraryMapper.showFileListInPost(postNum);
    }
}
