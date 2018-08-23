package com.thoughtWorks.service.impl;

import com.thoughtWorks.dao.TaskDao;
import com.thoughtWorks.entity.Result;
import com.thoughtWorks.entity.StudentByUpdata;
import com.thoughtWorks.entity.StudentFamily;
import com.thoughtWorks.service.TaskService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

/**
 * @program: EUTWStudio
 * @author: MaoLW
 * @create: 2018-08-22 17:04
 **/

@Service
public class TaskServiceImpl implements TaskService {
    @Autowired
    private TaskDao taskDao;

    @Override
    public void insertBatch(List<Result> resultList) {

        taskDao.insertBatch(resultList);
    }

    @Override
    public void deleteData() {
        taskDao.deleteData();
    }

    @Override
    public void insertBatchByStuFamily(List<StudentFamily> resultList) {
        taskDao.insertBatchByStuFamily(resultList);
    }

    @Override
    public void deleteDataByStuFamily() {
        taskDao.deleteDataByStuFamily();
    }

    @Override
    public void updateStuFamily() {
        taskDao.updateStuFamily();
    }

    @Override
    public void insertBatchByStudent(List<StudentByUpdata> resultList) {
        taskDao.insertBatchByStudent(resultList);
    }

    @Override
    public void updateStudent() {
        taskDao.updateStudent();
    }

    @Override
    public void deleteDataByStudent() {
        taskDao.deleteDataByStudent();
    }
}
