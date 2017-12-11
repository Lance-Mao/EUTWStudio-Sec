package com.thoughtWorks.web.infoManage;

import com.thoughtWorks.dto.Result;
import com.thoughtWorks.entity.Direction;
import com.thoughtWorks.service.DepartmentService;
import com.thoughtWorks.util.Constant;
import com.thoughtWorks.util.PageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
@RequestMapping("/direction")
public class DirectionController {

    @Autowired
    private DepartmentService departmentService;

    @RequestMapping()
    public String index() {
        return "infoManage/direction/list";
    }


    @RequestMapping("list")
    @ResponseBody
    public Map<String, Object> list(PageUtil page) {
        Map<String, Object> data = new HashMap<>();
        try {
            List<Map<String, String>> directions = departmentService.queryDirectionList(page);
            data.put("directions", directions);
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
    public Result add(Direction direction) {
        try {
            departmentService.insertDirection(direction);

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
            departmentService.deleteDirection(id);

            return Result.success(null, Constant.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.DELETE_FAILURE);
    }

    @RequestMapping("update")
    @ResponseBody
    public Result update(Direction direction) {
        try {
            departmentService.updateDirection(direction);

            return Result.success(null, Constant.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.UPDATE_FAILURE);
    }

    @RequestMapping("all")
    @ResponseBody
    public Result all() {
        try {
            PageUtil pageUtil = new PageUtil();
            pageUtil.setCurrentIndex(1);
            pageUtil.setPageSize(100000);
            List<Map<String, String>> directions = departmentService.queryDirectionList(pageUtil);

            return Result.success(directions, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }
}
