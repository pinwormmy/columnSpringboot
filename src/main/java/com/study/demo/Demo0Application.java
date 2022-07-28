package com.study.demo;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan(value={"com.study.demo.mapper"})
@SpringBootApplication
public class Demo0Application {

	public static void main(String[] args) {
		SpringApplication.run(Demo0Application.class, args);
	}

}
