package com.thoughtWorks.service;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;
import java.util.Map;

public interface CommunicationReportService {

    List<Map<String,Object>> communicationList()throws Exception;

    File exportReport(HttpServletRequest request)throws Exception;

}
