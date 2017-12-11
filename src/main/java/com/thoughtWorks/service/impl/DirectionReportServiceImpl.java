package com.thoughtWorks.service.impl;

import com.thoughtWorks.dao.DirectionReportDao;
import com.thoughtWorks.service.DirectionReportService;
import com.thoughtWorks.util.DateUtil;
import com.thoughtWorks.util.reportUtil.DirectionReportUtil;
import com.thoughtWorks.util.reportUtil.ProfessionReportUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.*;

@Service
public class DirectionReportServiceImpl implements DirectionReportService {

    @Resource
    private DirectionReportDao directionReportDao;

    @Override
    public File exportReport(HttpServletRequest request) throws Exception {
        List<Map<String, Object>> directionList = this.directionList();
        List<Integer> searchLevels = DateUtil.getSearchLevels();
        Map<String, String> headers = new HashMap<>();
        headers.put("departmentName", "系");
        headers.put("directionName", "就业方向");
        headers.put("level1", Integer.toString(searchLevels.get(0)));
        headers.put("level2", Integer.toString(searchLevels.get(1)));
        headers.put("level3", Integer.toString(searchLevels.get(2)));
        headers.put("littleCount", "小计");
        String fileName = "高职学院就业方向人数统计表.xls";

        String path = request.getServletContext().getRealPath("images/temp") + "/" + fileName;
        File file = new File(path);
        new DirectionReportUtil().exportExcel(headers, directionList, file, fileName.substring(0, fileName.lastIndexOf(".")));

        return file;
    }

    @Override
    public List<Map<String, Object>> directionList() throws Exception {
        List<Map<String, Object>> statisticStudents = null;
        List<Integer> searchLevels = DateUtil.getSearchLevels();

        List<Map<String, Object>> students = directionReportDao.queryDirectionReport(searchLevels);
        if (students.size() != 0) statisticStudents = statisticStudentsCount(students);

        return statisticStudents;
    }

    private List<Map<String, Object>> statisticStudentsCount(List<Map<String, Object>> students) {
        String departmentName = null;
        Map<String, Object> temp = null;
        List<Map<String, Object>> statisticStudents = new ArrayList<>();

        for (Map<String, Object> student : students) {
            if (student.get("departmentName") == null) continue;

            if (departmentName == null || !departmentName.equals(student.get("departmentName"))) {
                departmentName = (String) student.get("departmentName");
                temp = new LinkedHashMap<>();
                temp.put("departmentName", departmentName);
                temp.put("directions", new ArrayList<>());
                statisticStudents.add(temp);
            }
            setDepartmentProfessionStudentCount(temp, student);
        }

        return statisticStudents;
    }

    private void setDepartmentProfessionStudentCount(Map<String, Object> tempDepartment, Map<String, Object> student) {
        String directionName = (String) student.get("directionName");
        if (directionName == null) {
            student.put("directionName", "无");
            directionName = "无";
        }
        List<Map<String, Object>> directions = (List<Map<String, Object>>) tempDepartment.get("directions");

        if (directions.size() == 0)
            directions.add(createDirection(directionName));

        boolean flag = false;
        for (Map<String, Object> direction : directions) {
            if (direction.get("directionName").toString().equals(directionName)) {
                flag = true;
                setLevelCount(direction, student);
            }
        }
        if (!flag) {
            directions.add(createDirection(directionName));
            setLevelCount(directions.get(directions.size() - 1), student);
        }
    }

    private void setLevelCount(Map<String, Object> direction, Map<String, Object> student) {
        List<Integer> searchLevels = DateUtil.getSearchLevels();
        List<Map<String, Integer>> levels = (List<Map<String, Integer>>) direction.get("levels");
        if (levels.size() == 0) {
            for (int i = 0; i < searchLevels.size(); ++i) {
                Map<String, Integer> temp = new HashMap<>();
                temp.put("level", searchLevels.get(i));
                temp.put("count", 0);
                levels.add(temp);
            }
        }
        for (Map<String, Integer> level : levels) {
            if (level.get("level").intValue() == (int) student.get("level")) {
                int count = level.get("count");
                level.put("count", count + 1);
            }
        }
    }

    private Map<String, Object> createDirection(String directionName) {
        Map<String, Object> tempDirection = new HashMap<>();
        tempDirection.put("directionName", directionName);
        tempDirection.put("levels", new ArrayList<>());

        return tempDirection;
    }


}
