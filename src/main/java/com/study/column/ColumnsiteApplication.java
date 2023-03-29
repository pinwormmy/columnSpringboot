package com.study.column;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.cache.annotation.EnableCaching;

@MapperScan(value={"com.study.column.mapper"})
@SpringBootApplication
public class ColumnsiteApplication extends SpringBootServletInitializer {

	public static void main(String[] args) {
		SpringApplication.run(ColumnsiteApplication.class, args);
	}

	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder applicationBuilder) {
		return applicationBuilder.sources(ServletInitializer.class);
	}

}
