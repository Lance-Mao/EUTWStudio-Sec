package com.thoughtWorks.dao;

import java.util.List;
import java.util.Map;

public interface StudentInfoReportDao {
    List<Map<String,Object>> studentInfoList(List<Integer> searchLevels);

    List<Map<String,Object>> queryTurnProfessional(String level) throws Exception;


}
