package com.thoughtWorks.entity;

import java.util.Date;

/**
 * @program: EUTWStudio
 * @author: MaoLW
 * @create: 2018-08-22 16:00
 **/

public class Result {
    private String no;
    private String name;
    private Integer level;
    private String courseCode;
    private String courseName;
    private String score;
    private Date testEntityTime;
    private Integer isPass;
    private Double credit;
    private Integer nature;
    private String method;

    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getLevel() {
        return level;
    }

    public void setLevel(Integer level) {
        this.level = level;
    }

    public String getCourseCode() {
        return courseCode;
    }

    public void setCourseCode(String courseCode) {
        this.courseCode = courseCode;
    }

    public String getCourseName() {
        return courseName;
    }

    public void setCourseName(String courseName) {
        this.courseName = courseName;
    }

    public String getScore() {
        return score;
    }

    public void setScore(String score) {
        this.score = score;
    }

    public Date getTestEntityTime() {
        return testEntityTime;
    }

    public void setTestEntityTime(Date testEntityTime) {
        this.testEntityTime = testEntityTime;
    }

    public Integer getIsPass() {
        return isPass;
    }

    public void setIsPass(Integer isPass) {
        this.isPass = isPass;
    }

    public Double getCredit() {
        return credit;
    }

    public void setCredit(Double credit) {
        this.credit = credit;
    }

    public Integer getNature() {
        return nature;
    }

    public void setNature(Integer nature) {
        this.nature = nature;
    }

    public String getMethod() {
        return method;
    }

    public void setMethod(String method) {
        this.method = method;
    }
}
