package com.study.column;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@MapperScan(value={"com.study.column.mapper"})
@SpringBootApplication
public class ColumnsiteApplication {

	public static void main(String[] args) {
		SpringApplication.run(ColumnsiteApplication.class, args);
	}

}
