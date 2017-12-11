package com.thoughtWorks.web.infoManage;

import com.thoughtWorks.dto.Result;
import com.thoughtWorks.service.TrainModuleService;
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
@RequestMapping("/testMethod")
public class TestMethodController {

    @Autowired
    private TrainModuleService trainModuleService;

    @RequestMapping
    public String index() {
        return "infoManage/testMethod/testMethod";
    }

    @RequestMapping("list")
    @ResponseBody
    public Result list(PageUtil pageUtil) {
        try {
            Map<String, Object> data = new HashMap<>();
            List<Map<String,Object>> testMethods = trainModuleService.queryAllTestMethod(pageUtil);
            data.put("testMethods", testMethods);
            data.put("pageUtil", pageUtil);

            return Result.success(data,Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();

            return Result.failure("null", Constant.SEARCH_FAILURE);
        }
    }

    @RequestMapping("add")
    @ResponseBody
    public Result add(String name) {
        try {
            trainModuleService.addTestMethod(name);

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

            trainModuleService.updateTestMethod(name,id);

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
            trainModuleService.deleteTestMethod(id);

            return Result.success("null",Constant.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure("null", Constant.OPERATION_FAILURE);
    }
}
