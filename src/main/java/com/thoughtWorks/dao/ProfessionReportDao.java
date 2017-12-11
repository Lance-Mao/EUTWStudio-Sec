package com.thoughtWorks.dao;

import java.util.List;
import java.util.Map;

public interface ProfessionReportDao {

    List<Map<String,Object>> queryProfessionReport(List<Integer> searchLevels);
}
