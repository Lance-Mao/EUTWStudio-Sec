package com.thoughtWorks.web.infoManage;

import com.thoughtWorks.dao.DepartmentDao;
import com.thoughtWorks.dto.Result;
import com.thoughtWorks.entity.Profession;
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
@RequestMapping("/profession")
public class ProfessionController {
    @Autowired
    private DepartmentService departmentService;
    @Autowired
    private DepartmentDao departmentDao;

    @RequestMapping()
    public String index() {
        return "infoManage/profession/list";
    }

    @RequestMapping("list")
    @ResponseBody
    public Map<String, Object> list(PageUtil page) {
        Map<String, Object> data = new HashMap<>();
        try {
            List<Map<String, String>> professions = departmentService.queryProfessionList(page);
            data.put("professions", professions);
            data.put("page", page);
            data.put("result", true);
            data.put("msg", Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            data.put("msg", Constant.SEARCH_FAILURE);
        }

        return data;
    }
    @RequestMapping("all")
    @ResponseBody
    public Map<String, Object> list() {
        Map<String, Object> data = new HashMap<>();
        try {
            List<Profession> professions = departmentDao.queryAllProfession();
            data.put("data", professions);
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
    public Result add(Profession profession) {
        try {
            departmentService.insertProfession(profession);

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
            departmentService.deleteProfession(id);

            return Result.success(null, Constant.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.DELETE_FAILURE);
    }

    @RequestMapping("update")
    @ResponseBody
    public Result update(Profession profession) {
        try {
            departmentService.updateProfession(profession);

            return Result.success(null, Constant.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.UPDATE_FAILURE);
    }
}
