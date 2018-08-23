package com.thoughtWorks.dao;

import com.thoughtWorks.entity.Result;
import com.thoughtWorks.entity.StudentByUpdata;
import com.thoughtWorks.entity.StudentFamily;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface TaskDao {
    void insertBatch(@Param("resultList") List<Result> resultList);

    void deleteData();

    void insertBatchByStuFamily(@Param("resultList") List<StudentFamily> resultList);

    void deleteDataByStuFamily();

    void updateStuFamily();

    void deleteDataByStudent();

    void updateStudent();

    void insertBatchByStudent(@Param("resultList") List<StudentByUpdata> resultList);
}
