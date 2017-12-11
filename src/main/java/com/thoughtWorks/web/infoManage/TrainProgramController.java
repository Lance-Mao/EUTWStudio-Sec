package com.thoughtWorks.web.infoManage;

import com.thoughtWorks.dto.Result;
import com.thoughtWorks.entity.Classes;
import com.thoughtWorks.entity.TrainModule;
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
@RequestMapping("/trainProgram")
public class TrainProgramController {

    @Resource
    private TrainModuleService trainModuleService;

    @RequestMapping()
    public String index() {
        return "infoManage/trainProgram/list";
    }

    @RequestMapping("list")
    @ResponseBody
    public Map<String, Object> list(PageUtil page) {
        Map<String, Object> data = new HashMap<>();
        try {
            List<Classes> trainPrograms = trainModuleService.queryTrainPrograms(page);
            data.put("trainPrograms", trainPrograms);
            data.put("page", page);
            data.put("result", true);
            data.put("msg", Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            data.put("msg", Constant.SEARCH_FAILURE);
        }

        return data;
    }

    @RequestMapping("loadDepartmentsAndDirectionsAndModuleCourses")
    @ResponseBody
    public Result loadDepartmentsAndDirectionsAndModuleCourses() {
        try {
            Map<String, Object> data = trainModuleService.loadDepartmentsAndDirectionsAndModuleCourses();

            return Result.success(data, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }

    @RequestMapping("add")
    @ResponseBody
    public Result add(TrainModule trainModule, String moduleCoursesStr) {
        try {
            trainModuleService.addTrainProgram(trainModule,moduleCoursesStr);

            return Result.success(null, Constant.ADD_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.ADD_FAILURE);
    }

    @RequestMapping("loadModuleCoursesByProgram")
    @ResponseBody
    public Result loadModuleCoursesByProgram(int id) {
        try {
            List<Map<String, String>> moduleCourses = trainModuleService.loadModuleCoursesByProgram(id);

            return Result.success(moduleCourses, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }

    @RequestMapping("update")
    @ResponseBody
    public Result update(int id, String moduleCoursesStr) {
        try {
            trainModuleService.updateProgramModuleCourses(id, moduleCoursesStr);

            return Result.success(null, Constant.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.UPDATE_FAILURE);
    }

    @RequestMapping("delete")
    @ResponseBody
    public Result delete(int id) {
        try {
            trainModuleService.deleteProgramById(id);

            return Result.success(null, Constant.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.DELETE_FAILURE);
    }
}
