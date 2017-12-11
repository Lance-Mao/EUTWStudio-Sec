package com.thoughtWorks.web.infoManage;

import com.thoughtWorks.dto.Result;
import com.thoughtWorks.entity.CourseModule;
import com.thoughtWorks.entity.Role;
import com.thoughtWorks.service.TrainModuleService;
import com.thoughtWorks.util.Constant;
import com.thoughtWorks.util.PageUtil;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
@RequestMapping("/courseModule")
public class CourseModuleController {

    @Resource
    private TrainModuleService trainModuleService;

    @RequestMapping()
    public String index() {
        return "infoManage/courseModule/list";
    }


    @RequestMapping("list")
    @ResponseBody
    public Map<String, Object> list(PageUtil page) {
        Map<String, Object> data = new HashMap<>();
        try {
            List<Map<String, String>> modules = trainModuleService.queryTrainModuleList(page);
            data.put("modules", modules);
            data.put("page", page);
            data.put("result", true);
            data.put("msg", Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            data.put("msg", Constant.SEARCH_FAILURE);
        }

        return data;
    }

    @RequestMapping("add")
    @ResponseBody
    public Result add(CourseModule courseModule) {
        try {
            trainModuleService.insertCourseModule(courseModule);

            return Result.success(null, Constant.ADD_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.ADD_FAILURE);
    }


    @RequestMapping("delete")
    @ResponseBody
    public Result delete(String id) {
        try {
            trainModuleService.deleteCourseModule(id);

            return Result.success(null, Constant.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.DELETE_FAILURE);
    }

    @RequestMapping("update")
    @ResponseBody
    public Result update(CourseModule courseModule) {
        try {
            trainModuleService.updateCourseModule(courseModule);

            return Result.success(null, Constant.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.UPDATE_FAILURE);
    }
}
