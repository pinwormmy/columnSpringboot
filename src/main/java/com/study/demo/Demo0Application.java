package com.study.demo;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan(value={"com.study.demo.mapper"})
@SpringBootApplication
public class Demo0Application {

	public static void main(String[] args) {
		SpringApplication.run(Demo0Application.class, args);
	}

}

// https://azurealstn.tistory.com/83 여기서 디비 마이바티스 연동하던 중이었음