package com.thoughtWorks.dao;

import java.util.List;
import java.util.Map;

public interface StudentDataOutputDao {
    List<Map<String,Object>> queryStudentList(Map<String, Object> data);
}
