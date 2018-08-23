package com.thoughtWorks.web.task;

import com.thoughtWorks.util.insertDataUtil.TaskUtil;
import com.thoughtWorks.web.TimedTask;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;


@Component
public class Task {
    private TaskUtil taskUtil = new TaskUtil();
    @Autowired
    private TimedTask timedTask;

    @Scheduled(cron = "0 0 1 * * ?")
    public  void executeJob() {
        taskUtil.updateNewUser();
    }

    @Scheduled(cron = "0 0 1 ? * SAT")
    public void executeResultData() {
        timedTask.updateGrade();
    }

    @Scheduled(cron = "0 0 1 ? * SUN")
    public void executeStuFamilyData() {
        timedTask.updateStudentFamily();
    }

    @Scheduled(cron = "0 0 3 ? * SUN")
    public void executeStudentData() {
        timedTask.updateStudent();
    }
}

