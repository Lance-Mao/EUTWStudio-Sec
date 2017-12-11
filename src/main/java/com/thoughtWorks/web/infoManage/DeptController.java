package com.thoughtWorks.web.infoManage;

import com.thoughtWorks.dto.Result;
import com.thoughtWorks.service.PersonService;
import com.thoughtWorks.util.Constant;
import com.thoughtWorks.util.PageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/dept")
public class DeptController {


    @Autowired
    private PersonService personService;

    @RequestMapping()
    public String index() {
        return "infoManage/dept/dept";
    }

    @RequestMapping("list")
    @ResponseBody
    public Result list(PageUtil pageUtil) {
        try {
            Map<String, Object> data = new HashMap<>();
            List<Map<String,Object>> depts = personService.queryAllDept(pageUtil);
            data.put("depts", depts);
            data.put("pageUtil", pageUtil);

            return Result.success(data, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();

            return Result.failure("null", Constant.SEARCH_FAILURE);
        }
    }

    @RequestMapping("add")
    @ResponseBody
    public Result add(String name) {
        try {
            personService.addDept(name);

            return Result.success("null",Constant.ADD_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure("null", Constant.ADD_FAILURE);
    }

    @RequestMapping("update")
    @ResponseBody
    public Result update(String name,String id) {
        try {

            personService.updateDept(name,id);

            return Result.success("null",Constant.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure("null", Constant.UPDATE_FAILURE);
    }

    @RequestMapping("delete")
    @ResponseBody
    public Result delete(String id) {
        try {
            personService.deleteDept(id);

            return Result.success("null",Constant.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure("null", Constant.OPERATION_FAILURE);
    }
}
