package com.study.demo.interceptor;

import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new BoardLvInterceptor())
                .addPathPatterns("/readPost/**")
                .excludePathPatterns("/css/**", "/fonts/**");

        registry.addInterceptor(new VideoLvInterceptor())
                .addPathPatterns("/video/**")
                .excludePathPatterns("/video/list/**", "/css/**", "/fonts/**");
    }

}
