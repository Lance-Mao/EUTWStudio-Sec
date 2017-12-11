package com.thoughtWorks.service;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.Map;

public interface NewStudentRegisterService {

    File exportRegisterReport(String no, HttpServletRequest request)throws Exception;

    Map<String,Object> queryStudentByNo(String no)throws Exception;
}
