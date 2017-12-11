package com.thoughtWorks.web.reportManagement;

import com.thoughtWorks.dto.Result;
import com.thoughtWorks.service.NewStudentRegisterService;
import com.thoughtWorks.util.Constant;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Map;

import static com.thoughtWorks.util.FileUtil.getResponseEntity;

@Component
@RequestMapping("/newStudentRegister")
public class RegisterController {
    @Resource
    private NewStudentRegisterService newStudentRegisterService;


    @RequestMapping("")
    public String newStudentRegisterIndex() {
        return "reportManagement/register/list";
    }


    @RequestMapping("student")
    @ResponseBody
    public Result student(String no) {
        try {
            Map<String, Object> student = newStudentRegisterService.queryStudentByNo(no);

            return Result.success(student, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }

    @RequestMapping("exportRegisterReport")
    public ResponseEntity<byte[]> exportRegisterReport(String no,HttpServletRequest request) throws IOException {
        ResponseEntity<byte[]> responseEntity = null;

        try {
            File file = newStudentRegisterService.exportRegisterReport(no,request);
            responseEntity = getResponseEntity(file);
            file.delete();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return responseEntity;
    }
}
