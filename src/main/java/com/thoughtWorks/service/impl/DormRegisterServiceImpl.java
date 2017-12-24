package com.thoughtWorks.service.impl;

import com.thoughtWorks.dao.ReportDao;
import com.thoughtWorks.service.DormRegisterService;
import com.thoughtWorks.service.ReportService;
import com.thoughtWorks.util.DateUtil;
import com.thoughtWorks.util.reportUtil.DormRegisterReportUtil;
import com.thoughtWorks.util.reportUtil.ProfessionReportUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.*;

@Service
public class DormRegisterServiceImpl implements DormRegisterService {

    @Resource
    private ReportDao reportDao;


    @Override
    public File exportDormRegisterReport(HttpServletRequest request) throws Exception {
        List<Map<String, Object>> dormRegisterList = dormRegisterList();
        List<Integer> searchLevels = DateUtil.getSearchLevels();
        Map<String, String> headers = new HashMap<>();
        headers.put("index", "序号");
        headers.put("departmentName", "系");
        headers.put("stayTypeName",  "住宿类型");
        headers.put("level1",  Integer.toString(searchLevels.get(0)));
        headers.put("level2",  Integer.toString(searchLevels.get(1)));
        headers.put("level3",  Integer.toString(searchLevels.get(2)));
        headers.put("littleCount",  "小计");
        String fileName = "高职学院宿舍人数统计表.xls";

        String path = request.getServletContext().getRealPath("images/temp") + "/" + fileName;
        File file = new File(path);
        new DormRegisterReportUtil().exportExcel(headers, dormRegisterList, file, fileName.substring(0, fileName.lastIndexOf(".")));

        return file;
    }


    public List<Map<String, Object>> dormRegisterList() throws Exception {
        List<Map<String, Object>> statisticStudents = null;
        List<Integer> searchLevels = DateUtil.getSearchLevels();

        List<Map<String, Object>> students = reportDao.queryDormPeopleNumber(searchLevels);
        if (students.size() != 0) statisticStudents = statisticStudentsCount(students);

        return statisticStudents;
    }

    public List<Map<String, Object>> queryDormPeopleNumber() throws Exception {
        List<Map<String, Object>> statisticStudents = null;
        List<Integer> searchLevels = DateUtil.getSearchLevels();

        List<Map<String, Object>> students = reportDao.queryDormPeopleNumber(searchLevels);
        if (students.size() != 0) statisticStudents = statisticStudentsCount(students);

        return statisticStudents;
    }

    private List<Map<String, Object>> statisticStudentsCount(List<Map<String, Object>> students) {
        String departmentName = null;
        Map<String, Object> temp = null;
        List<Map<String, Object>> statisticStudents = new ArrayList<>();

        for (Map<String, Object> student : students) {
            if(student.get("departmentName") == null) continue;
            if (departmentName == null || !departmentName.equals(student.get("departmentName"))) {
                departmentName = (String) student.get("departmentName");
                temp = new LinkedHashMap<>();
                temp.put("departmentName", departmentName);
                temp.put("stayType", new ArrayList<>());
                statisticStudents.add(temp);
            }
            setDepartmentProfessionStudentCount(temp, student);
        }

        return statisticStudents;
    }

    private void setDepartmentProfessionStudentCount(Map<String, Object> tempDepartment, Map<String, Object> student) {
        String stayTypeName = (String) student.get("stayTypeName");
        if (stayTypeName == null) {
            stayTypeName = "1";
        }
        List<Map<String, Object>> stayType = (List<Map<String, Object>>) tempDepartment.get("stayType");

        if (stayType.size() == 0)
            stayType.add(createStayType(stayTypeName));

        boolean flag = false;
        for (Map<String, Object> stayTypeAll : stayType) {
            if (stayTypeAll.get("stayTypeName").toString().equals(stayTypeName)) {
                flag = true;
                setLevelCount(stayTypeAll, student);
            }
        }
        if (!flag) {
            stayType.add(createStayType(stayTypeName));
            setLevelCount(stayType.get(stayType.size() - 1), student);
        }
    }

    private void setLevelCount(Map<String, Object> profession, Map<String, Object> student) {
        List<Integer> searchLevels = DateUtil.getSearchLevels();
        List<Map<String, Integer>> levels = (List<Map<String, Integer>>) profession.get("levels");
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

    private Map<String, Object> createStayType(String stayTypeName) {
        Map<String, Object> tempProfession = new HashMap<>();
        tempProfession.put("stayTypeName", stayTypeName);
        tempProfession.put("levels", new ArrayList<>());

        return tempProfession;
    }


}
