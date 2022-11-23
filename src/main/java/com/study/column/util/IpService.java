package com.study.column.util;

import javax.servlet.http.HttpServletRequest;

public class IpService {
    public static String getRemoteIP(HttpServletRequest request){
        String ip = request.getHeader("X-FORWARDED-FOR");
        if (ip == null || ip.length() == 0) { ip = request.getHeader("Proxy-Client-IP"); }
        if (ip == null || ip.length() == 0) { ip = request.getHeader("WL-Proxy-Client-IP"); } //웹로직 서버
        if (ip == null || ip.length() == 0) { ip = request.getRemoteAddr() ; }
        return ip;
    }
}
