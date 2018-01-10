package com.thoughtWorks.web.infoManage;


import com.thoughtWorks.dto.Result;
import com.thoughtWorks.dto.SearchDto;
import com.thoughtWorks.entity.ActiveUser;
import com.thoughtWorks.entity.Classes;
import com.thoughtWorks.entity.CommunicationContent;
import com.thoughtWorks.entity.Direction;
import com.thoughtWorks.service.PersonService;
import com.thoughtWorks.util.Constant;
import com.thoughtWorks.util.PageUtil;
import org.apache.shiro.SecurityUtils;
import org.springframework.stereotype.Component;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
@RequestMapping("/communication")
public class CommunicationController {

    @Resource
    private PersonService personService;

    @RequestMapping()
    public String index() {
        return "infoManage/communication/list";
    }

    @RequestMapping("list")
    @ResponseBody
    public Map<String, Object> list(SearchDto searchDto, PageUtil page) {
        Map<String, Object> data = new HashMap<>();

        try {
            List<Map<String, String>> allProfessionList = personService.queryAllStudentsProfessionList();
            List<Map<String, String>> student = personService.queryStudentsByTeacherHasClasses(searchDto, page);

            data.put("student", student);
            data.put("allProfessionList", allProfessionList);
            data.put("result", true);
            data.put("page", page);
            data.put("msg", Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            data.put("msg", Constant.SEARCH_FAILURE);
        }

        return data;
    }

    @RequestMapping("add")
    @ResponseBody
    public Result add(CommunicationContent communicationContent) {
        try {
            ActiveUser user = (ActiveUser) SecurityUtils.getSubject().getPrincipal();
            communicationContent.setTeacherId(user.getUserName());
            personService.addCommunication(communicationContent);

            return Result.success(null, Constant.ADD_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.ADD_FAILURE);
    }

    @RequestMapping("communication")
    @ResponseBody
    public Result communication(String studentNo) {
        try {
            List<Map<String, Object>> communication = personService.queryCommunicationByStudentId(studentNo);
            List<Map<String,Object>> student =personService.queryStudentInfoById(studentNo);
            communication.addAll(student);
            return Result.success(communication, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }


        return Result.failure(null, Constant.SEARCH_FAILURE);
    }

    @RequestMapping("updateContent")
    @ResponseBody
    public Result updateContent(CommunicationContent communicationContent) {
        try {
            personService.updateCommunicationContent(communicationContent);

            return Result.success(null, Constant.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.UPDATE_FAILURE);
    }

    @RequestMapping("queryDirectionByDepartmentId")
    @ResponseBody
    public Result queryDirectionByDepartmentId(int departmentId) {
        try {
            List<Direction> list = personService.queryDirectionByDepartmentId(departmentId);
            return Result.success(list, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Result.failure(null, Constant.SEARCH_FAILURE);
    }

    @RequestMapping("queryDirectionByDepartment")
    @ResponseBody
    public Result queryDirectionByDepartment() {
        try {
            List<Direction> list = personService.queryDirectionByDepartment();

            return Result.success(list, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }

    @RequestMapping("queryClass")
    @ResponseBody
    public Result queryClass() {
        try {
            List<Classes> list = personService.queryClass();

            return Result.success(list, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }

    @RequestMapping("queryClassByDepartmentId")
    @ResponseBody
    public Result queryClassByDepartmentId(int departmentId) {
        try {
            List<Classes> list = personService.queryClassByDepartmentId(departmentId);

            return Result.success(list, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }

    @RequestMapping("UploadAction")
    @ResponseBody
    public Result UploadAction(HttpServletRequest request) {
        try {

            System.out.println("文件长度："+123);
            return Result.success(null, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }


}
