package com.thoughtWorks.dao;

import java.util.List;
import java.util.Map;

public interface CommunicationReportDao {

    List<Map<String,Object>> queryCommunications(List<Integer> searchLevels);
}
