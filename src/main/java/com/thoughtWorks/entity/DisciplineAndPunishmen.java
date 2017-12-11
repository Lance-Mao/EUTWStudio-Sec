package com.thoughtWorks.entity;

public class DisciplineAndPunishmen {
    private String date;
    private String content;
    private String studentNo;
    private String category;
    private String behavior;
    private String rank;
    private String witness;

    public String getRevokeDiscipline() {
        return revokeDiscipline;
    }

    public void setRevokeDiscipline(String revokeDiscipline) {
        this.revokeDiscipline = revokeDiscipline;
    }

    private String revokeDiscipline;

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getBehavior() {
        return behavior;
    }

    public void setBehavior(String behavior) {
        this.behavior = behavior;
    }

    public String getRank() {
        return rank;
    }

    public void setRank(String rank) {
        this.rank = rank;
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
        return "DisciplineAndPunishmen{" +
                "date='" + date + '\'' +
                ", content='" + content + '\'' +
                ", studentNo='" + studentNo + '\'' +
                ", category='" + category + '\'' +
                ", behavior='" + behavior + '\'' +
                ", rank='" + rank + '\'' +
                ", witness='" + witness + '\'' +
                '}';
    }
}
