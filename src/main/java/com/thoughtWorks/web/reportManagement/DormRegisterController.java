package com.thoughtWorks.web.reportManagement;

import com.thoughtWorks.dto.Result;
import com.thoughtWorks.service.DormRegisterService;
import com.thoughtWorks.service.ReportService;
import com.thoughtWorks.util.Constant;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.thoughtWorks.util.FileUtil.getResponseEntity;


@Component
@RequestMapping("/dormRegister")
public class DormRegisterController {
    @Autowired
    private DormRegisterService dormRegisterService;

    @RequestMapping()
    public String index(){
        return "reportManagement/dormRegister";
    }

    @RequestMapping("/dormList")
    @ResponseBody
    public Result DormList() throws Exception {
        try {
            List<Map<String, Object>> data =dormRegisterService.queryDormPeopleNumber();

            return Result.success(data, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }
    @RequestMapping("exportExcel")
    public ResponseEntity<byte[]> exportProfessionReport(HttpServletRequest request) throws IOException {
        ResponseEntity<byte[]> responseEntity = null;

        try {
            File file = dormRegisterService.exportDormRegisterReport(request);
            responseEntity = getResponseEntity(file);
            file.delete();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return responseEntity;
    }

}
