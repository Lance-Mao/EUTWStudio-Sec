package com.thoughtWorks.service;

import com.thoughtWorks.dto.SearchDto;
import com.thoughtWorks.util.PageUtil;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.List;
import java.util.Map;

public interface ResultService {


    List<Map<String,Object>> querySearchList(SearchDto searchDto, PageUtil pageUtil) throws Exception;

    List<Map<String, Object>>  queryRankList(SearchDto searchDto, PageUtil pageUtil)throws Exception;

    File exportRankReport(SearchDto searchDto, HttpServletRequest request)throws Exception;

    File exportSearchReport(SearchDto searchDto, HttpServletRequest request)throws Exception;
}
