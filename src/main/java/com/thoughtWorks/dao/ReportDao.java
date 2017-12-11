package com.thoughtWorks.dao;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface ReportDao {
    List<Map<String,String>> queryOldAndNewProfessionIds(String level);

    List<Map<String,String>> queryDepartments();

    List<Map<String,String>> queryProfessions();

    List<Map<String,Object>> queryDormPeopleNumber( List<Integer> levels);

}
