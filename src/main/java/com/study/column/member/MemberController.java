package com.study.column.member;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@Slf4j
public class MemberController {
    @Autowired
    MemberService memberService;
    @Autowired
    EmailService emailService;
    
    // 승인 게시판에 아이피 로그 기능 만들기

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

    @RequestMapping(value = "/loginForDemo")
    public String loginForDemo(HttpServletRequest request) throws Exception {
        request.getSession().setAttribute("pageBeforeLogin", request.getHeader("Referer"));
        MemberDTO member = new MemberDTO();
        member.setId("midori"); // midori는 시연용 일반계정입니다.
        member.setPw("1111");
        MemberDTO loginData = memberService.checkLoginData(member);
        HttpSession session = request.getSession();
        session.setAttribute("member", loginData);
        log.info("(시연용) 일반로그인 성공 : {}", loginData);
        return "redirect:" + session.getAttribute("pageBeforeLogin");
    }

    @RequestMapping(value = "/loginForDemoAsAdmin")
    public String loginForDemoAsAdmin(HttpServletRequest request) throws Exception {
        request.getSession().setAttribute("pageBeforeLogin", request.getHeader("Referer"));
        MemberDTO member = new MemberDTO();
        member.setId("admin"); // admin은 관리자계정입니다.
        member.setPw("1111");
        MemberDTO loginData = memberService.checkLoginData(member);
        HttpSession session = request.getSession();
        session.setAttribute("member", loginData);
        log.info("(시연용) 관리자로그인 성공 : {}", loginData);
        return "redirect:" + session.getAttribute("pageBeforeLogin");
    }

    @PostMapping("/emailConfirm")
    public String emailConfirm(@RequestParam String email) throws Exception {
        return emailService.sendSimpleMessage(email);
    }

    @GetMapping("/checkUniqueId")
    @ResponseBody
    public String checkUniqueId(String id) throws Exception {
        log.info("아이디 중복 확인 컨트롤러 작동");
        return memberService.isUniqueId(id);
    }
}