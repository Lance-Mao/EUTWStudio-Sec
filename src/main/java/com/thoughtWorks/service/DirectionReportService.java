package com.thoughtWorks.service;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;
import java.util.Map;

public interface DirectionReportService {

    List<Map<String,Object>> directionList()throws Exception;

    File exportReport(HttpServletRequest request)throws Exception;

}
