package com.thoughtWorks.web.infoManage;

import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;

@Component
@RequestMapping("/personResult")
public class PersonResultController {

    @RequestMapping("")
    public String index() {
        return "infoManage/personResult/list";
    }

}
