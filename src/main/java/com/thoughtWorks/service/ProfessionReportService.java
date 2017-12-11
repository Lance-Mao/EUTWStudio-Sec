package com.thoughtWorks.service;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;
import java.util.Map;

public interface ProfessionReportService {

    List<Map<String,Object>> professionList()throws Exception;

    File exportProfessionReport( HttpServletRequest request)throws Exception;


}
