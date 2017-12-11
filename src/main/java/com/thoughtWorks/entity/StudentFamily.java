package com.thoughtWorks.entity;

public class StudentFamily {
    private String no;
    private String relationship;
    private String name;
    private String political_status;
    private String staff;
    private String work_place;
    private String phone;

    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    public String getRelationship() {
        return relationship;
    }

    public void setRelationship(String relationship) {
        this.relationship = relationship;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPolitical_status() {
        return political_status;
    }

    public void setPolitical_status(String political_status) {
        this.political_status = political_status;
    }

    public String getStaff() {
        return staff;
    }

    public void setStaff(String staff) {
        this.staff = staff;
    }

    public String getWork_place() {
        return work_place;
    }

    public void setWork_place(String work_place) {
        this.work_place = work_place;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Override
    public String toString() {
        return "StudentFamily{" +
                "no='" + no + '\'' +
                ", relationship='" + relationship + '\'' +
                ", name='" + name + '\'' +
                ", political_status='" + political_status + '\'' +
                ", staff='" + staff + '\'' +
                ", work_place='" + work_place + '\'' +
                ", phone='" + phone + '\'' +
                '}';
    }
}
