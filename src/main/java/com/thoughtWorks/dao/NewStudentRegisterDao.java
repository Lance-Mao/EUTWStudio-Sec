package com.thoughtWorks.dao;

import java.util.List;
import java.util.Map;

public interface NewStudentRegisterDao {

    Map<String,Object> queryRegisterBasicInfo(String no);


    List<Map<String, String>> queryStudentExperience(String no);

    List<Map<String, String>> queryStudentFamily(String no);

    List<String> queryStudentPunishmentByNo(String no);
}
