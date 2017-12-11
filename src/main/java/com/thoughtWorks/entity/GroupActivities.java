package com.thoughtWorks.entity;

public class GroupActivities {
    private String date;
    private String content;
    private String studentNo;
    private String types;
    private String hours;
    private String heading;
    private String witness;

    public String getTypes() {
        return types;
    }

    public void setTypes(String types) {
        this.types = types;
    }

    public String getHours() {
        return hours;
    }

    public void setHours(String hours) {
        this.hours = hours;
    }

    public String getHeading() {
        return heading;
    }

    public void setHeading(String heading) {
        this.heading = heading;
    }

    public String getWitness() {
        return witness;
    }

    public void setWitness(String witness) {
        this.witness = witness;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getStudentNo() {
        return studentNo;
    }

    public void setStudentNo(String studentNo) {
        this.studentNo = studentNo;
    }

    @Override
    public String toString() {
        return "GroupActivities{" +
                "date='" + date + '\'' +
                ", content='" + content + '\'' +
                ", studentNo='" + studentNo + '\'' +
                ", types='" + types + '\'' +
                ", hours='" + hours + '\'' +
                ", heading='" + heading + '\'' +
                ", witness='" + witness + '\'' +
                '}';
    }
}
