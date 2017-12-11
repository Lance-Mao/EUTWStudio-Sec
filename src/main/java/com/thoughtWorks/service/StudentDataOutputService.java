package com.thoughtWorks.service;

import com.thoughtWorks.dto.DataSearchDto;
import com.thoughtWorks.entity.StudentUpdate;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;
import java.util.Map;

public interface StudentDataOutputService {
    List<Map<String, Object>> queryStudentList(DataSearchDto searchDto)throws Exception;

    File newStudentDataOutput(HttpServletRequest request, List<Map<String, Object>> exportedData, StudentUpdate studentUpdate);
}
