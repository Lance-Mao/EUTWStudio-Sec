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
        List<Map<String, Object>> communications = communicationReportDao.queryCommunications(DateUtil.getSearchLevels()); //数据1

        if (communications.size() == 0) return statisticCount;

        for (Map<String, Object> communication : communications) {//循环2159次   童乐46次沟通  沟通年级全部为2017级
            if (null == communication.get("teacher")) continue;  //2159次循环中老师姓名没有出现空值
            if (!hasTeacher(communication, statisticCount)) {    //hasTeacher()该函数作用，如果在statisticCount这个新数组中发现相同老师的名字，则返回true
                statisticCount.add(createTeacher(communication));//为新数组添加[{"teacher":""},{"type":[{},{}...]}...]  因此statisticCount集合的长度为老师的个数。长度为21
            }  //statisticCount集合目前的形式为[{"teacher":""},{"type":[{},{}...]}...]  type属性现在还未添加值
            statisticTypeCount(statisticCount, communication);
        }

//        System.out.println(statisticCount);  //数据2

        return statisticCount;
    }

    private void statisticTypeCount(List<Map<String, Object>> statisticCount, Map<String, Object> communication) {
        for (Map<String, Object> tempCommunication : statisticCount) {   //循环21次 * 上面循环2159次
            if (tempCommunication.get("teacher").equals(communication.get("teacher")))  //找出相同老师的一项
                if (!hasCommunicationType(tempCommunication.get("type"), communication)) //communication还是从数据库查出来的值，未变化，数据1。判断tempCommunication.get("type")集合中是否有相同的沟通类型
                    createTeacherCommunicationType(tempCommunication, communication);  //该函数返回的结果值为：

//            System.out.println("tempCommunication-type:"+tempCommunication.get("type"));

            //tempCommunication = {"teacher":""},{"type":[{"type":"沟通类型名称","level":[{"level":2015,"count":0},{"level":2016,"count":0},{"level":2017,"count":0}]...]}
            //tempCommunication.get("type") 为[{"type":"沟通类型名称","level":[{"level":2015,"count":0},{"level":2016,"count":0},{"level":2017,"count":0}]...]
            addTeacherCommunicationTypeCount(tempCommunication.get("type"), (String) tempCommunication.get("teacher"), communication);
        }
    }

    private void createTeacherCommunicationType(Map<String, Object> tempCommunication, Map<String, Object> communication) {
        List<Integer> levels = DateUtil.getSearchLevels();
        List<Map<String, Object>> types = (List<Map<String, Object>>) tempCommunication.get("type");  //types = [{},{}...]
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

        //types = [{"type":"沟通类型名称","level":[{"level":2015,"count":0},{"level":2016,"count":0},{"level":2017,"count":0}]...]
        tempCommunication.put("type", types);  //tempCommunication = {"teacher":""},{"type":[{"type":"沟通类型名称","level":[{"level":2015,"count":0},{"level":2016,"count":0},{"level":2017,"count":0}]...]}
    }

    //该函数循环3*2159次
    private Map<String, Object> createType(Map<String, Object> communication, List<Integer> levels) {  //communication集合为改变‘.，levels = [2015,2016,2017]
        Map<String, Object> type = new HashMap<>();
        type.put("type", communication.get("type"));  //{"type":"沟通类型名称","type":"沟通类型名称"...}
        List<Map<String, Integer>> level = new ArrayList<>();
        for (int i = 0; i < 3; ++i) {  //该方法for循环循环次数 21 * 3 * 2159  目前为止循环正常。//为其中的一种沟通类型添加三个年级属性，并把沟通次数初始值设置为零
            Map<String, Integer> temp = new HashMap<>();
            temp.put("level", levels.get(i));
            temp.put("count", 0);
            level.add(temp);
        }//level = [{"level":2015,"count":0},{"level":2015,"count":0},{"level":2015,"count":0}]   三次循环level的结果
        type.put("levels", level); //type的结果{"type":"沟通类型名称","level":[{"level":2016,"count":0},{"level":2017,"count":0},{"level":2015,"count":0}],"type":"沟通类型名称"...}

        return type;
    }

    private void addTeacherCommunicationTypeCount(Object communicationType,String teacher, Map<String, Object> communication) {
        List<Map<String, Object>> types = (List<Map<String, Object>>) communicationType;

//        System.out.println("types=" + types);
        //types = tempCommunication.get("type") 为[{"type":"沟通类型名称","level":[{"level":2015,"count":0},{"level":2016,"count":0},{"level":2017,"count":0}]...]

        for (Map<String, Object> type : types) {
            if (type.get("type").equals(communication.get("type")) && teacher.equals(communication.get("teacher")))
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
