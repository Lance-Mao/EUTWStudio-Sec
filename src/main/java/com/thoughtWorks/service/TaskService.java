package com.thoughtWorks.service;

import com.thoughtWorks.entity.Result;
import com.thoughtWorks.entity.StudentByUpdata;
import com.thoughtWorks.entity.StudentFamily;

import java.util.List;

/**
 * @program: EUTWStudio
 * @author: MaoLW
 * @create: 2018-08-22 17:03
 **/

public interface TaskService {
    void insertBatch(List<Result> resultList);

    void deleteData();

    void insertBatchByStuFamily(List<StudentFamily> resultList);

    void deleteDataByStuFamily();

    void updateStuFamily();

    void insertBatchByStudent(List<StudentByUpdata> resultList);

    void updateStudent();

    void deleteDataByStudent();

}
