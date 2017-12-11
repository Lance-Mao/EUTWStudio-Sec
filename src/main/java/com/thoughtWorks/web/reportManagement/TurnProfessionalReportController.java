package com.thoughtWorks.web.reportManagement;

import com.thoughtWorks.dto.Result;
import com.thoughtWorks.service.TurnProfessionalReportService;
import com.thoughtWorks.util.Constant;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.List;
import java.util.Map;

import static com.thoughtWorks.util.FileUtil.getResponseEntity;

@Component
@RequestMapping("/turnProfessional")
public class TurnProfessionalReportController {
    @Resource
    private TurnProfessionalReportService turnProfessionalReportService;

    @RequestMapping("")
    public String index() {
        return "reportManagement/turnProfessional";
    }

    @RequestMapping("list")
    @ResponseBody
    public Result list(String level) {
        try {
            List<Map<String, Object>> data = turnProfessionalReportService.queryTurnProfessional(level);

            return Result.success(data, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }

    @RequestMapping("exportExcel")
    public ResponseEntity<byte[]> exportProfessionReport(HttpServletRequest request) throws IOException {
        String level = request.getParameter("level");
        ResponseEntity<byte[]> responseEntity = null;

        try {
            File file = turnProfessionalReportService.exportTurnProfessionalRegisterReport(request,level);
            responseEntity = getResponseEntity(file);
            file.delete();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return responseEntity;
    }
}
