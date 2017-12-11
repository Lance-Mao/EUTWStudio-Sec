package com.thoughtWorks.service.impl;

import com.thoughtWorks.dao.CommunicationReportDao;
import com.thoughtWorks.service.CommunicationReportService;
import com.thoughtWorks.util.DateUtil;
import com.thoughtWorks.util.reportUtil.CommunicationReportUtil;
import com.thoughtWorks.util.reportUtil.DirectionReportUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class CommunicationReportServiceImpl implements CommunicationReportService {

    @Resource
    private CommunicationReportDao communicationReportDao;

    @Override
    public File exportReport(HttpServletRequest request) throws Exception {
        List<Map<String, Object>> communicationList = communicationList();
        List<Integer> searchLevels = DateUtil.getSearchLevels();
        Map<String, String> headers = new HashMap<>();
        headers.put("teacher", "职业导师");
        headers.put("type", "沟通类型");
        headers.put("level1", Integer.toString(searchLevels.get(0)));
        headers.put("level2", Integer.toString(searchLevels.get(1)));
        headers.put("level3", Integer.toString(searchLevels.get(2)));
        headers.put("littleCount", "小计");
        String fileName = "高职学院沟通次数统计表.xls";

        String path = request.getServletContext().getRealPath("images/temp") + "/" + fileName;
        File file = new File(path);
        new CommunicationReportUtil().exportExcel(headers, communicationList, file, fileName.substring(0, fileName.lastIndexOf(".")));

        return file;
    }

    @Override
    public List<Map<String, Object>> communicationList() throws Exception {
        List<Map<String, Object>> statisticCount = new ArrayList<>();
        List<Map<String, Object>> communications = communicationReportDao.queryCommunications(DateUtil.getSearchLevels());

        if (communications.size() == 0) return statisticCount;

        for (Map<String, Object> communication : communications) {
            if (null == communication.get("teacher")) continue;
            if (!hasTeacher(communication, statisticCount)) {
                statisticCount.add(createTeacher(communication));
            }
            statisticTypeCount(statisticCount, communication);
        }

        return statisticCount;
    }

    private void statisticTypeCount(List<Map<String, Object>> statisticCount, Map<String, Object> communication) {
        for (Map<String, Object> tempCommunication : statisticCount) {
            if (tempCommunication.get("teacher").equals(communication.get("teacher")))
                if (!hasCommunicationType(tempCommunication.get("type"), communication))
                    createTeacherCommunicationType(tempCommunication, communication);

            addTeacherCommunicationTypeCount(tempCommunication.get("type"), communication);
        }
    }

    private void createTeacherCommunicationType(Map<String, Object> tempCommunication, Map<String, Object> communication) {
        List<Integer> levels = DateUtil.getSearchLevels();
        List<Map<String, Object>> types = (List<Map<String, Object>>) tempCommunication.get("type");
        if (types == null || types.size() == 0) {
            types = new ArrayList<>();
            Map<String, Object> type = createType(communication, levels);
            types.add(type);
        } else {
            boolean flag = true;
            for (Map<String, Object> tempType : types) {
                if (tempType.get("type").equals(communication.get("type"))) flag = false;
            }
            if (flag) {
                Map<String, Object> type = createType(communication, levels);
                types.add(type);
            }
        }

        tempCommunication.put("type", types);
    }

    private Map<String, Object> createType(Map<String, Object> communication, List<Integer> levels) {
        Map<String, Object> type = new HashMap<>();
        type.put("type", communication.get("type"));
        List<Map<String, Integer>> level = new ArrayList<>();
        for (int i = 0; i < 3; ++i) {
            Map<String, Integer> temp = new HashMap<>();
            temp.put("level", levels.get(i));
            temp.put("count", 0);
            level.add(temp);
        }
        type.put("levels", level);

        return type;
    }

    private void addTeacherCommunicationTypeCount(Object communicationType, Map<String, Object> communication) {
        List<Map<String, Object>> types = (List<Map<String, Object>>) communicationType;

        for (Map<String, Object> type : types) {
            if (type.get("type").equals(communication.get("type")))
                addTypeLevelCount(type, (int) communication.get("level"));
        }
    }

    private void addTypeLevelCount(Map<String, Object> type, int level) {
        List<Map<String, Integer>> levels = (List<Map<String, Integer>>) type.get("levels");
        for (Map<String, Integer> tempLevel : levels) {
            if (tempLevel.get("level").toString().equals(String.valueOf(level))) {
                int count = tempLevel.get("count");
                tempLevel.put("count", ++count);
            }

        }
    }

    private boolean hasCommunicationType(Object communicationType, Map<String, Object> communication) {
        List<Map<String, Object>> types = (List<Map<String, Object>>) communicationType;

        if (types == null || types.size() == 0) return false;

        for (Map<String, Object> type : types) {
            if (type.get("type").equals(communication.get("type"))) return true;
        }

        return false;
    }

    private Map<String, Object> createTeacher(Map<String, Object> communication) {
        Map<String, Object> teacher = new HashMap<>();
        teacher.put("teacher", communication.get("teacher"));
        teacher.put("type", new ArrayList<Map<String, Object>>());

        return teacher;
    }

    private boolean hasTeacher(Map<String, Object> communication, List<Map<String, Object>> statisticCount) {
        for (Map<String, Object> statistic : statisticCount) {
            if (communication.get("teacher").toString().equals(statistic.get("teacher") + ""))
                return true;
        }

        return false;
    }


}
