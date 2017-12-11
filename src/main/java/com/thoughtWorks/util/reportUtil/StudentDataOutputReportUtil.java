package com.thoughtWorks.util.reportUtil;

import com.thoughtWorks.entity.StudentUpdate;
import com.thoughtWorks.util.excelUtil.ExcelReportUtil;
import org.apache.poi.hssf.usermodel.*;

import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.Objects;

public class StudentDataOutputReportUtil extends ExcelReportUtil {

    private HSSFSheet sheet;
    private HSSFRow row;
    private HSSFCell cell;
    private int rowIndex;

    @Override
    protected void writeHeaders(HSSFSheet sheet, Map<String, String> headers) {
        this.sheet = sheet;
        row = sheet.createRow(1);
        row.setHeight((short) 0x190);

        int columnIndex = 0;
        for (String key : headers.keySet()) {
            HSSFCell cell = row.createCell(columnIndex++);
            if (!key.equals("undefined")) {
                cell.setCellValue(new HSSFRichTextString(headers.get(key)));
            }
        }
        setDefaultRowHeight(sheet, 18);
    }

    @Override
    protected void writeCellData(HSSFSheet sheet, List<Map<String, Object>> dataset, HSSFWorkbook workbook) {
        try {
            rowIndex = 2;
            int count = 0;
            for (Map<String, Object> department : dataset) {
                row = sheet.createRow(rowIndex);
                int columnIndex = 0;
                for (String key : department.keySet()) {
                    if (key != "undefined"){
                        if (department.get(key) != null && department.get(key) != "" && department.get(key) != "undefined") {
                            int strLenth = department.get(key).toString().length();
                            if (strLenth < 2) {
                                sheet.setColumnWidth((short) count, (short) 1000);
                            } else if (strLenth < 8) {
                                sheet.setColumnWidth((short) count, (short) 4000);
                            } else if (strLenth < 14) {
                                sheet.setColumnWidth((short) count, (short) 6000);
                            } else if (strLenth < 20) {
                                sheet.setColumnWidth((short) count, (short) 8000);
                            } else {
                                sheet.setColumnWidth((short) count, (short) 10000);
                            }
                        }
                    }
                    cell = row.createCell(columnIndex);
                    if (department.get(key) != null && !Objects.equals(department.get(key).toString(), "请选择")) {
                        cell.setCellValue(new HSSFRichTextString(department.get(key).toString()));
                    }
                    columnIndex++;
                    count++;
                }
                rowIndex++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }


    public Map<String, String> setTheHeader(StudentUpdate studentUpdate) {
        Map<String, String> headers = new LinkedHashMap<>();
        if (studentUpdate.getNo() != null) {
            headers.put(studentUpdate.getNo().split("--")[1], studentUpdate.getNo().split("--")[0]);
        }
        if (studentUpdate.getName() != null) {
            headers.put(studentUpdate.getName().split("--")[1], studentUpdate.getName().split("--")[0]);
        }
        if (studentUpdate.getGender() != null) {
            headers.put(studentUpdate.getGender().split("--")[1], studentUpdate.getGender().split("--")[0]);
        }
        if (studentUpdate.getDepartment_id() != null) {
            headers.put(studentUpdate.getDepartment_id().split("--")[1], studentUpdate.getDepartment_id().split("--")[0]);
        }
        if (studentUpdate.getDirection_id() != null) {
            headers.put(studentUpdate.getDirection_id().split("--")[1], studentUpdate.getDirection_id().split("--")[0]);
        }
        if (studentUpdate.getLevel() != null) {
            headers.put(studentUpdate.getLevel().split("--")[1], studentUpdate.getLevel().split("--")[0]);
        }
        if (studentUpdate.getClasses_id() != null) {
            headers.put(studentUpdate.getClasses_id().split("--")[1], studentUpdate.getClasses_id().split("--")[0]);
        }
        if (studentUpdate.getProfession_id() != null) {
            headers.put(studentUpdate.getProfession_id().split("--")[1], studentUpdate.getProfession_id().split("--")[0]);
        }
        if (studentUpdate.getOrigin_profession_id() != null) {
            headers.put(studentUpdate.getOrigin_profession_id().split("--")[1], studentUpdate.getOrigin_profession_id().split("--")[0]);
        }
        if (studentUpdate.getParent_name() != null) {
            headers.put(studentUpdate.getParent_name().split("--")[1], studentUpdate.getParent_name().split("--")[0]);
        }
        if (studentUpdate.getFamous_family() != null) {
            headers.put(studentUpdate.getFamous_family().split("--")[1], studentUpdate.getFamous_family().split("--")[0]);
        }
        if (studentUpdate.getIdcard() != null) {
            headers.put(studentUpdate.getIdcard().split("--")[1], studentUpdate.getIdcard().split("--")[0]);
        }
        if (studentUpdate.getBorn() != null) {
            headers.put(studentUpdate.getBorn().split("--")[1], studentUpdate.getBorn().split("--")[0]);
        }
        if (studentUpdate.getNative_place() != null) {
            headers.put(studentUpdate.getNative_place().split("--")[1], studentUpdate.getNative_place().split("--")[0]);
        }
        if (studentUpdate.getHead_image() != null) {
            headers.put(studentUpdate.getHead_image().split("--")[1], studentUpdate.getHead_image().split("--")[0]);
        }
        if (studentUpdate.getHealth_status() != null) {
            headers.put(studentUpdate.getHealth_status().split("--")[1], studentUpdate.getHealth_status().split("--")[0]);
        }
        if (studentUpdate.getStudent_type() != null) {
            headers.put(studentUpdate.getStudent_type().split("--")[1], studentUpdate.getStudent_type().split("--")[0]);
        }
        if (studentUpdate.getIn_school() != null) {
            headers.put(studentUpdate.getIn_school().split("--")[1], studentUpdate.getIn_school().split("--")[0]);
        }
        if (studentUpdate.getGraduate_school() != null) {
            headers.put(studentUpdate.getGraduate_school().split("--")[1], studentUpdate.getGraduate_school().split("--")[0]);
        }
        if (studentUpdate.getBlood() != null) {
            headers.put(studentUpdate.getBlood().split("--")[1], studentUpdate.getBlood().split("--")[0]);
        }
        if (studentUpdate.getHeight() != null) {
            headers.put(studentUpdate.getHeight().split("--")[1], studentUpdate.getHeight().split("--")[0]);
        }
        if (studentUpdate.getIs_marry() != null) {
            headers.put(studentUpdate.getIs_marry().split("--")[1], studentUpdate.getIs_marry().split("--")[0]);
        }
        if (studentUpdate.getWeight() != null) {
            headers.put(studentUpdate.getWeight().split("--")[1], studentUpdate.getWeight().split("--")[0]);
        }
        if (studentUpdate.getPolitical_status() != null) {
            headers.put(studentUpdate.getPolitical_status().split("--")[1], studentUpdate.getPolitical_status().split("--")[0]);
        }
        if (studentUpdate.getPre_school_education() != null) {
            headers.put(studentUpdate.getPre_school_education().split("--")[1], studentUpdate.getPre_school_education().split("--")[0]);
        }
        if (studentUpdate.getStudent_classify() != null) {
            headers.put(studentUpdate.getStudent_classify().split("--")[1], studentUpdate.getStudent_classify().split("--")[0]);
        }
        if (studentUpdate.getIdcard_address() != null) {
            headers.put(studentUpdate.getIdcard_address().split("--")[1], studentUpdate.getIdcard_address().split("--")[0]);
        }
        if (studentUpdate.getActual_address() != null) {
            headers.put(studentUpdate.getActual_address().split("--")[1], studentUpdate.getActual_address().split("--")[0]);
        }
        if (studentUpdate.getStudent_contact_method() != null) {
            headers.put(studentUpdate.getStudent_contact_method().split("--")[1], studentUpdate.getStudent_contact_method().split("--")[0]);
        }
        if (studentUpdate.getQq() != null) {
            headers.put(studentUpdate.getQq().split("--")[1], studentUpdate.getQq().split("--")[0]);
        }
        if (studentUpdate.getEmail() != null) {
            headers.put(studentUpdate.getEmail().split("--")[1], studentUpdate.getEmail().split("--")[0]);
        }
        if (studentUpdate.getOrigin_address() != null) {
            headers.put(studentUpdate.getOrigin_address().split("--")[1], studentUpdate.getOrigin_address().split("--")[0]);
        }
        if (studentUpdate.getFamily_phone() != null) {
            headers.put(studentUpdate.getFamily_phone().split("--")[1], studentUpdate.getFamily_phone().split("--")[0]);
        }
        if (studentUpdate.getFamily_zip_code() != null) {
            headers.put(studentUpdate.getFamily_zip_code().split("--")[1], studentUpdate.getFamily_zip_code().split("--")[0]);
        }
        if (studentUpdate.getStudent_contact_method() != null) {
            headers.put(studentUpdate.getStudent_contact_method().split("--")[1], studentUpdate.getStudent_contact_method().split("--")[0]);
        }
        if (studentUpdate.getEmergency_contact_method() != null) {
            headers.put(studentUpdate.getEmergency_contact_method().split("--")[1], studentUpdate.getEmergency_contact_method().split("--")[0]);
        }
        if (studentUpdate.getEmergency_contact_name() != null) {
            headers.put(studentUpdate.getEmergency_contact_name().split("--")[1], studentUpdate.getEmergency_contact_name().split("--")[0]);
        }
        if (studentUpdate.getAccount_in() != null) {
            headers.put(studentUpdate.getAccount_in().split("--")[1], studentUpdate.getAccount_in().split("--")[0]);
        }
        if (studentUpdate.getEmail() != null) {
            headers.put(studentUpdate.getEmail().split("--")[1], studentUpdate.getEmail().split("--")[0]);
        }
        if (studentUpdate.getQq() != null) {
            headers.put(studentUpdate.getQq().split("--")[1], studentUpdate.getQq().split("--")[0]);
        }
        if (studentUpdate.getArea_origin_name() != null) {
            headers.put(studentUpdate.getArea_origin_name().split("--")[1], studentUpdate.getArea_origin_name().split("--")[0]);
        }
        if (studentUpdate.getSat_score() != null) {
            headers.put(studentUpdate.getSat_score().split("--")[1], studentUpdate.getSat_score().split("--")[0]);
        }
        if (studentUpdate.getPre_school_file_where_location() != null) {
            headers.put(studentUpdate.getPre_school_file_where_location().split("--")[1], studentUpdate.getPre_school_file_where_location().split("--")[0]);
        }
        if (studentUpdate.getFile_in() != null) {
            headers.put(studentUpdate.getFile_in().split("--")[1], studentUpdate.getFile_in().split("--")[0]);
        }
        if (studentUpdate.getPre_school_name() != null) {
            headers.put(studentUpdate.getPre_school_name().split("--")[1], studentUpdate.getPre_school_name().split("--")[0]);
        }
        if (studentUpdate.getPre_school_account_where_station() != null) {
            headers.put(studentUpdate.getPre_school_account_where_station().split("--")[1], studentUpdate.getPre_school_account_where_station().split("--")[0]);
        }
        if (studentUpdate.getPre_school_work() != null) {
            headers.put(studentUpdate.getPre_school_work().split("--")[1], studentUpdate.getPre_school_work().split("--")[0]);
        }
        if (studentUpdate.getPre_school_staff() != null) {
            headers.put(studentUpdate.getPre_school_staff().split("--")[1], studentUpdate.getPre_school_staff().split("--")[0]);
        }
        if (studentUpdate.getOwn_experience() != null) {
            headers.put(studentUpdate.getOwn_experience().split("--")[1], studentUpdate.getOwn_experience().split("--")[0]);
        }
        if (studentUpdate.getOwn_punishment() != null) {
            headers.put(studentUpdate.getOwn_punishment().split("--")[1], studentUpdate.getOwn_punishment().split("--")[0]);
        }
        if (studentUpdate.getStudent_status() != null) {
            headers.put(studentUpdate.getStudent_status().split("--")[1], studentUpdate.getStudent_status().split("--")[0]);
        }
        if (studentUpdate.getPayment_status_first_year() != null) {
            headers.put(studentUpdate.getPayment_status_first_year().split("--")[1], studentUpdate.getPayment_status_first_year().split("--")[0]);
        }
        if (studentUpdate.getPayment_status_second_year() != null) {
            headers.put(studentUpdate.getPayment_status_second_year().split("--")[1], studentUpdate.getPayment_status_second_year().split("--")[0]);
        }
        if (studentUpdate.getPayment_status_third_year() != null) {
            headers.put(studentUpdate.getPayment_status_third_year().split("--")[1], studentUpdate.getPayment_status_third_year().split("--")[0]);
        }
        if (studentUpdate.getPayment_status_forth_year() != null) {
            headers.put(studentUpdate.getPayment_status_forth_year().split("--")[1], studentUpdate.getPayment_status_forth_year().split("--")[0]);
        }
        if (studentUpdate.getPayment_status_fifth_year() != null) {
            headers.put(studentUpdate.getPayment_status_fifth_year().split("--")[1], studentUpdate.getPayment_status_fifth_year().split("--")[0]);
        }
        if (studentUpdate.getPayment_status_sixth_year() != null) {
            headers.put(studentUpdate.getPayment_status_sixth_year().split("--")[1], studentUpdate.getPayment_status_sixth_year().split("--")[0]);
        }
        if (studentUpdate.getPractice_learning_type() != null) {
            headers.put(studentUpdate.getPractice_learning_type().split("--")[1], studentUpdate.getPractice_learning_type().split("--")[0]);
        }
        if (studentUpdate.getStay_type() != null) {
            headers.put(studentUpdate.getStay_type().split("--")[1], studentUpdate.getStay_type().split("--")[0]);
        }
        if (studentUpdate.getOff_school_stay_address() != null) {
            headers.put(studentUpdate.getOff_school_stay_address().split("--")[1], studentUpdate.getOff_school_stay_address().split("--")[0]);
        }
        if (studentUpdate.getArea_id() != null) {
            headers.put(studentUpdate.getArea_id().split("--")[1], studentUpdate.getArea_id().split("--")[0]);
        }
        if (studentUpdate.getFloor_id() != null) {
            headers.put(studentUpdate.getFloor_id().split("--")[1], studentUpdate.getFloor_id().split("--")[0]);
        }
        if (studentUpdate.getRoom_id() != null) {
            headers.put(studentUpdate.getRoom_id().split("--")[1], studentUpdate.getRoom_id().split("--")[0]);
        }
        if (studentUpdate.getCounselor_id() != null) {
            headers.put(studentUpdate.getCounselor_id().split("--")[1], studentUpdate.getCounselor_id().split("--")[0]);
        }
        if (studentUpdate.getIs_out() != null) {
            headers.put(studentUpdate.getIs_out().split("--")[1], studentUpdate.getIs_out().split("--")[0]);
        }
        if (studentUpdate.getReligion() != null) {
            headers.put(studentUpdate.getReligion().split("--")[1], studentUpdate.getReligion().split("--")[0]);
        }
        if (studentUpdate.getReligionText() != null) {
            headers.put(studentUpdate.getReligionText().split("--")[1], studentUpdate.getReligionText().split("--")[0]);
        }
        if (studentUpdate.getHard_type() != null) {
            headers.put(studentUpdate.getHard_type().split("--")[1], studentUpdate.getHard_type().split("--")[0]);
        }
        if (studentUpdate.getArrears_first_year() != null) {
            headers.put(studentUpdate.getArrears_first_year().split("--")[1], studentUpdate.getArrears_first_year().split("--")[0]);
        }
        if (studentUpdate.getArrears_second_year() != null) {
            headers.put(studentUpdate.getArrears_second_year().split("--")[1], studentUpdate.getArrears_second_year().split("--")[0]);
        }
        if (studentUpdate.getArrears_third_year() != null) {
            headers.put(studentUpdate.getArrears_third_year().split("--")[1], studentUpdate.getArrears_third_year().split("--")[0]);
        }
        if (studentUpdate.getArrears_forth_year() != null) {
            headers.put(studentUpdate.getArrears_forth_year().split("--")[1], studentUpdate.getArrears_forth_year().split("--")[0]);
        }
        if (studentUpdate.getArrears_fifth_year() != null) {
            headers.put(studentUpdate.getArrears_fifth_year().split("--")[1], studentUpdate.getArrears_fifth_year().split("--")[0]);
        }
        if (studentUpdate.getArrears_sixth_year() != null) {
            headers.put(studentUpdate.getArrears_sixth_year().split("--")[1], studentUpdate.getArrears_sixth_year().split("--")[0]);
        }
        if (studentUpdate.getTeacher_id() != null) {
            headers.put(studentUpdate.getTeacher_id().split("--")[1], studentUpdate.getTeacher_id().split("--")[0]);
        }
        if (studentUpdate.getCommunity_teacher_id() != null) {
            headers.put(studentUpdate.getCommunity_teacher_id().split("--")[1], studentUpdate.getCommunity_teacher_id().split("--")[0]);
        }
        if (studentUpdate.getGroup() != null) {
            headers.put(studentUpdate.getGroup().split("--")[1], studentUpdate.getGroup().split("--")[0]);
        }
        if (studentUpdate.getFirst_year() != null) {
            headers.put(studentUpdate.getFirst_year().split("--")[1], studentUpdate.getFirst_year().split("--")[0]);
        }
        if (studentUpdate.getFirst_scholarship() != null) {
            headers.put(studentUpdate.getFirst_scholarship().split("--")[1], studentUpdate.getFirst_scholarship().split("--")[0]);
        }
        if (studentUpdate.getFirst_stipend() != null) {
            headers.put(studentUpdate.getFirst_stipend().split("--")[1], studentUpdate.getFirst_stipend().split("--")[0]);
        }
        if (studentUpdate.getSecond_year() != null) {
            headers.put(studentUpdate.getSecond_year().split("--")[1], studentUpdate.getSecond_year().split("--")[0]);
        }
        if (studentUpdate.getSecond_scholarship() != null) {
            headers.put(studentUpdate.getSecond_scholarship().split("--")[1], studentUpdate.getSecond_scholarship().split("--")[0]);
        }
        if (studentUpdate.getSecond_stipend() != null) {
            headers.put(studentUpdate.getSecond_stipend().split("--")[1], studentUpdate.getSecond_stipend().split("--")[0]);
        }
        if (studentUpdate.getThird_year() != null) {
            headers.put(studentUpdate.getThird_year().split("--")[1], studentUpdate.getThird_year().split("--")[0]);
        }
        if (studentUpdate.getThird_scholarship() != null) {
            headers.put(studentUpdate.getThird_scholarship().split("--")[1], studentUpdate.getThird_scholarship().split("--")[0]);
        }
        if (studentUpdate.getThird_stipend() != null) {
            headers.put(studentUpdate.getThird_stipend().split("--")[1], studentUpdate.getThird_stipend().split("--")[0]);
        }
        if (studentUpdate.getUnits_or_projects_practical_type() != null) {
            headers.put(studentUpdate.getUnits_or_projects_practical_type().split("--")[1], studentUpdate.getUnits_or_projects_practical_type().split("--")[0]);
        }
        if (studentUpdate.getUnits_or_projects_practical_type_contact() != null) {
            headers.put(studentUpdate.getUnits_or_projects_practical_type_contact().split("--")[1], studentUpdate.getUnits_or_projects_practical_type_contact().split("--")[0]);
        }
        if (studentUpdate.getUnits_or_projects_practical_type_contact_phone() != null) {
            headers.put(studentUpdate.getUnits_or_projects_practical_type_contact_phone().split("--")[1], studentUpdate.getUnits_or_projects_practical_type_contact_phone().split("--")[0]);
        }
        if (studentUpdate.getUpdateOffCampusContactPhone() != null) {
            headers.put(studentUpdate.getUpdateOffCampusContactPhone().split("--")[1], studentUpdate.getUpdateOffCampusContactPhone().split("--")[0]);
        }
        if (studentUpdate.getUpdateOffCampusContactName() != null) {
            headers.put(studentUpdate.getUpdateOffCampusContactName().split("--")[1], studentUpdate.getUpdateOffCampusContactName().split("--")[0]);
        }
        if (studentUpdate.getOtherHealthStatus() != null) {
            headers.put(studentUpdate.getOtherHealthStatus().split("--")[1], studentUpdate.getOtherHealthStatus().split("--")[0]);
        }
        if (studentUpdate.getPartyOrGroupOrganization() != null) {
            headers.put(studentUpdate.getPartyOrGroupOrganization().split("--")[1], studentUpdate.getPartyOrGroupOrganization().split("--")[0]);
        }
        if (studentUpdate.getPartyOrGroupOrganizationText() != null) {
            headers.put(studentUpdate.getPartyOrGroupOrganizationText().split("--")[1], studentUpdate.getPartyOrGroupOrganizationText().split("--")[0]);
        }
        if (studentUpdate.getFirst_time_medical_insurance() != null) {
            headers.put(studentUpdate.getFirst_time_medical_insurance().split("--")[1], studentUpdate.getFirst_time_medical_insurance().split("--")[0]);
        }
        if (studentUpdate.getSecond_time_medical_insurance() != null) {
            headers.put(studentUpdate.getSecond_time_medical_insurance().split("--")[1], studentUpdate.getSecond_time_medical_insurance().split("--")[0]);
        }
        if (studentUpdate.getThird_time_medical_insurance() != null) {
            headers.put(studentUpdate.getThird_time_medical_insurance().split("--")[1], studentUpdate.getThird_time_medical_insurance().split("--")[0]);
        }
        if (studentUpdate.getFirst_medical_insurance() != null) {
            headers.put(studentUpdate.getFirst_medical_insurance().split("--")[1], studentUpdate.getFirst_medical_insurance().split("--")[0]);
        }
        if (studentUpdate.getSecond_medical_insurance() != null) {
            headers.put(studentUpdate.getSecond_medical_insurance().split("--")[1], studentUpdate.getSecond_medical_insurance().split("--")[0]);
        }
        if (studentUpdate.getThird_medical_insurance() != null) {
            headers.put(studentUpdate.getThird_medical_insurance().split("--")[1], studentUpdate.getThird_medical_insurance().split("--")[0]);
        }
        if (studentUpdate.getPre_admissionOrReward() != null) {
            headers.put(studentUpdate.getPre_admissionOrReward().split("--")[1], studentUpdate.getPre_admissionOrReward().split("--")[0]);
        }
        if (studentUpdate.getPre_admissionOrRewardText() != null) {
            headers.put(studentUpdate.getPre_admissionOrRewardText().split("--")[1], studentUpdate.getPre_admissionOrRewardText().split("--")[0]);
        }
        return headers;
    }
}
