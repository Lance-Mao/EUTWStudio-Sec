package com.thoughtWorks.service;

import com.thoughtWorks.entity.Department;
import com.thoughtWorks.entity.Direction;
import com.thoughtWorks.entity.Profession;
import com.thoughtWorks.util.PageUtil;

import java.util.List;
import java.util.Map;

public interface DepartmentService {
    List<Map<String,String>> queryDirectionList(PageUtil page)throws Exception;

    void insertDirection(Direction direction)throws Exception;

    void updateDirection(Direction direction)throws Exception;

    void deleteDirection(String id)throws Exception;

    List<Map<String,String>> queryProfessionList(PageUtil page)throws Exception;

    void insertProfession(Profession profession)throws Exception;

    void updateProfession(Profession profession)throws Exception;

    void deleteProfession(String id)throws Exception;

    List<Map<String,String>> queryDepartmentList(PageUtil page) throws Exception;

    Map<String, List<Map<String, String>>> getProfessionAndDirectionData()throws Exception;

    void addDepartment(String code, String name, String professionsIds, String directionsIds)throws Exception;

    Map<String,List<Map<String,String>>> getFullProfessionAndDirectionData(String id)throws Exception;

    void updateDepartment(Department department, String professionsIds, String directionsIds)throws Exception;

    void deleteDepartment(String id)throws Exception;

    List<Map<String,String>> queryClassesByDirectionId(String id)throws Exception;

    List<Map<String,String>> queryClassByDirectionIdAndLevel(String directionId, String level)throws Exception;
}
