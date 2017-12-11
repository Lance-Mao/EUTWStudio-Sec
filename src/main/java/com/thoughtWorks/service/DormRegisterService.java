package com.thoughtWorks.service;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;
import java.util.Map;

public interface DormRegisterService {

    File exportDormRegisterReport(HttpServletRequest request)throws Exception;

    List<Map<String,Object>> queryDormPeopleNumber() throws  Exception;

}
