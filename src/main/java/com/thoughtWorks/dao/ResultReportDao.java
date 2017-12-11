package com.thoughtWorks.dao;

import java.util.List;
import java.util.Map;

public interface ResultReportDao {

    List<Map<String,String>> queryStudentsLikes(Map<String, Object> data);

    Long queryStudentsLikesTotalCount(Map<String, Object> data);

    Map<String,String> queryStudentByNo(String no);

    List<Map<String,String>> queryStudentCourseResultByNo(String no);

    List<Integer> queryTotalCredits(Map<String, String> student);
}
