package com.thoughtWorks.dto;

public class SearchDto {
    private String name;
    private String studentNo;

    private String level;
    private String classesId;
    private String departmentId;
    private String departmentName;
    private String professionId;
    private String directionId;
    private String directionName;
    private String sex;
    private String TypeOfAccommodation;     //住宿类型
    private String professionSearch;

    private String moduleId;
    private String semester;

    private String areaId;
    private String floorId;
    private String roomId;

    private String courseCode;
    private String courseName;
    private String lessThanScore;
    private String moreThanScore;

    private String teacherId;
    private String communityTeacherId;
    private String studentStatusSearch;

    public String getStudentStatusSearch() {
        return studentStatusSearch;
    }

    public void setStudentStatusSearch(String studentStatusSearch) {
        this.studentStatusSearch = studentStatusSearch;
    }

    public String getCommunityTeacherId() {
        return communityTeacherId;
    }

    public void setCommunityTeacherId(String communityTeacherId) {
        this.communityTeacherId = communityTeacherId;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public String getProfessionSearch() {
        return professionSearch;
    }

    public void setProfessionSearch(String professionSearch) {
        this.professionSearch = professionSearch;
    }

    public String getDepartmentName() {
        return departmentName;
    }

    public void setDepartmentName(String departmentName) {
        this.departmentName = departmentName;
    }

    public String getDirectionName() {
        return directionName;
    }

    public void setDirectionName(String directionName) {
        this.directionName = directionName;
    }

    public String getSex() {
        return sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    public String getTypeOfAccommodation() {
        return TypeOfAccommodation;
    }

    public void setTypeOfAccommodation(String typeOfAccommodation) {
        TypeOfAccommodation = typeOfAccommodation;
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

    public String getLessThanScore() {
        return lessThanScore;
    }

    public void setLessThanScore(String lessThanScore) {
        this.lessThanScore = lessThanScore;
    }

    public String getMoreThanScore() {
        return moreThanScore;
    }

    public void setMoreThanScore(String moreThanScore) {
        this.moreThanScore = moreThanScore;
    }

    public String getAreaId() {
        return areaId;
    }

    public void setAreaId(String areaId) {
        this.areaId = areaId;
    }

    public String getFloorId() {
        return floorId;
    }

    public void setFloorId(String floorId) {
        this.floorId = floorId;
    }

    public String getRoomId() {
        return roomId;
    }

    public void setRoomId(String roomId) {
        this.roomId = roomId;
    }

    public String getLevel() {
        return level;
    }

    public void setLevel(String level) {
        this.level = level;
    }

    public String getStudentNo() {
        return studentNo;
    }

    public void setStudentNo(String studentNo) {
        this.studentNo = studentNo;
    }

    public String getClassesId() {
        return classesId;
    }

    public void setClassesId(String classesId) {
        this.classesId = classesId;
    }

    public String getModuleId() {
        return moduleId;
    }

    public void setModuleId(String moduleId) {
        this.moduleId = moduleId;
    }

    public String getSemester() {
        return semester;
    }

    public void setSemester(String semester) {
        this.semester = semester;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(String departmentId) {
        this.departmentId = departmentId;
    }

    public String getProfessionId() {
        return professionId;
    }

    public void setProfessionId(String professionId) {
        this.professionId = professionId;
    }

    public String getDirectionId() {
        return directionId;
    }

    public void setDirectionId(String directionId) {
        this.directionId = directionId;
    }

    @Override
    public String toString() {
        return "SearchDto{" +
                "name='" + name + '\'' +
                ", studentNo='" + studentNo + '\'' +
                ", level='" + level + '\'' +
                ", classesId='" + classesId + '\'' +
                ", departmentId='" + departmentId + '\'' +
                ", professionId='" + professionId + '\'' +
                ", directionId='" + directionId + '\'' +
                ", sex='" + sex + '\'' +
                ", TypeOfAccommodation='" + TypeOfAccommodation + '\'' +
                ", moduleId='" + moduleId + '\'' +
                ", semester='" + semester + '\'' +
                ", areaId='" + areaId + '\'' +
                ", floorId='" + floorId + '\'' +
                ", roomId='" + roomId + '\'' +
                ", courseCode='" + courseCode + '\'' +
                ", courseName='" + courseName + '\'' +
                ", lessThanScore='" + lessThanScore + '\'' +
                ", moreThanScore='" + moreThanScore + '\'' +
                '}';
    }
}
