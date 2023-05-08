package com.study.column.member;

import com.study.column.mapper.MemberMapper;
import com.study.column.util.PageDTO;
import com.study.column.util.PageService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@Slf4j
public class MemberServiceImpl implements MemberService {

    @Autowired
    MemberMapper memberMapper;

    @Override
    public String isUniqueId(String id) throws Exception {
        return memberMapper.isUniqueId(id);
    }

    @Override
    public void submitSignUp(MemberDTO memberDTO) throws Exception {
        memberMapper.submitSignUp(memberDTO);
    }

    @Override
    public MemberDTO checkLoginData(MemberDTO memberDTO) throws Exception {
        return memberMapper.checkLoginData(memberDTO);
    }

    @Override
    public void submitModifyMyInfo(MemberDTO member) throws Exception {
        memberMapper.submitModifyMyInfo(member);
    }

    @Override
    public String isUniqueEmail(String email) {
        return memberMapper.isUniqueEmail(email);
    }

    @Override
    public PageDTO pageSetting(PageDTO page) throws Exception {
        checkPageAndKeyword(page);
        return utilLoadingForPage(page);
    }

    @Override
    public List<MemberDTO> getMemberList(PageDTO page) {
        return memberMapper.getMemberList(page);
    }

    private void checkPageAndKeyword(PageDTO page) {
        if(page.getRecentPage() < 1) { page.setRecentPage(1); }
        if(page.getSearchType() == null) { page.setSearchType("id"); }
        if(page.getKeyword() == null) { page.setKeyword(""); }
    }

    private PageDTO utilLoadingForPage(PageDTO page) throws Exception {
        log.debug("서비스단계에서 검색어 확인 : {}", page.getKeyword());
        page.setTotalPostCount(getTotalMemberCount(page));
        PageService util = initPageUtil();
        return util.calculatePage(page);
    }

    @Override
    public int getTotalMemberCount(PageDTO page) {
        return memberMapper.getTotalMemberCount(page);
    }

    private PageService initPageUtil() {
        PageService util = new PageService();
        util.setDISPLAY_POST_LIMIT(10);
        util.setPAGESET_LIMIT(10);
        return util;
    }

}
