package com.thoughtWorks.web.task;

import com.thoughtWorks.util.insertDataUtil.TaskUtil;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;


@Component
public class Task {
    private TaskUtil taskUtil = new TaskUtil();

    @Scheduled(cron = "0 0 1 * * ?")
    public  void executeJob() {
        taskUtil.updateNewUser();
    }
}

