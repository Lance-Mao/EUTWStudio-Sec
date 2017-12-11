package com.thoughtWorks.web.reportManagement;

import com.thoughtWorks.dto.Result;
import com.thoughtWorks.service.DirectionReportService;
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
@RequestMapping("/directionReport")
public class DirectionReportController {
    @Resource
    private DirectionReportService directionReportService;

    @RequestMapping("")
    public String index() {
        return "reportManagement/direction";
    }

    @RequestMapping("list")
    @ResponseBody
    public Result list() {
        try {
            List<Map<String, Object>> data = directionReportService.directionList();

            return Result.success(data, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }

    @RequestMapping("exportExcel")
    public ResponseEntity<byte[]> exportReport(HttpServletRequest request) throws IOException {
        ResponseEntity<byte[]> responseEntity = null;

        try {
            File file = directionReportService.exportReport(request);
            responseEntity = getResponseEntity(file);
            file.delete();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return responseEntity;
    }
}
