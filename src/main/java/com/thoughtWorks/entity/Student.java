package com.thoughtWorks.entity;

public class Student {
    private String no;
    private String name;
    private String departmentId;
    private String directionId;
    private String classesId;
    private String gender;
    private String parentName;
    private String zyFile;

    public String getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(String departmentId) {
        this.departmentId = departmentId;
    }

    public String getDirectionId() {
        return directionId;
    }

    public void setDirectionId(String directionId) {
        this.directionId = directionId;
    }

    public String getClassesId() {
        return classesId;
    }

    public void setClassesId(String classesId) {
        this.classesId = classesId;
    }

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

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getParentName() {
        return parentName;
    }

    public void setParentName(String parentName) {
        this.parentName = parentName;
    }

    public String getZyFile() {
        return zyFile;
    }

    public void setZyFile(String zyFile) {
        this.zyFile = zyFile;
    }

    @Override
    public String toString() {
        return "Student{" +
                "no='" + no + '\'' +
                ", name='" + name + '\'' +
                ", departmentId='" + departmentId + '\'' +
                ", directionId='" + directionId + '\'' +
                ", classesId='" + classesId + '\'' +
                ", gender='" + gender + '\'' +
                ", parentName='" + parentName + '\'' +
                ", zyFile='" + zyFile + '\'' +
                '}';
    }
}
