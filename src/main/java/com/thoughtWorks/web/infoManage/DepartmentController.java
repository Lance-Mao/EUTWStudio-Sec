package com.thoughtWorks.web.infoManage;

import com.thoughtWorks.dao.DepartmentDao;
import com.thoughtWorks.dto.Result;
import com.thoughtWorks.entity.Department;
import com.thoughtWorks.service.DepartmentService;
import com.thoughtWorks.util.Constant;
import com.thoughtWorks.util.PageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
@RequestMapping("/department")
public class DepartmentController {

    @Autowired
    private DepartmentService departmentService;

    @Resource
    private DepartmentDao departmentDao;

    @RequestMapping
    public String index() {
        return "infoManage/department/list";
    }

    @RequestMapping("list")
    @ResponseBody
    public Map<String, Object> list(PageUtil page) {
        Map<String, Object> data = new HashMap<>();
        try {
            List<Map<String, String>> departments = departmentService.queryDepartmentList(page);
            data.put("departments", departments);
            data.put("page", page);
            data.put("result", true);
            data.put("msg", Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            data.put("msg", Constant.SEARCH_FAILURE);
        }

        return data;
    }

    @RequestMapping("allDepartments")
    @ResponseBody
    public Result queryAllDepartments() {
        try {
            List<Department> departments = departmentDao.queryAllDepartments();

            return Result.success(departments, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.success(null, Constant.SEARCH_FAILURE);
    }

    /**
     * 添加时查找全部的专业和方向
     */
    @RequestMapping("professionAndDirectionData")
    @ResponseBody
    public Result getProfessionAndDirectionData() {
        try {
            Map<String, List<Map<String, String>>> data = departmentService.getProfessionAndDirectionData();

            return Result.success(data, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }

    /**
     * 当前系已有的专业、方向和全部的专业方向
     */
    @RequestMapping("fullProfessionAndDirectionData")
    @ResponseBody
    public Result getFullProfessionAndDirectionData(String id) {
        try {
            Map<String, List<Map<String, String>>> data = departmentService.getFullProfessionAndDirectionData(id);

            return Result.success(data, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }

    @RequestMapping("add")
    @ResponseBody
    public Result add(String code, String name, String professionsIds, String directionsIds) {
        try {
            departmentService.addDepartment(code, name, professionsIds, directionsIds);

            return Result.success(null, Constant.ADD_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.ADD_FAILURE);
    }

    @RequestMapping("update")
    @ResponseBody
    public Result add(Department department, String professionsIds, String directionsIds) {
        try {
            departmentService.updateDepartment(department, professionsIds, directionsIds);

            return Result.success(null, Constant.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.UPDATE_FAILURE);
    }

    @RequestMapping("delete")
    @ResponseBody
    public Result delete(String id) {
        try {
            departmentService.deleteDepartment(id);

            return Result.success(null, Constant.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.DELETE_FAILURE);
    }
}
