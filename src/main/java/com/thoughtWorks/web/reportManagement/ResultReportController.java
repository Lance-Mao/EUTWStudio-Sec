package com.thoughtWorks.web.reportManagement;

import com.thoughtWorks.dto.SearchDto;
import com.thoughtWorks.service.ResultReportService;
import com.thoughtWorks.util.Constant;
import com.thoughtWorks.util.PageUtil;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
@RequestMapping("/resultReport")
public class ResultReportController {

    @Resource
    private ResultReportService resultReportService;

    @RequestMapping("")
    public String index() {
        return "reportManagement/resultReport/list";
    }

    @RequestMapping("list")
    @ResponseBody
    public Map<String,Object> list(SearchDto searchDto, PageUtil pageUtil) {
        Map<String, Object> data = new HashMap<>();
        try {
            List<Map<String, String>> students = resultReportService.showResultReportList(searchDto,pageUtil);
            data.put("students", students);
            data.put("page", pageUtil);
            data.put("result", true);
            data.put("msg", Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            data.put("result", false);
            data.put("msg", Constant.SEARCH_FAILURE);
        }

        return data;
    }

    @RequestMapping("preview")
    @ResponseBody
    public Map<String, Object> preview(String studentNo) {
        Map<String, Object> data = new HashMap<>();
        try {
            Map<String,String> student = resultReportService.queryStudentByNo(studentNo);
            List<Map<String,String>> results = resultReportService.queryStudentCourseResultByNo(studentNo);
            int result = resultReportService.queryTotalCredits(student);
            data.put("student", student);
            data.put("results", results);
            data.put("totalCredit", result);
            data.put("result", true);
            data.put("msg", Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            data.put("result", false);
            data.put("msg", Constant.SEARCH_FAILURE);
        }

        return data;
    }
}
