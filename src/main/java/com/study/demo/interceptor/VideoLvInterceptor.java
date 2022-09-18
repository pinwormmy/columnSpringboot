package com.study.demo.interceptor;

import com.study.demo.member.MemberDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Slf4j
public class VideoLvInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HttpSession session = request.getSession();
        MemberDTO member = (MemberDTO)session.getAttribute("member");
        if (member == null || member.getMemberLevel() < 2){
            log.debug("해당 게시판 열람은 관리자 승인이 필요합니다.");
            response.sendRedirect("/");
            return false;
        }
        return true;
    }
}
