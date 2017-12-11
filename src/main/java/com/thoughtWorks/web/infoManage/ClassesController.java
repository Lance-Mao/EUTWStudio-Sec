package com.thoughtWorks.web.infoManage;

import com.thoughtWorks.dao.TrainModuleDao;
import com.thoughtWorks.dto.Result;
import com.thoughtWorks.dto.SearchDto;
import com.thoughtWorks.entity.Classes;
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
@RequestMapping("/classes")
public class ClassesController {
    @Resource
    private TrainModuleService trainModuleService;
    @Resource
    private TrainModuleDao trainModuleDao;

    @RequestMapping()
    public String index() {
        return "infoManage/classes/list";
    }

    @RequestMapping("list")
    @ResponseBody
    public Map<String, Object> list(PageUtil page) {
        Map<String, Object> data = new HashMap<>();
        try {
            List<Map<String,String>> classess = trainModuleService.queryClassesList(page);
            data.put("classess", classess);
            data.put("page", page);
            data.put("result", true);
            data.put("msg", Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            data.put("msg", Constant.SEARCH_FAILURE);
        }

        return data;
    }

    @RequestMapping("delete")
    @ResponseBody
    public Result delete(String id) {
        try {
            trainModuleDao.deleteClasses(id);

            return Result.success(null, Constant.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.DELETE_FAILURE);
    }

    @RequestMapping("update")
    @ResponseBody
    public Result update(Classes classes) {
        try {
            trainModuleDao.updateClasses(classes);

            return Result.success(null, Constant.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.UPDATE_FAILURE);
    }

    @RequestMapping("addManual")
    @ResponseBody
    public Result addManual(SearchDto searchDto) {
        try {
            trainModuleDao.addClassesManual(searchDto);

            return Result.success(null, Constant.ADD_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.ADD_FAILURE);
    }

}
