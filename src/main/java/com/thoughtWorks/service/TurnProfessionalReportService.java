package com.thoughtWorks.service;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;
import java.util.Map;

/**
 * Created by 马欢欢 on 17-8-1.
 */
public interface TurnProfessionalReportService  {

    List<Map<String,Object>> queryTurnProfessional(String level)throws Exception;

    File exportTurnProfessionalRegisterReport(HttpServletRequest request ,String level)throws Exception;
}
