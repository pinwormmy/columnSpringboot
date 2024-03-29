package com.study.column.mapper;

import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;

@Mapper
public interface TimeMapper {
    @Select("select sysdate from dual")
    String getTime();
    //XML 방식
    String getTime2();
}
