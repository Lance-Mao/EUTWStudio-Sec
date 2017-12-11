package com.thoughtWorks.service.impl;

import com.thoughtWorks.dao.ReportDao;
import com.thoughtWorks.service.ReportService;
import com.thoughtWorks.util.DateUtil;
import com.thoughtWorks.util.excelUtil.ExcelReportUtil;
import com.thoughtWorks.util.reportUtil.NewStudentRegisterReportUtil;
import com.thoughtWorks.util.reportUtil.ProfessionReportUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.*;

@Service
public class ReportServiceImpl implements ReportService {

    @Resource
    private ReportDao reportDao;


    @Override
    public File exportProfessionReport(String level, HttpServletRequest request) throws Exception {
        Map<String, String> headers = new HashMap<>();
        headers.put("index", "序号");
        headers.put("departmentName", "系名");
        headers.put("name", "原录取专业");
        headers.put("oldNumber", "人数");
        headers.put("turnIn", "转入");
        headers.put("turnOut", "转出");
        headers.put("name1", "现专业");
        headers.put("nowNumber", "人数");
        headers.put("remark", "备注");

        List<Map<String, Object>> dataSet = professionList(level);
        String fileName = "高职学院专业人数统计表" + (level == null ? "" : level) + ".xls";
        String path = request.getServletContext().getRealPath("images/temp") + "/" + fileName;
        File file = new File(path);
        new ProfessionReportUtil().exportExcel(headers, dataSet, file, fileName.substring(0, fileName.lastIndexOf(".")));

        return file;
    }



    @Override
    public List<Map<String, Object>> professionList(String level) throws Exception {
        String like = null == level || "".equals(level) ? "%%" : "%" + level + "%";
        List<Map<String, String>> ids = reportDao.queryOldAndNewProfessionIds(like);
        List<Map<String, String>> departmentList = reportDao.queryDepartments();
        List<Map<String, String>> professionList = reportDao.queryProfessions();

        countProfessionStudent(ids, professionList);

        List<Map<String, Object>> departmentChildProfession = bindDepartmentsAndProfessions(departmentList, professionList);

        return departmentChildProfession;
    }

    private List<Map<String, Object>> bindDepartmentsAndProfessions(List<Map<String, String>> departmentList, List<Map<String, String>> professionList) {
        List<Map<String, Object>> departmentChildProfession = new ArrayList<>();
        for (Map<String, String> department : departmentList) {
            Map<String, Object> temp = new HashMap<>();
            temp.put("name", department.get("name"));
            temp.put("children", new ArrayList<Map<String, String>>());

            for (Map<String, String> profession : professionList) {
                if (profession.get("department_id").equals(String.valueOf(department.get("id"))))
                    ((List<Map<String, String>>) temp.get("children")).add(profession);
            }

            departmentChildProfession.add(temp);
        }
        return departmentChildProfession;
    }

    private void countProfessionStudent(List<Map<String, String>> ids, List<Map<String, String>> professionList) {
        for (Map<String, String> id : ids) {
            for (Map<String, String> profession : professionList) {
                switch (getStudentState(profession, id)) {
                    case "NO_CHANGE":
                        addOne(profession, "oldNumber");
                        addOne(profession, "nowNumber");
                        break;
                    case "TURN_IN":
                        addOne(profession, "turnIn");
                        addOne(profession, "nowNumber");
                        break;
                    case "TURN_OUT":
                        addOne(profession, "turnOut");
                        addOne(profession, "oldNumber");
                        subOne(profession, "nowNumber");
                        break;
                }
            }
        }
    }

    private String getStudentState(Map<String, String> profession, Map<String, String> ids) {
        String professionId = String.valueOf(profession.get("id"));
        if (ids.get("oldId").equals(professionId) && !ids.get("nowId").equals(professionId))
            return "TURN_OUT";
        if (!ids.get("oldId").equals(professionId) && ids.get("nowId").equals(professionId))
            return "TURN_IN";
        if (ids.get("oldId").equals(professionId) && ids.get("nowId").equals(professionId))
            return "NO_CHANGE";

        return "";
    }

    private void addOne(Map<String, String> data, String param) {
        if (data.get(param) == null) {
            data.put(param, "1");
        } else {
            int oldNumber = Integer.parseInt(data.get(param)) + 1;
            data.put(param, String.valueOf(oldNumber));
        }
    }

    private void subOne(Map<String, String> data, String param) {
        if (data.get(param) == null) {
            data.put(param, "1");
        } else {
            int oldNumber = Integer.parseInt(data.get(param)) - 1;
            data.put(param, String.valueOf(oldNumber));
        }
    }
}
