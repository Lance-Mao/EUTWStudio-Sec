package com.thoughtWorks.service.impl;

import com.thoughtWorks.dao.StudentInfoReportDao;
import com.thoughtWorks.entity.StudentInfoReportStatistic;
import com.thoughtWorks.service.StudentInfoReportService;
import com.thoughtWorks.util.reportUtil.NewStudentRegisterReportUtil;
import com.thoughtWorks.util.reportUtil.StudentInfoReportUtil;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.*;

import static com.thoughtWorks.util.DateUtil.getSearchLevels;

@Component
public class StudentInfoReportServiceImpl implements StudentInfoReportService {

    @Resource
    private StudentInfoReportDao studentInfoReportDao;

    @Override
    public File exportReport(HttpServletRequest request) throws Exception {
        String[] types = {"班级人数", "休学", "退学", "留级", "流失", "复学", "入伍", "欠费", "合作企业", "自主实习", "创新创业", "专升本", "其它", "在读"};

        Map<String, String> headers = new LinkedHashMap<>();
        headers.put("departmentName", "系别");
        headers.put("level", "年级");
        headers.put("directionName", "就业方向");
        headers.put("classesName", "班级名称");
        headers.put("teacherName", "职业导师");
        for (String type : types)
            headers.put(type, type);
        String fileName = "高职学院学籍管理班级人数统计报表.xls";

        String path = request.getServletContext().getRealPath("images/temp") + "/" + fileName;
        File file = new File(path);
        new StudentInfoReportUtil().exportExcel(headers, this.studentInfoList(), file, fileName.substring(0, fileName.lastIndexOf(".")));

        return file;
    }

    @Override
    public List<Map<String, Object>> studentInfoList() throws Exception {
        List<Map<String, Object>> students = studentInfoReportDao.studentInfoList(getSearchLevels());

        if (null == students || students.size() == 0) return new ArrayList<>();
            return statisticReport(students);
    }

    private List<Map<String, Object>> statisticReport(List<Map<String, Object>> students) {
        List<Map<String, Object>> studentInfoReport = new ArrayList<>();

        for (Map<String, Object> student : students) {
            if (student.get("departmentName") == null) continue;
            if (!isExistDepartment(studentInfoReport, student))
                createDepartmentName(studentInfoReport, student);

            statisticLevel(getStudentDepartment(studentInfoReport, student), student);
        }

        return studentInfoReport;
    }

    private Map<String, Object> getStudentDepartment(List<Map<String, Object>> studentInfoReport, Map<String, Object> student) {
        for (Map<String, Object> department : studentInfoReport) {
            if ((department.get("departmentName")).equals(student.get("departmentName")))
                return (Map<String, Object>) department;
        }

        return null;
    }


    private boolean isExistDepartment(List<Map<String, Object>> studentInfoReport, Map<String, Object> student) {
        for (Map<String, Object> studentInfo : studentInfoReport)
            if ((studentInfo.get("departmentName")).equals(student.get("departmentName"))) return true;

        return false;
    }

    private void createDepartmentName(List<Map<String, Object>> studentInfoReport, Map<String, Object> student) {
        Map<String, Object> department = new HashMap<>();
        department.put("departmentName", student.get("departmentName"));
        department.put("teacherName", student.get("teacherName"));
        department.put("levels", createDepartmentLevels());

        studentInfoReport.add(department);
    }

    private List<Map<String, Object>> createDepartmentLevels() {
        List<Map<String, Object>> departmentLevels = new ArrayList<>();
        List<Integer> levels = getSearchLevels();

        for (int level : levels) {
            Map<String, Object> temp = new HashMap<>();
            temp.put("level", level);
            temp.put("directions", new ArrayList<Map<String, Object>>());

            departmentLevels.add(temp);
        }

        return departmentLevels;
    }

    private void statisticLevel(Map<String, Object> department, Map<String, Object> student) {
        Map<String, Object> level = getStudentLevel(department, student);

        statisticDirections((List<Map<String, Object>>) level.get("directions"), student);
    }

    private Map<String, Object> getStudentLevel(Map<String, Object> department, Map<String, Object> student) {
        for (Map<String, Object> level : (List<Map<String, Object>>) department.get("levels"))
            if ((level.get("level")).equals(student.get("level"))) return level;

        return null;
    }

    private void statisticDirections(List<Map<String, Object>> directions, Map<String, Object> student) {
        if (student.get("directionName") == null) {
            student.put("directionName", "无");
        }
        if (!isExistDirection(directions, student))
            createDirection(directions, student);

        statisticClassess(getStudentClasses(directions, student), student);
    }


    private boolean isExistDirection(List<Map<String, Object>> directions, Map<String, Object> student) {
        for (Map<String, Object> direction : directions)
            if ((direction.get("directionName") + "").equals(student.get("directionName")))
                return true;

        return false;
    }

    private void createDirection(List<Map<String, Object>> directions, Map<String, Object> student) {
        Map<String, Object> direction = new HashMap<>();
        direction.put("directionName", student.get("directionName"));
        direction.put("classess", new ArrayList<>());

        directions.add(direction);
    }

    private List<Map<String, Object>> getStudentClasses(List<Map<String, Object>> directions, Map<String, Object> student) {
        for (Map<String, Object> direction : directions)
            if ((direction.get("directionName") + "").equals(student.get("directionName")))
                return (List<Map<String, Object>>) direction.get("classess");

        return null;
    }

    private void statisticClassess(List<Map<String, Object>> classess, Map<String, Object> student) {
        if (student.get("classesName") == null) {
            student.put("classesName", "无");
        }
        if (!isExistClasses(classess, student))
            createClassess(classess, student);

        statisticReportCount(getStudentReport(classess, student), student);
    }


    private boolean isExistClasses(List<Map<String, Object>> classess, Map<String, Object> student) {
        for (int i = 0; i < classess.size(); ++i) {
            Map<String, Object> classes = classess.get(i);
            if ((classes.get("classesName") + "").equals(student.get("classesName")))
                return true;
        }
        return false;
    }


    private void createClassess(List<Map<String, Object>> classess, Map<String, Object> student) {
        Map<String, Object> classes = new HashMap<>();
        classes.put("classesName", student.get("classesName"));
        classes.put("teacherName", student.get("teacherName"));
        classes.put("reportCount", new StudentInfoReportStatistic());

        classess.add(classes);
    }

    private StudentInfoReportStatistic getStudentReport(List<Map<String, Object>> classess, Map<String, Object> student) {
        for (Map<String, Object> classes : classess)
            if ((classes.get("classesName") + "").equals(student.get("classesName")))
                return (StudentInfoReportStatistic) classes.get("reportCount");

        return null;
    }

    private void statisticReportCount(StudentInfoReportStatistic studentReport, Map<String, Object> student) {
        if (studentReport == null) return;

        studentReport.statisticClassesCount();
        studentReport.statisticCount((String) student.get("student_status"));
        studentReport.statisticCount((String) student.get("practice_learning_type"));
        studentReport.statisticArrearsCount(student);
    }

}
