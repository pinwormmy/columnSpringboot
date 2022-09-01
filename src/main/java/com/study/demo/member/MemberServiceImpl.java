package com.study.demo.member;

import com.study.demo.mapper.MemberMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

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
}
