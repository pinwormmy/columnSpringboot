package com.study.demo.member;

import com.study.demo.board.BoardDTO;
import com.study.demo.board.BoardService;
import com.study.demo.board.PostCommentDTO;
import com.study.demo.util.PageDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.websocket.Session;
import java.util.List;

@Controller
@Slf4j
public class MemberController {
    @Autowired
    MemberService memberService;

    @RequestMapping("/login")
    public String login(HttpServletRequest request) {
        // 로그인 이전 페이지 정보 세션에 저장
        request.getSession().setAttribute("pageBeforeLogin", request.getHeader("Referer"));
        return "login";
    }

    @RequestMapping("/signUp")
    public String signUp() {
        return "signUp";
    }

    @RequestMapping("/isUniqueId")
    @ResponseBody
    public String isUniqueId(String id) throws Exception {
        log.debug("(중복확인용)ID 입력 확인: {}", id);
        return memberService.isUniqueId(id);
    }

    @RequestMapping(value = "/submitSignUp", method = RequestMethod.POST)
    public String submitSignUp(MemberDTO memberDTO, HttpSession httpSession) throws Exception {
        memberService.submitSignUp(memberDTO);
        httpSession.setAttribute("member", memberService.checkLoginData(memberDTO)); // 로그인도 해줌
        log.debug("회원가입 확인: {}", memberDTO);
        return "redirect:/";
    }

    @RequestMapping(value = "/submitLogin", method = RequestMethod.POST)
    public String submitLogin(HttpSession session, MemberDTO memberDTO) throws Exception {  
        session.setAttribute("member", memberService.checkLoginData(memberDTO));
        log.debug("로그인 확인: {}", memberDTO);
        return "redirect:" + session.getAttribute("pageBeforeLogin");
    }

    @RequestMapping(value = "/logout")
    public String logout(HttpSession httpSession) {
        httpSession.invalidate();
        return "redirect:/";
    }

    @RequestMapping(value = "/myPage")
    public String myPage() {
        return "myPage";
    }

    @RequestMapping(value = "/modifyMyInfo")
    public String modifyMyInfo() {
        return "modifyMyInfo";
    }

    @RequestMapping(value = "/submitModifyMyInfo", method = RequestMethod.POST)
    public String submitModifyMyInfo(MemberDTO member, HttpSession session) throws Exception {
        memberService.submitModifyMyInfo(member);       
        session.setAttribute("member", memberService.checkLoginData(member)); // 재로그인해서 회원정보갱신
        return "myPage";
    }

    @RequestMapping(value = "/modifyMember")
    public String modifyMember() {
        return "modifyMember";
    }
}