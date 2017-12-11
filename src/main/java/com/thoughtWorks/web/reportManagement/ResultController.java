package com.thoughtWorks.web.reportManagement;

import com.thoughtWorks.dto.SearchDto;
import com.thoughtWorks.service.ResultService;
import com.thoughtWorks.util.Constant;
import com.thoughtWorks.util.PageUtil;
import org.apache.commons.io.FileUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import static com.thoughtWorks.util.FileUtil.getResponseEntity;

@Component
@RequestMapping("/result")
public class ResultController {

    @Resource
    private ResultService resultService;

    @RequestMapping("rank")
    public String rankIndex() {
        return "reportManagement/result/rankList";
    }

    @RequestMapping("search")
    public String searchIndex() {
        return "reportManagement/result/searchList";
    }

    @RequestMapping("searchList")
    @ResponseBody
    public Map<String, Object> searchList(SearchDto searchDto, PageUtil pageUtil) {
        Map<String, Object> data = new HashMap<>();
        try {
            List<Map<String, Object>> results = resultService.querySearchList(searchDto, pageUtil);
            data.put("results", results);
            data.put("page", pageUtil);
            data.put("result", true);
            data.put("msg", Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            data.put("result", false);
            data.put("msg", Constant.SEARCH_FAILURE);
        }
        return data;
    }

    @RequestMapping("rankList")
    @ResponseBody
    public Map<String, Object> rankList(SearchDto searchDto, PageUtil pageUtil) {
        Map<String, Object> data = new HashMap<>();
        try {
            List<Map<String, Object>> results = resultService.queryRankList(searchDto, pageUtil);
            data.put("results", results);
            data.put("page", pageUtil);
            data.put("result", true);
            data.put("msg", Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            data.put("result", false);
            data.put("msg", Constant.SEARCH_FAILURE);
        }
        return data;
    }

    @RequestMapping("exportRankReportExcel")
    public ResponseEntity<byte[]> exportProfessionReport(SearchDto searchDto, HttpServletRequest request) throws IOException {
        ResponseEntity<byte[]> responseEntity = null;
        searchDto.setDepartmentName(new String(searchDto.getDepartmentName().getBytes("iso8859-1"), "utf-8"));
        searchDto.setDirectionName(new String(searchDto.getDirectionName().getBytes("iso8859-1"), "utf-8"));
        searchDto.setLevel(new String(searchDto.getLevel().getBytes("iso8859-1"), "utf-8"));
        try {
            File file = resultService.exportRankReport(searchDto, request);
            responseEntity = getResponseEntity(file);
            file.delete();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return responseEntity;
    }

    @RequestMapping("exportSearchReportExcel")
    public ResponseEntity<byte[]> exportSearchReportExcel(SearchDto searchDto, HttpServletRequest request) throws IOException {
        ResponseEntity<byte[]> responseEntity = null;
//        searchDto.setCourseName(new String(searchDto.getCourseName().getBytes("iso8859-1"), "utf-8"));
        try {
            File file = resultService.exportSearchReport(searchDto, request);
            responseEntity = getResponseEntity(file);
            file.delete();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return responseEntity;
    }
}
