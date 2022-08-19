package com.study.demo.util;

public class PageService {

    int DISPLAY_POST_LIMIT = 10;
    int PAGESET_LIMIT = 10;

    public void setDISPLAY_POST_LIMIT(int displayPostLimit) {
        this.DISPLAY_POST_LIMIT = displayPostLimit;
    }

    public void setPAGESET_LIMIT(int pageSetLimit) {
        this.PAGESET_LIMIT = pageSetLimit;
    }

    public PageDTO calculatePage(int recentPage, int totalPostCount) throws Exception {

        PageDTO page = new PageDTO();

        int postEndPoint = recentPage * DISPLAY_POST_LIMIT - 1;
        int postBeginPoint = postEndPoint - (DISPLAY_POST_LIMIT - 1);

        int totalPage = (int)Math.ceil((double)totalPostCount / DISPLAY_POST_LIMIT);
        int pageBeginPoint = (recentPage-1) / PAGESET_LIMIT * PAGESET_LIMIT + 1;
        int pageEndPoint = pageBeginPoint + PAGESET_LIMIT - 1;
        if(pageEndPoint > totalPage)
            pageEndPoint = totalPage;

        int prevPageSetPoint = pageEndPoint - PAGESET_LIMIT;
        int nextPageSetPoint = pageBeginPoint + PAGESET_LIMIT;

        page.setPageBeginPoint(pageBeginPoint);
        page.setPostEndPoint(postEndPoint);
        page.setPostBeginPoint(postBeginPoint);
        page.setPageEndPoint(pageEndPoint);
        page.setPrevPageSetPoint(prevPageSetPoint);
        page.setNextPageSetPoint(nextPageSetPoint);
        page.setTotalPage(totalPage);

        return page;
    }
}
