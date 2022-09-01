package com.study.demo.mapper;

import com.study.demo.member.MemberDTO;
import com.study.demo.util.PageDTO;
import com.study.demo.video.VideoDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MemberMapper {

    String isUniqueId(String id) throws Exception;

    void submitSignUp(MemberDTO memberDTO) throws Exception;

    MemberDTO checkLoginData(MemberDTO memberDTO) throws Exception;

    void submitModifyMyInfo(MemberDTO member) throws Exception;
}
