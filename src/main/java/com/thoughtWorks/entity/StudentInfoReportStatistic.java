package com.thoughtWorks.entity;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class StudentInfoReportStatistic implements Serializable {
    private String[] types = {"班级人数", "合作企业", "自主实习", "创新创业", "专升本", "其它", "在读", "休学", "入伍","留级", "退学", "流失", "复学", "欠费"};
    private Map<String, Integer> statisticCount;

    public StudentInfoReportStatistic() {
        statisticCount = new HashMap<>();
        for (String type : types)
            statisticCount.put(type, 0);
    }

    public void statisticCount(String type) {
        for (String key : statisticCount.keySet()) {
            if (key.equals(type)) {
                int count = (int) statisticCount.get(key);
                statisticCount.put(key, ++count);
                break;
            }
        }
    }

    public void statisticClassesCount() {
        int count = (int) statisticCount.get("班级人数");
        statisticCount.put("班级人数", ++count);
    }

    public void statisticArrearsCount(Map<String, Object> student) {
        if ("欠费".equals(student.get("firstPayStatus")) || "欠费".equals(student.get("secondPayStatus")) || "欠费".equals(student.get("thirdPayStatus"))) {
            int count = (int) statisticCount.get("欠费");
            statisticCount.put("欠费", ++count);
        }

    }

    public Map<String, Integer> getStatisticCount() {
        return statisticCount;
    }

    public void setStatisticCount(Map<String, Integer> statisticCount) {
        this.statisticCount = statisticCount;
    }
}
