package com.study.column.mapper;

import com.study.column.member.MemberDTO;
import com.study.column.util.PageDTO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface MemberMapper {

    String isUniqueId(String id) throws Exception;

    void submitSignUp(MemberDTO memberDTO) throws Exception;

    MemberDTO checkLoginData(MemberDTO memberDTO) throws Exception;

    void submitModifyMyInfo(MemberDTO member) throws Exception;

    String isUniqueEmail(String email);

    int getTotalMemberCount(PageDTO page);

    MemberDTO getMemberInfo(String id);

    List<MemberDTO> getMemberList(PageDTO pageDTO);

    void submitModifyMemberByAdmin(MemberDTO memberDTO);
}
