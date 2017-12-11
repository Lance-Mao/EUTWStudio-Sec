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
@RequestMapping("/learnPlan")
public class LearnPlanController {

    @Resource
    private TrainModuleService trainModuleService;

    @RequestMapping()
    public String index() {
        return "infoManage/learnPlan/list";
    }

    @RequestMapping("show")
    @ResponseBody
    public Result show(String studentNo) {
        Map<String, Object> result = new HashMap<>();
        try {
            Map<String, Object> program = trainModuleService.queryTrainProgramByNo(studentNo);
            List<Map<String, String>> moduleCourses = trainModuleService.loadModuleCoursesByProgram((Integer) program.get("id"));
            result.put("program", program);
            result.put("moduleCourses", moduleCourses);

            return Result.success(result, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }
}
