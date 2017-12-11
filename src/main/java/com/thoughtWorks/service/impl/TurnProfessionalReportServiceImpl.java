package com.thoughtWorks.service.impl;

import com.thoughtWorks.dao.StudentInfoReportDao;
import com.thoughtWorks.service.TurnProfessionalReportService;
import com.thoughtWorks.util.DateUtil;
import com.thoughtWorks.util.reportUtil.DormRegisterReportUtil;
import com.thoughtWorks.util.reportUtil.TurnProfessionalRegisterReportUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Created by 马欢欢 on 17-8-1.
 */
@Service
public class TurnProfessionalReportServiceImpl implements TurnProfessionalReportService {
    @Autowired
    private StudentInfoReportDao studentInfoReportDao;

    @Override
    public List<Map<String, Object>> queryTurnProfessional(String level)throws Exception {

        return studentInfoReportDao.queryTurnProfessional(level);
    }

    @Override
    public File exportTurnProfessionalRegisterReport(HttpServletRequest request,String level_) throws Exception {
        List<Map<String, Object>> dataset = queryTurnProfessional(level_);
        Map<String, String> headers = new HashMap<>();
        headers.put("index", "序号");
        headers.put("no", "考生号");
        headers.put("name",  "姓名");
        headers.put("arrangement",  "层次");
        headers.put("originProfession",  "录取专业");
        headers.put("originProfessionId",  "专业代码");
        headers.put("profession",  "现专业");
        headers.put("professionId",  "专业代码");
        String fileName =level_+"级学生转专业信息汇总表.xls";

        String path = request.getServletContext().getRealPath("images/temp") + "/" + fileName;
        File file = new File(path);
        new TurnProfessionalRegisterReportUtil().exportExcel(headers, dataset, file, fileName.substring(0, fileName.lastIndexOf(".")));

        return file;
    }


}
