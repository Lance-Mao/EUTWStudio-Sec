package com.thoughtWorks.web.infoManage;

import com.thoughtWorks.dao.DepartmentDao;
import com.thoughtWorks.dao.TrainModuleDao;
import com.thoughtWorks.dto.Result;
import com.thoughtWorks.entity.*;
import com.thoughtWorks.service.PersonService;
import com.thoughtWorks.util.Constant;
import com.thoughtWorks.util.PageUtil;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.*;


@Component
@RequestMapping("/teacher")
public class TeacherController {

    @Resource
    private PersonService personService;
    @Resource
    private DepartmentDao departmentDao;
    @Resource
    private TrainModuleDao trainModuleDao;

    @RequestMapping()
    public String index() {
        return "infoManage/teacher/list";
    }

    @RequestMapping("list")
    @ResponseBody
    public Map<String, Object> list(PageUtil page) {
        Map<String, Object> data = new HashMap<>();
        try {
            List<Map<String, String>> teachers = personService.queryTeachersList(page);

            data.put("teachers", teachers);
            data.put("page", page);
            data.put("result", true);
            data.put("msg", Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            data.put("msg", Constant.SEARCH_FAILURE);
        }

        return data;
    }

    @RequestMapping("loadDepartmentsAndDirectionsAndClasses")
    @ResponseBody
    public Result loadDepartmentsAndDirectionsAndClasses() {
        try {
            Map<String, Object> result = new HashMap<>();
//            List<Department> departments = departmentDao.queryAllDepartments();
//            result.put("departments", departments);
//            if (departments.size() != 0) {
//                result.put("directions", departmentDao.queryDirectionsByDepartmentId(String.valueOf(departments.get(0).getId())));
//                查找系下班级时只查找最近三年的班级(当前年份-4 到 当前年份,大一到大四)
//                result.put("classess", trainModuleDao.queryClassessByDepartmentId(String.valueOf(departments.get(0).getId()), Calendar.getInstance().get(Calendar.YEAR) - 4, new Date().getYear()));
                result.put("classess", trainModuleDao.queryClassess(Calendar.getInstance().get(Calendar.YEAR) - 4, new Date().getYear()));
//            }

            return Result.success(result, Constant.OPERATION_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.OPERATION_FAILURE);
    }

    @RequestMapping("loadDirectionsAndClassesByDepartmentId")
    @ResponseBody
    public Result loadDirectionsAndClassesByDepartmentId(String departmentId) {
        try {
            Map<String, Object> result = new HashMap<>();
//            List<Department> departments = departmentDao.queryAllDepartments();
//            result.put("departments", departments);
//            result.put("directions", departmentDao.queryDirectionsByDepartmentId(departmentId));
            result.put("classess", trainModuleDao.queryClassess(Calendar.getInstance().get(Calendar.YEAR) - 4, new Date().getYear()));
            result.put("depts", departmentDao.queryDeptList());

            return Result.success(result, Constant.OPERATION_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.OPERATION_FAILURE);
    }


    @RequestMapping("add")
    @ResponseBody
    public Result add(Teacher teacher, String classIds,String floorIds,int areaId) {
        try {
            personService.addTeacher(teacher, classIds,floorIds,areaId);

            return Result.success(null, Constant.ADD_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.ADD_FAILURE);
    }

    @RequestMapping("update")
    @ResponseBody
    public Result update(Teacher teacher, String classIds,String floorIds,int areaId) {
        try {

            personService.updateTeacher(teacher, classIds,floorIds,areaId);

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
            personService.deleteTeacherById(id);

            return Result.success(null, Constant.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.DELETE_FAILURE);
    }

    @RequestMapping("queryDeptList")
    @ResponseBody
    public Result queryDeptList() {
        try {
            List<Dept> depts = departmentDao.queryDeptList();

            return Result.success(depts, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }

    @RequestMapping("queryUserById")
    @ResponseBody
    public Result queryUserById(String no) {
        Teacher teacher;
        try{
             teacher= personService.queryUserById(no);
            if(teacher != null)

            return Result.success(null, Constant.ACCOUNT_IS_EXIST);
        } catch (Exception e){
            e.printStackTrace();
        }

        return Result.failure(null ,Constant.SEARCH_FAILURE);
    }
 @RequestMapping("teacherCommunity")
    @ResponseBody
    public Result teacherCommunity(String no) {
        List<Map<String,Object>> teachers;
        List<Map<String,Object>> floors;
        try{
            Map<String, Object> result = new HashMap<>();
            teachers= personService.teacherCommunity(no);
            floors = personService.teacherCommunity_floors(no);
            result.put("area", teachers);
            result.put("floors", floors);
            return Result.success(result, Constant.SEARCH_SUCCESS);
        } catch (Exception e){
            e.printStackTrace();
        }

     return Result.failure(null, Constant.SEARCH_FAILURE);
    }

}
