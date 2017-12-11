package com.thoughtWorks.service.impl;

import com.thoughtWorks.dao.NewStudentRegisterDao;
import com.thoughtWorks.service.NewStudentRegisterService;
import com.thoughtWorks.util.reportUtil.NewStudentRegisterReportUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class NewStudentRegisterServiceImpl implements NewStudentRegisterService {

    @Resource
    private NewStudentRegisterDao newStudentRegisterDao;


    @Override
    public Map<String, Object> queryStudentByNo(String no) throws Exception {
        Map<String, Object> studentInfo = new HashMap<>();
        Map<String, Object> basicStudentInfo = newStudentRegisterDao.queryRegisterBasicInfo(no);
        List<Map<String, String>> experience = newStudentRegisterDao.queryStudentExperience(no);
        List<Map<String, String>> family = newStudentRegisterDao.queryStudentFamily(no);

        List<String> punishments = newStudentRegisterDao.queryStudentPunishmentByNo(no);
        basicStudentInfo.put("own_punishment", punishments.size() == 0 ? "" : punishments.get(0));

        studentInfo.put("basicStudentInfo", basicStudentInfo);
        studentInfo.put("experience", experience);
        studentInfo.put("family", family);

        return studentInfo;
    }

    @Override
    public File exportRegisterReport(String no, HttpServletRequest request) throws Exception {
        Map<String, Object> studentInfo = queryStudentByNo(no);
        Map<String, Object> basicStudent = (Map<String, Object>) studentInfo.get("basicStudentInfo");
        basicStudent.put("head_image", request.getServletContext().getRealPath("images/user") + "/" + basicStudent.get("head_image") + "");
        Map<String, String> headers = new HashMap<>();
        headers.put("fenyuan", "高职学院");
        headers.put("professionName", basicStudent.get("professionName") + "");
        headers.put("classesName", basicStudent.get("classesName") + "");
        headers.put("no", basicStudent.get("no") + "");
        headers.put("in_school", basicStudent.get("in_school") + "");
        String fileName = "高职学院学生入学登记表(" + headers.get("no") + ").xls";

        List<Map<String, Object>> dataSet = new ArrayList<>();
        dataSet.add(studentInfo);
        String path = request.getServletContext().getRealPath("images/temp") + "/" + fileName;
        File file = new File(path);
        new NewStudentRegisterReportUtil().exportExcel(headers, dataSet, file, fileName.substring(0, fileName.lastIndexOf(".")));

        return file;
    }

}
