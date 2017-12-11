package com.thoughtWorks.entity;

/**
 * Created by 马欢欢 on 17-7-25.
 */
public class TeacherCommunity {
    private int id ;
    private String no;
    private int areaId;
    private int floorId;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    public int getAreaId() {
        return areaId;
    }

    public void setAreaId(int areaId) {
        this.areaId = areaId;
    }

    public int getFloorId() {
        return floorId;
    }

    public void setFloorId(int floorId) {
        this.floorId = floorId;
    }

    @Override
    public String toString() {
        return "TeacherCommunity{" +
                "id=" + id +
                ", no='" + no + '\'' +
                ", areaId=" + areaId +
                ", floorId=" + floorId +
                '}';
    }
}
