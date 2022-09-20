package com.study.demo.interceptor;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new BoardLvInterceptor())
                .addPathPatterns("/board/**", "/video/**", "/fullNotice/**", "/openColumn/**")
                .excludePathPatterns("/css/**", "/fonts/**", "/board/list/**", "/video/list/**",
                        "/fullNotice/list/**", "/openColumn/list/**", "/openColumn/readPost/**",
                        "/fullNotice/readPost/**", "/**/showCommentList/**");
        registry.addInterceptor(new AdminInterceptor())
                .addPathPatterns("/**/writePost/**", "/**/modifyPost/**");
    }

}
