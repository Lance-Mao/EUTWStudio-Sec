package com.thoughtWorks.dao;

import java.util.List;
import java.util.Map;

public interface DirectionReportDao {

    List<Map<String,Object>> queryDirectionReport(List<Integer> searchLevels);
}
