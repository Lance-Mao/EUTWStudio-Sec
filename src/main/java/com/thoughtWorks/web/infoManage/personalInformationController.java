package com.thoughtWorks.web.infoManage;

import com.thoughtWorks.service.PersonService;
import com.thoughtWorks.util.Constant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;


@Component
@RequestMapping("/personalInformation")
public class personalInformationController {
    @Autowired
    private PersonService personService;

    @RequestMapping("")
    public String index() {
        return "infoManage/personalInformation/list";
    }

    @RequestMapping("/update")
    @ResponseBody
    public Map<String, Object> update(String studentNo) {
        Map<String, Object> data = new HashMap<>();
        try {
            data.putAll(personService.updateByStudentNo(studentNo));
            data.put("msg", Constant.SEARCH_SUCCESS);
            data.put("result", true);
        } catch (Exception e) {
            new RuntimeException(e);
            data.put("msg", Constant.SEARCH_FAILURE);
            data.put("result", false);
        }
        return data;
    }
}
