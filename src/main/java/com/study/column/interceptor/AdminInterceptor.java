package com.study.column.interceptor;

import com.study.column.member.MemberDTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Slf4j
public class AdminInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {
        HttpSession session = request.getSession();
        MemberDTO member = (MemberDTO)session.getAttribute("member");
        if (member == null || member.getGrade() != 3){
            log.debug("해당 기능은 관리자만 사용 가능합니다.");
            response.sendRedirect("/");
            return false;
        }
        return true;
    }
}
