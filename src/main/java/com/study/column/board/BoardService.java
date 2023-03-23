package com.study.column.board;

import com.study.column.fullNotice.FullNoticeDTO;
import com.study.column.util.PageDTO;
import org.springframework.cache.annotation.CacheEvict;
import org.springframework.cache.annotation.Cacheable;
import org.springframework.cache.annotation.Caching;

import java.util.List;

public interface BoardService {
    List<BoardDTO> showPostList(PageDTO page) throws Exception;

    void submitPost(BoardDTO board) throws Exception;

    BoardDTO readPost(int postNum) throws Exception;

    void submitModifyPost(BoardDTO post) throws Exception;

    void deletePost(int postNum) throws Exception;

    PageDTO pageSetting(PageDTO page) throws Exception;

    int countTotalPost(PageDTO page) throws Exception;

    void addComment(PostCommentDTO comment) throws Exception;

    List<PostCommentDTO> showCommentList(PageDTO page) throws Exception;

    void deleteComment(int commentNum) throws Exception;

    void updateCommentCount(int postNum) throws Exception;

    void updateViews(int postNum) throws Exception;

    @Cacheable(value = "viewUserIpCache", key = "#viewsDetailDTO.postNum + '_' + #viewsDetailDTO.ip")
    int checkViewUserIp(ViewsDetailDTO viewsDetailDTO) throws Exception;

    @Caching(evict = {
            @CacheEvict(value = "viewUserIpCache", key = "#viewsDetailDTO.postNum + '_' + #viewsDetailDTO.ip", allEntries = true),
            @CacheEvict(value = "postCache", key = "#viewsDetailDTO.postNum", allEntries = true)
    })
    void saveViewUserIp(ViewsDetailDTO viewsDetailDTO) throws Exception;

    public List<ViewsDetailDTO> getViewsDetailsByPostNum(int postNum);

    List<BoardDTO> showSelfNoticeList() throws Exception;

    List<FullNoticeDTO> showFullNoticeList() throws Exception;
}
