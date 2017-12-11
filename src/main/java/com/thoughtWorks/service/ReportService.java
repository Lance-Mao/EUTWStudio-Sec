package com.thoughtWorks.service;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;
import java.util.Map;

public interface ReportService {

    List<Map<String,Object>> professionList(String level)throws Exception;

    File exportProfessionReport(String level,HttpServletRequest request)throws Exception;
}
