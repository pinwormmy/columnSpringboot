package com.study.column.member;

import com.study.column.mapper.MemberMapper;
import com.study.column.util.PageDTO;
import com.study.column.util.PageService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.UUID;

@Service
@Slf4j
public class MemberServiceImpl implements MemberService {

    @Autowired
    MemberMapper memberMapper;

    @Autowired
    EmailService emailService;

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
    public MemberDTO getMemberInfo(String id) {
        return memberMapper.getMemberInfo(id);
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

    @Override
    public void submitModifyMemberByAdmin(MemberDTO memberDTO) {
        memberMapper.submitModifyMemberByAdmin(memberDTO);
    }

    public boolean findPassword(String email) {
        MemberDTO member = memberMapper.findByEmail(email);
        if (member == null) {
            return false;
        }

        // 임시 비밀번호 생성
        String tempPassword = UUID.randomUUID().toString().substring(0, 8);

        // DB에 임시 비밀번호로 업데이트
        member.setPw(tempPassword);
        memberMapper.updatePassword(member);

        // 이메일로 아이디 및 임시 비밀번호 보내기
        try {
            emailService.sendNewPasswordMessage(email, tempPassword);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return true;
    }

    private PageService initPageUtil() {
        PageService util = new PageService();
        util.setDISPLAY_POST_LIMIT(10);
        util.setPAGESET_LIMIT(10);
        return util;
    }

    @Override
    public boolean sendPasswordResetLink(String email) {
        MemberDTO member = memberMapper.findByEmail(email);
        if (member == null) {
            return false;
        }

        // 인증 토큰 생성
        String token = UUID.randomUUID().toString();

        // DB에 인증 토큰 저장
        member.setResetToken(token);
        memberMapper.updateResetToken(member);

        // 이메일로 인증 링크 보내기
        try {
            emailService.sendPasswordResetLink(email, token);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return true;
    }

}
