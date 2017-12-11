package com.thoughtWorks.web;

import com.thoughtWorks.entity.ActiveUser;
import com.thoughtWorks.entity.CommunicationContent;
import com.thoughtWorks.service.PersonService;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

@Component
public class UpdateStudentUtil {

    @Autowired
    private PersonService personService;

    public void updateStudentToCommunication(CommunicationContent communicationContent) {
        ActiveUser user;
        try {
            user = (ActiveUser) SecurityUtils.getSubject().getPrincipal();
            communicationContent.setTeacherId(user.getUserName());
            communicationContent.setStudentId(communicationContent.getStudentId());
            communicationContent.setTalkName(communicationContent.getTalkName());
            communicationContent.setDirection("信息修改");
            String contents = "修改信息" + "$%$" + communicationContent.getTeacherId() + "修改了" + communicationContent.getTalkName() + "的" + communicationContent.getContent();
            communicationContent.setContent(contents);

            personService.addCommunication(communicationContent);
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
}
