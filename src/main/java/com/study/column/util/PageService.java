package com.study.column.util;

import lombok.extern.slf4j.Slf4j;

// 추후 코드 어떻게 정리할지, 서비스로 치는게 맞는지 구현부 따로 두는게 맞는지 알아보기
@Slf4j
public class PageService {

    int DISPLAY_POST_LIMIT = 10;
    int PAGESET_LIMIT = 10;

    public void setDISPLAY_POST_LIMIT(int displayPostLimit) {
        this.DISPLAY_POST_LIMIT = displayPostLimit;
    }

    public void setPAGESET_LIMIT(int pageSetLimit) {
        this.PAGESET_LIMIT = pageSetLimit;
    }

    public PageDTO calculatePage(PageDTO page) throws Exception {

        int postEndPoint = page.getRecentPage() * DISPLAY_POST_LIMIT;
        int postBeginPoint = postEndPoint - DISPLAY_POST_LIMIT;

        int totalPage = (int)Math.ceil((double)page.getTotalPostCount() / DISPLAY_POST_LIMIT);
        int pageBeginPoint = (page.getRecentPage()-1) / PAGESET_LIMIT * PAGESET_LIMIT + 1;
        int pageEndPoint = pageBeginPoint + PAGESET_LIMIT - 1;
        if(pageEndPoint > totalPage)
            pageEndPoint = totalPage;

        int prevPageSetPoint = pageBeginPoint - 1;
        int nextPageSetPoint = pageBeginPoint + PAGESET_LIMIT;

        page.setPageBeginPoint(pageBeginPoint);
        page.setPostEndPoint(postEndPoint);
        page.setDisplayPostLimit(DISPLAY_POST_LIMIT);
        page.setPostBeginPoint(postBeginPoint);
        page.setPageEndPoint(pageEndPoint);
        page.setPrevPageSetPoint(prevPageSetPoint);
        page.setNextPageSetPoint(nextPageSetPoint);
        page.setTotalPage(totalPage);
        log.debug("페이지 서비스단계 : 페이지 계산 후 : {}", page);
        return page;
    }
}
