package com.thoughtWorks.dto;

public class DataSearchDto {
    private String pageSize;
    private String departmentId;
    private String dataLevel;
    private String directionId;
    private String professionId;
    private String classesId;
    private String teacherId;
    private String communityTeacherId;
    private String areaId;
    private String floorId;
    private String roomId;
    private String studentNo;
    private String dataName;
    private String sex;
    private String TypeOfAccommodation;
    private String studentStatusSearch;

    @Override
    public String toString() {
        return "DataSearchDto{" +
                "pageSize='" + pageSize + '\'' +
                ", departmentId='" + departmentId + '\'' +
                ", dataLevel='" + dataLevel + '\'' +
                ", directionId='" + directionId + '\'' +
                ", professionId='" + professionId + '\'' +
                ", classesId='" + classesId + '\'' +
                ", teacherId='" + teacherId + '\'' +
                ", communityTeacherId='" + communityTeacherId + '\'' +
                ", areaId='" + areaId + '\'' +
                ", floorId='" + floorId + '\'' +
                ", roomId='" + roomId + '\'' +
                ", studentNo='" + studentNo + '\'' +
                ", dataName='" + dataName + '\'' +
                ", sex='" + sex + '\'' +
                ", TypeOfAccommodation='" + TypeOfAccommodation + '\'' +
                ", studentStatusSearch='" + studentStatusSearch + '\'' +
                '}';
    }

    public String getPageSize() {
        return pageSize;
    }

    public void setPageSize(String pageSize) {
        this.pageSize = pageSize;
    }

    public String getDepartmentId() {
        return departmentId;
    }

    public void setDepartmentId(String departmentId) {
        this.departmentId = departmentId;
    }

    public String getDataLevel() {
        return dataLevel;
    }

    public void setDataLevel(String dataLevel) {
        this.dataLevel = dataLevel;
    }

    public String getDirectionId() {
        return directionId;
    }

    public void setDirectionId(String directionId) {
        this.directionId = directionId;
    }

    public String getProfessionId() {
        return professionId;
    }

    public void setProfessionId(String professionId) {
        this.professionId = professionId;
    }

    public String getClassesId() {
        return classesId;
    }

    public void setClassesId(String classesId) {
        this.classesId = classesId;
    }

    public String getTeacherId() {
        return teacherId;
    }

    public void setTeacherId(String teacherId) {
        this.teacherId = teacherId;
    }

    public String getCommunityTeacherId() {
        return communityTeacherId;
    }

    public void setCommunityTeacherId(String communityTeacherId) {
        this.communityTeacherId = communityTeacherId;
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

    public String getStudentNo() {
        return studentNo;
    }

    public void setStudentNo(String studentNo) {
        this.studentNo = studentNo;
    }

    public String getDataName() {
        return dataName;
    }

    public void setDataName(String dataName) {
        this.dataName = dataName;
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

    public String getStudentStatusSearch() {
        return studentStatusSearch;
    }

    public void setStudentStatusSearch(String studentStatusSearch) {
        this.studentStatusSearch = studentStatusSearch;
    }
}
