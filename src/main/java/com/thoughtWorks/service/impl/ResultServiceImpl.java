package com.thoughtWorks.service.impl;

import com.thoughtWorks.dao.ResultDao;
import com.thoughtWorks.dto.SearchDto;
import com.thoughtWorks.service.ResultService;
import com.thoughtWorks.util.PageUtil;
import com.thoughtWorks.util.reportUtil.ResultReportUtil;
import com.thoughtWorks.util.reportUtil.SearchReportUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileNotFoundException;
import java.util.*;

@Service
public class ResultServiceImpl implements ResultService {

    @Resource
    private ResultDao resultDao;

    @Override
    public File exportSearchReport(SearchDto searchDto, HttpServletRequest request) throws Exception {
        PageUtil pageUtil = new PageUtil();
        pageUtil.setCurrentIndex(1);
        pageUtil.setPageSize(9999999);

        Map<String, String> headers = getSearchReportHeaders();
        List<Map<String, Object>> dataSet = querySearchList(searchDto, pageUtil);
        StringBuffer fileName = new StringBuffer("高职学院成绩查询报表(")
                .append("分数:")
                .append(searchDto.getLessThanScore()).append(" - ")
                .append(searchDto.getMoreThanScore())
                .append(").xls");
        File file = getReportFile(request, headers, dataSet, fileName.toString());
        new SearchReportUtil().exportExcel(headers, dataSet, file, fileName.substring(0, fileName.lastIndexOf(".")));
        return file;
    }

    private Map<String, String> getSearchReportHeaders() {
        Map<String, String> headers = new HashMap<>();
        headers.put("department", "系");
        headers.put("level", "年级");
        headers.put("direction", "就业方向");
        headers.put("classesName", "班级");
        headers.put("no", "学号");
        headers.put("name", "姓名");
        headers.put("courseCode", "课程代码");
        headers.put("courseName", "课程名称");
        headers.put("score", "分数");
        return headers;
    }

    @Override
    public File exportRankReport(SearchDto searchDto, HttpServletRequest request) throws Exception {
        PageUtil pageUtil = new PageUtil();
        pageUtil.setCurrentIndex(1);
        pageUtil.setPageSize(9999999);

        Map<String, String> headers = getRankReportHeaders();
        List<Map<String, Object>> dataSet = queryRankList(searchDto, pageUtil);
        StringBuffer fileName = new StringBuffer("高职学院成绩排行报表(")
                .append(searchDto.getDepartmentName())
                .append(searchDto.getLevel()).append("级")
                .append(searchDto.getDirectionName())
                .append(").xls");
        File file = getReportFile(request, headers, dataSet, fileName.toString());
        new ResultReportUtil().exportExcel(headers, dataSet, file, fileName.substring(0, fileName.lastIndexOf(".")));
        return file;
    }

    private File getReportFile(HttpServletRequest request, Map<String, String> headers, List<Map<String, Object>> dataSet, String fileName) throws FileNotFoundException {
        String path = request.getServletContext().getRealPath("images/temp") + "/" + fileName;
        File file = new File(path);
        return file;
    }

    private Map<String, String> getRankReportHeaders() {
        Map<String, String> headers = new HashMap<>();
        headers.put("department", "系");
        headers.put("level", "年级");
        headers.put("direction", "就业方向");
        headers.put("no", "学号");
        headers.put("name", "姓名");
        headers.put("score", "分数");
        return headers;
    }

    @Override
    public List<Map<String, Object>> querySearchList(SearchDto searchDto, PageUtil pageUtil) throws Exception {
        Map<String, Object> data = new HashMap<>();
        data.put("courseCode", searchDto.getCourseCode());
        data.put("courseName", "%" + searchDto.getCourseName() + "%");
        data.put("level", searchDto.getLevel());
        data.put("lessThanScore", Integer.parseInt("".equals(searchDto.getLessThanScore()) ? "0" : searchDto.getLessThanScore()));
        data.put("moreThanScore", Integer.parseInt("".equals(searchDto.getMoreThanScore()) ? "100" : searchDto.getMoreThanScore()));
        data.put("start", (pageUtil.getCurrentIndex() - 1) * pageUtil.getPageSize());
        data.put("pageSize", pageUtil.getPageSize());
        pageUtil.setTotalSize(resultDao.querySearchStudentsTotalCountLikes(data));
        List<Map<String, String>> searchStudents = resultDao.querySearchStudentsLikes(data);

        return toSearchValueObjectMap(searchStudents);
    }

    private List<Map<String, Object>> toSearchValueObjectMap(List<Map<String, String>> searchStudents) {
        Map<String, Object> temp;
        List<Map<String, Object>> scoreObject = new ArrayList<>();
        for (Map<String, String> data : searchStudents) {
            try {
                data.put("score", String.valueOf(Double.valueOf(data.get("score"))));
            } catch (Exception e) {
                data.put("score", "0");
            }
            temp = new HashMap<>();
            Set<String> keys = data.keySet();
            for (String key : keys)
                temp.put(key, data.get(key));
            scoreObject.add(temp);
        }

        return scoreObject;
    }

    @Override
    public List<Map<String, Object>> queryRankList(SearchDto searchDto, PageUtil pageUtil) throws Exception {
        List<Map<String, String>> studentsTotalScores = new ArrayList<>(), studentsAverageScores;
        Map<String, Object> data = new HashMap<>();
        data.put("departmentId", searchDto.getDepartmentId());
        data.put("level", searchDto.getLevel());
        data.put("directionId", searchDto.getDirectionId());
        data.put("start", (pageUtil.getCurrentIndex() - 1) * pageUtil.getPageSize());
        data.put("pageSize", pageUtil.getPageSize());
        pageUtil.setTotalSize(resultDao.queryRankStudentsTotalCountLikes(data));

        List<Map<String, String>> students = resultDao.queryStudentLimit(data);
        if (students.size() == 0) return null;
        List<Map<String, String>> studentsScores = resultDao.queryRankList(data);
//        List<Map<String, String>> studentsScores = resultDao.queryStudentScores(students);
//        if (studentsScores.size() != 0) studentsTotalScores = getStudentsTotalScore(studentsScores, students);
//        studentsAverageScores = getStudentsAverageScore(studentsTotalScores);
//        sortStudentScoreDesc(studentsAverageScores);
//        int endIndex = (Integer) data.get("pageSize") + (Integer) data.get("start");
//        if (endIndex > studentsAverageScores.size()) endIndex = studentsAverageScores.size();
//        studentsAverageScores = studentsAverageScores.subList((Integer) data.get("start"), endIndex);

        return toValueObjectMap(studentsScores);
    }

    private List<Map<String, Object>> toValueObjectMap(List<Map<String, String>> studentsScores) {
        Map<String, Object> temp;
        List<Map<String, Object>> scoreRankObject = new ArrayList<>();
        for (Map<String, String> data : studentsScores) {
            data.put("score", String.valueOf(getCourseScore(data)));
            temp = new HashMap<>();
            Set<String> keys = data.keySet();
            for (String key : keys)
                temp.put(key, data.get(key));
            scoreRankObject.add(temp);
        }

        return scoreRankObject;
    }

    private String getSearchCourseScore(Map<String, String> studentsScore) {
        try {
            Double score = Double.valueOf(studentsScore.get("score"));
            double i = (int) (score * 100) / 100;
            return i + "";
        } catch (Exception e) {//当分数为 A、B..  时 抛出异常直接返回0
            e.printStackTrace();
            return "0";
        }
    }

    private void sortStudentScoreDesc(List<Map<String, String>> studentsAverageScores) {
        for (int i = 0; i < studentsAverageScores.size() - 1; ++i)
            for (int j = i + 1; j < studentsAverageScores.size(); ++j) {
                double preScore = Double.valueOf(studentsAverageScores.get(i).get("score"));
                double currScore = Double.valueOf(studentsAverageScores.get(j).get("score"));
                if (currScore > preScore) {
                    Map<String, String> temp = studentsAverageScores.get(i);
                    studentsAverageScores.set(i, studentsAverageScores.get(j));
                    studentsAverageScores.set(j, temp);
                }
            }
    }

    private List<Map<String, String>> getStudentsAverageScore(List<Map<String, String>> studentsTotalScores) {
        for (Map<String, String> student : studentsTotalScores) {
            if (student.get("score") == null) {
                student.put("score", "0");
            } else {
                double averageScore = Double.valueOf(student.get("score")) / Integer.parseInt(student.get("courseNumber"));
                student.put("score", String.format("%.2f", averageScore));
            }
        }

        return studentsTotalScores;
    }


    private List<Map<String, String>> getStudentsTotalScore(List<Map<String, String>> studentsScores, List<Map<String, String>> students) {
        for (Map<String, String> studentScore : studentsScores)
            for (Map<String, String> student : students)
                setStudentTotalScore(student, studentScore);

        return students;
    }

    private void setStudentTotalScore(Map<String, String> student, Map<String, String> studentScore) {
        double courseScore = getCourseScore(studentScore);

        if (student.get("no").equals(studentScore.get("no"))) {
            if (student.get("score") == null) {
                student.put("courseNumber", "1");
                student.put("score", String.valueOf(courseScore));
            } else {
                student.put("score", String.valueOf(Double.valueOf(student.get("score")) + courseScore));
                if (courseScore != 0)
                    student.put("courseNumber", String.valueOf(Integer.parseInt(student.get("courseNumber")) + 1));
                else
                    student.put("courseNumber", String.valueOf(Integer.parseInt(student.get("courseNumber")) - 1));
            }
        }
    }

    private double getCourseScore(Map<String, String> studentsScore) {
        try {
            return Double.valueOf(String.format("%.2f", studentsScore.get("score")));
        } catch (Exception e) {//当分数为 A、B..  时 抛出异常直接返回0
            return 0;
        }
    }

}
