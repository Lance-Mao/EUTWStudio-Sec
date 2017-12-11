package com.thoughtWorks.dao;

import java.util.List;
import java.util.Map;

public interface ResultDao {


    Long querySearchStudentsTotalCountLikes(Map<String, Object> data);

    List<Map<String,String>> querySearchStudentsLikes(Map<String, Object> data);

    Long queryRankStudentsTotalCountLikes(Map<String, Object> data);


    List<Map<String,String>> queryStudentLimit(Map<String, Object> data);

    List<Map<String,String>> queryStudentScores(List<Map<String, String>> students);

    List<Map<String,String>> queryRankList(Map<String, Object> data);
}
