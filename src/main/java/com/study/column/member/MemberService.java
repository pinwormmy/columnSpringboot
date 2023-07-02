package com.study.column.member;

import com.study.column.util.PageDTO;

import java.util.List;

public interface MemberService {
    String isUniqueId(String id) throws Exception;

    void submitSignUp(MemberDTO memberDTO) throws Exception;

    MemberDTO checkLoginData(MemberDTO memberDTO) throws Exception;

    void submitModifyMyInfo(MemberDTO member) throws Exception;

    String isUniqueEmail(String email);

    PageDTO pageSetting(PageDTO page) throws Exception;

    MemberDTO getMemberInfo(String id);

    List<MemberDTO> getMemberList(PageDTO page) throws Exception;

    int getTotalMemberCount(PageDTO page) throws Exception;

    void submitModifyMemberByAdmin(MemberDTO memberDTO);

    boolean findPassword(String email);
}
