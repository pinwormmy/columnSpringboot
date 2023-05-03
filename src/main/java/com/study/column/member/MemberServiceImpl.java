package com.study.column.member;

import com.study.column.mapper.MemberMapper;
import com.study.column.util.PageDTO;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
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
    public List<MemberDTO> getMemberList() {
        return memberMapper.getMemberList();
    }

    @Override
    public PageDTO pageSetting(PageDTO page) throws Exception {
        // 게시판에서 사용한 로직을 참고하여 페이지 설정 로직을 구현합니다.
    }

    @Override
    public List<MemberDTO> getMemberList(PageDTO page) throws Exception {
        // 게시판에서 사용한 로직을 참고하여 회원 목록 조회 로직을 구현합니다.
    }

    @Override
    public int getTotalMemberCount(PageDTO page) throws Exception {
        // 게시판에서 사용한 로직을 참고하여 전체 회원 수 조회 로직을 구현합니다.
    }
}
