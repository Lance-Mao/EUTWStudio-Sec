package com.thoughtWorks.web.infoManage;


import com.thoughtWorks.dto.Result;
import com.thoughtWorks.dto.SearchDto;
import com.thoughtWorks.entity.ActiveUser;
import com.thoughtWorks.entity.Classes;
import com.thoughtWorks.entity.CommunicationContent;
import com.thoughtWorks.entity.Student;
import com.thoughtWorks.service.DepartmentService;
import com.thoughtWorks.service.PersonService;
import com.thoughtWorks.util.Constant;
import com.thoughtWorks.web.UpdateStudentUtil;
import org.apache.shiro.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Component
@RequestMapping("/studentClass")
public class StudentClassController {
    @Autowired
    private PersonService personService;

    @Autowired
    private UpdateStudentUtil updateStudentUtil;
    @Autowired
    private DepartmentService departmentService;

    @RequestMapping()
    public String index() {
        return "infoManage/studentClass/list";
    }

    @RequestMapping("list")
    @ResponseBody
    public Result list(SearchDto searchDto) {
        try {
            Map<String, Object> students = null;
            ActiveUser user = (ActiveUser) SecurityUtils.getSubject().getPrincipal();
            if (user.getRoleId() == Constant.ADMIN_ROLE_ID) {
                students = personService.queryStudentsByLikesAdmin(searchDto);
            } else {
                students = personService.queryStudentsByLikes(user, searchDto);
            }

            return Result.success(students, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }

    @RequestMapping("student")
    @ResponseBody
    public Result student(String studentNo) {
        try {
            Student student = personService.queryStudentByNo(studentNo);

            return Result.success(student, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }
    @RequestMapping("queryClassesByDirectionId")
    @ResponseBody
    public Result queryClassesByDirectionId(String id) {
        try {
            List<Map<String,String>> classes = departmentService.queryClassesByDirectionId(id);

            return Result.success(classes, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }

    @RequestMapping("queryClassByDirectionIdAndLevel")
    @ResponseBody
    public Result queryClassByDirectionIdAndLevel(String directionId,String level) {
        try {
            List<Map<String, String>> classes = departmentService.queryClassByDirectionIdAndLevel(directionId,level);

            return Result.success(classes, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }
    @RequestMapping("loadTeacherHasClassess")
    @ResponseBody
    public Result loadTeacherHasClassess() {
        try {
            ActiveUser user = (ActiveUser) SecurityUtils.getSubject().getPrincipal();
            List<Classes> classes = personService.loadTeacherHasClassess(user.getUserName());

            return Result.success(classes, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }

    @RequestMapping("distributedClass")
    @ResponseBody
    public Result distributedClass(String classesId, String studentIds) {
        try {
            ActiveUser teacher = (ActiveUser) SecurityUtils.getSubject().getPrincipal();
            personService.distributedClass(classesId, studentIds);
            personService.updateStudentTeacherId(teacher.getUserName(), studentIds);
//            String[] studentList = studentIds.split(",");
//            for (int i = 0; i < studentList.length; i++) {
//                CommunicationContent content = new CommunicationContent(studentList[i], personService.queryStudentNameByStudentNo(studentList[i]), "班级信息");
//                updateStudentUtil.updateStudentToCommunication(content);
//            }

            return Result.success(null, Constant.ADD_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.ADD_FAILURE);
    }

    @RequestMapping("distributedDirection")
    @ResponseBody
    public Result distributedDirection(String directionId, String studentIds) {
        try {
            personService.distributedDirection(directionId, studentIds);
//            String[] studentList = studentIds.split(",");
//            for (int i = 0; i < studentList.length; i++) {
//                CommunicationContent content = new CommunicationContent(studentList[i], personService.queryStudentNameByStudentNo(studentList[i]), "方向信息");
//                updateStudentUtil.updateStudentToCommunication(content);
//            }

            return Result.success(null, Constant.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.UPDATE_FAILURE);
    }
}
