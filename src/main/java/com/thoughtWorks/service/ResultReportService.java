package com.thoughtWorks.service;

import com.thoughtWorks.dto.SearchDto;
import com.thoughtWorks.util.PageUtil;

import java.util.List;
import java.util.Map;

public interface ResultReportService {

    List<Map<String, String>> showResultReportList(SearchDto searchDto, PageUtil pageUtil) throws Exception;

    Map<String, String> queryStudentByNo(String no) throws Exception;

    List<Map<String,String>> queryStudentCourseResultByNo(String no) throws Exception;

    int queryTotalCredits(Map<String, String> student)throws Exception;
}
