package com.thoughtWorks.web.reportManagement;


import com.thoughtWorks.dto.DataSearchDto;
import com.thoughtWorks.entity.StudentUpdate;
import com.thoughtWorks.service.StudentDataOutputService;
import com.thoughtWorks.util.reportUtil.StudentDataOutputReportUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.util.ArrayList;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import static com.thoughtWorks.util.FileUtil.getResponseEntity;

@Component
@RequestMapping("/dataOutput")
public class StudentDataOutputController {


    @Autowired
    StudentDataOutputService studentDataOutputService;

    @RequestMapping("/list")
    public ResponseEntity<byte[]> list(StudentUpdate studentUpdate, DataSearchDto dataSearchDto, HttpServletRequest request) {
        try {
            List<Map<String, Object>> exportedData = new ArrayList<>();
            List<Map<String, Object>> dataOutputStudents = studentDataOutputService.queryStudentList(dataSearchDto);
            new StudentDataOutputReportUtil().setTheHeader(studentUpdate);
            checkData(studentUpdate, exportedData, dataOutputStudents);
            ResponseEntity<byte[]> responseEntity;
            File file = studentDataOutputService.newStudentDataOutput(request, exportedData, studentUpdate);
            responseEntity = getResponseEntity(file);
            file.delete();

            return responseEntity;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    private void checkData(StudentUpdate studentUpdate, List<Map<String, Object>> exportedData, List<Map<String, Object>> dataOutputStudents) {
        for (Map<String, Object> dataOutputStudent : dataOutputStudents) {
            Map<String, Object> singleData = new LinkedHashMap<>();
            if (studentUpdate.getNo() != null) {
                System.out.println("学号：" + studentUpdate.getNo());
                singleData.put(studentUpdate.getNo().split("--")[1], dataOutputStudent.get(studentUpdate.getNo().split("--")[1]));
            }
            if (studentUpdate.getName() != null) {
                singleData.put(studentUpdate.getName().split("--")[1], dataOutputStudent.get(studentUpdate.getName().split("--")[1]));
            }
            if (studentUpdate.getGender() != null) {
                if (dataOutputStudent.get(studentUpdate.getGender().split("--")[1]) != null) {
                    singleData.put(studentUpdate.getGender().split("--")[1], dataOutputStudent.get(studentUpdate.getGender().split("--")[1]).toString().equals("M") ? "男" : "女");
                }
            }
            if (studentUpdate.getDepartment_id() != null) {
                singleData.put(studentUpdate.getDepartment_id().split("--")[1], dataOutputStudent.get("department"));
            }
            if (studentUpdate.getDirection_id() != null) {
                singleData.put(studentUpdate.getDirection_id().split("--")[1], dataOutputStudent.get("direction"));
            }
            if (studentUpdate.getLevel() != null) {
                singleData.put(studentUpdate.getLevel().split("--")[1], dataOutputStudent.get(studentUpdate.getLevel().split("--")[1]));
            }
            if (studentUpdate.getClasses_id() != null) {
                singleData.put(studentUpdate.getClasses_id().split("--")[1], dataOutputStudent.get("classes"));
            }
            if (studentUpdate.getProfession_id() != null) {
                singleData.put(studentUpdate.getProfession_id().split("--")[1], dataOutputStudent.get("profession"));
            }
            if (studentUpdate.getOrigin_profession_id() != null) {
                singleData.put(studentUpdate.getOrigin_profession_id().split("--")[1], dataOutputStudent.get("origin_profession"));
            }
            if (studentUpdate.getParent_name() != null) {
                singleData.put(studentUpdate.getParent_name().split("--")[1], dataOutputStudent.get(studentUpdate.getParent_name().split("--")[1]));
            }
            if (studentUpdate.getFamous_family() != null) {
                singleData.put(studentUpdate.getFamous_family().split("--")[1], dataOutputStudent.get(studentUpdate.getFamous_family().split("--")[1]));
            }
            if (studentUpdate.getIdcard() != null) {
                singleData.put(studentUpdate.getIdcard().split("--")[1], dataOutputStudent.get(studentUpdate.getIdcard().split("--")[1]));
            }
            if (studentUpdate.getBorn() != null) {
                singleData.put(studentUpdate.getBorn().split("--")[1], dataOutputStudent.get(studentUpdate.getBorn().split("--")[1]));
            }
            if (studentUpdate.getNative_place() != null) {
                singleData.put(studentUpdate.getNative_place().split("--")[1], dataOutputStudent.get(studentUpdate.getNative_place().split("--")[1]));
            }
            if (studentUpdate.getHead_image() != null) {
                singleData.put(studentUpdate.getHead_image().split("--")[1], dataOutputStudent.get(studentUpdate.getHead_image().split("--")[1]));
            }
            if (studentUpdate.getHealth_status() != null) {
                singleData.put(studentUpdate.getHealth_status().split("--")[1], dataOutputStudent.get(studentUpdate.getHealth_status().split("--")[1]));
            }
            if (studentUpdate.getStudent_type() != null) {
                singleData.put(studentUpdate.getStudent_type().split("--")[1], dataOutputStudent.get(studentUpdate.getStudent_type().split("--")[1]));
            }
            if (studentUpdate.getIn_school() != null) {
                singleData.put(studentUpdate.getIn_school().split("--")[1], dataOutputStudent.get(studentUpdate.getIn_school().split("--")[1]));
            }
            if (studentUpdate.getGraduate_school() != null) {
                singleData.put(studentUpdate.getGraduate_school().split("--")[1], dataOutputStudent.get(studentUpdate.getGraduate_school().split("--")[1]));
            }
            if (studentUpdate.getBlood() != null) {
                singleData.put(studentUpdate.getBlood().split("--")[1], dataOutputStudent.get(studentUpdate.getBlood().split("--")[1]));
            }
            if (studentUpdate.getHeight() != null) {
                singleData.put(studentUpdate.getHeight().split("--")[1], dataOutputStudent.get(studentUpdate.getHeight().split("--")[1]));
            }
            if (studentUpdate.getIs_marry() != null) {
                singleData.put(studentUpdate.getIs_marry().split("--")[1], dataOutputStudent.get(studentUpdate.getIs_marry().split("--")[1]));
            }
            if (studentUpdate.getWeight() != null) {
                singleData.put(studentUpdate.getWeight().split("--")[1], dataOutputStudent.get(studentUpdate.getWeight().split("--")[1]));
            }
            if (studentUpdate.getPolitical_status() != null) {
                singleData.put(studentUpdate.getPolitical_status().split("--")[1], dataOutputStudent.get(studentUpdate.getPolitical_status().split("--")[1]));
            }
            if (studentUpdate.getPre_school_education() != null) {
                singleData.put(studentUpdate.getPre_school_education().split("--")[1], dataOutputStudent.get(studentUpdate.getPre_school_education().split("--")[1]));
            }
            if (studentUpdate.getStudent_classify() != null) {
                singleData.put(studentUpdate.getStudent_classify().split("--")[1], dataOutputStudent.get(studentUpdate.getStudent_classify().split("--")[1]));
            }
            if (studentUpdate.getIdcard_address() != null) {
                singleData.put(studentUpdate.getIdcard_address().split("--")[1], dataOutputStudent.get(studentUpdate.getIdcard_address().split("--")[1]));
            }
            if (studentUpdate.getActual_address() != null) {
                singleData.put(studentUpdate.getActual_address().split("--")[1], dataOutputStudent.get(studentUpdate.getActual_address().split("--")[1]));
            }
            if (studentUpdate.getStudent_contact_method() != null) {
                singleData.put(studentUpdate.getStudent_contact_method().split("--")[1], dataOutputStudent.get(studentUpdate.getStudent_contact_method().split("--")[1]));
            }
            if (studentUpdate.getQq() != null) {
                singleData.put(studentUpdate.getQq().split("--")[1], dataOutputStudent.get(studentUpdate.getQq().split("--")[1]));
            }
            if (studentUpdate.getEmail() != null) {
                singleData.put(studentUpdate.getEmail().split("--")[1], dataOutputStudent.get(studentUpdate.getEmail().split("--")[1]));
            }
            if (studentUpdate.getOrigin_address() != null) {
                singleData.put(studentUpdate.getOrigin_address().split("--")[1], dataOutputStudent.get(studentUpdate.getOrigin_address().split("--")[1]));
            }
            if (studentUpdate.getFamily_phone() != null) {
                singleData.put(studentUpdate.getFamily_phone().split("--")[1], dataOutputStudent.get(studentUpdate.getFamily_phone().split("--")[1]));
            }
            if (studentUpdate.getFamily_zip_code() != null) {
                singleData.put(studentUpdate.getFamily_zip_code().split("--")[1], dataOutputStudent.get(studentUpdate.getFamily_zip_code().split("--")[1]));
            }
            if (studentUpdate.getStudent_contact_method() != null) {
                singleData.put(studentUpdate.getStudent_contact_method().split("--")[1], dataOutputStudent.get(studentUpdate.getStudent_contact_method().split("--")[1]));
            }
            if (studentUpdate.getEmergency_contact_method() != null) {
                singleData.put(studentUpdate.getEmergency_contact_method().split("--")[1], dataOutputStudent.get(studentUpdate.getEmergency_contact_method().split("--")[1]));
            }
            if (studentUpdate.getEmergency_contact_name() != null) {
                singleData.put(studentUpdate.getEmergency_contact_name().split("--")[1], dataOutputStudent.get(studentUpdate.getEmergency_contact_name().split("--")[1]));
            }
            if (studentUpdate.getAccount_in() != null) {
                singleData.put(studentUpdate.getAccount_in().split("--")[1], dataOutputStudent.get(studentUpdate.getAccount_in().split("--")[1]));
            }
            if (studentUpdate.getEmail() != null) {
                singleData.put(studentUpdate.getEmail().split("--")[1], dataOutputStudent.get(studentUpdate.getEmail().split("--")[1]));
            }
            if (studentUpdate.getQq() != null) {
                singleData.put(studentUpdate.getQq().split("--")[1], dataOutputStudent.get(studentUpdate.getQq().split("--")[1]));
            }
            if (studentUpdate.getArea_origin_name() != null) {
                singleData.put(studentUpdate.getArea_origin_name().split("--")[1], dataOutputStudent.get(studentUpdate.getArea_origin_name().split("--")[1]));
            }
            if (studentUpdate.getSat_score() != null) {
                singleData.put(studentUpdate.getSat_score().split("--")[1], dataOutputStudent.get(studentUpdate.getSat_score().split("--")[1]));
            }
            if (studentUpdate.getPre_school_file_where_location() != null) {
                singleData.put(studentUpdate.getPre_school_file_where_location().split("--")[1], dataOutputStudent.get(studentUpdate.getPre_school_file_where_location().split("--")[1]));
            }
            if (studentUpdate.getFile_in() != null) {
                singleData.put(studentUpdate.getFile_in().split("--")[1], dataOutputStudent.get(studentUpdate.getFile_in().split("--")[1]));
            }
            if (studentUpdate.getPre_school_name() != null) {
                singleData.put(studentUpdate.getPre_school_name().split("--")[1], dataOutputStudent.get(studentUpdate.getPre_school_name().split("--")[1]));
            }
            if (studentUpdate.getPre_school_account_where_station() != null) {
                singleData.put(studentUpdate.getPre_school_account_where_station().split("--")[1], dataOutputStudent.get(studentUpdate.getPre_school_account_where_station().split("--")[1]));
            }
            if (studentUpdate.getPre_school_work() != null) {
                singleData.put(studentUpdate.getPre_school_work().split("--")[1], dataOutputStudent.get(studentUpdate.getPre_school_work().split("--")[1]));
            }
            if (studentUpdate.getPre_school_staff() != null) {
                singleData.put(studentUpdate.getPre_school_staff().split("--")[1], dataOutputStudent.get(studentUpdate.getPre_school_staff().split("--")[1]));
            }
            if (studentUpdate.getOwn_experience() != null) {
                singleData.put(studentUpdate.getOwn_experience().split("--")[1], dataOutputStudent.get(studentUpdate.getOwn_experience().split("--")[1]));
            }
            if (studentUpdate.getOwn_punishment() != null) {
                singleData.put(studentUpdate.getOwn_punishment().split("--")[1], dataOutputStudent.get(studentUpdate.getOwn_punishment().split("--")[1]));
            }
            if (studentUpdate.getStudent_status() != null) {
                singleData.put(studentUpdate.getStudent_status().split("--")[1], dataOutputStudent.get(studentUpdate.getStudent_status().split("--")[1]));
            }
            if (studentUpdate.getPayment_status_first_year() != null) {
                singleData.put(studentUpdate.getPayment_status_first_year().split("--")[1], dataOutputStudent.get(studentUpdate.getPayment_status_first_year().split("--")[1]));
            }
            if (studentUpdate.getPayment_status_second_year() != null) {
                singleData.put(studentUpdate.getPayment_status_second_year().split("--")[1], dataOutputStudent.get(studentUpdate.getPayment_status_second_year().split("--")[1]));
            }
            if (studentUpdate.getPayment_status_third_year() != null) {
                singleData.put(studentUpdate.getPayment_status_third_year().split("--")[1], dataOutputStudent.get(studentUpdate.getPayment_status_third_year().split("--")[1]));
            }
            if (studentUpdate.getPayment_status_forth_year() != null) {
                singleData.put(studentUpdate.getPayment_status_forth_year().split("--")[1], dataOutputStudent.get(studentUpdate.getPayment_status_forth_year().split("--")[1]));
            }
            if (studentUpdate.getPayment_status_fifth_year() != null) {
                singleData.put(studentUpdate.getPayment_status_fifth_year().split("--")[1], dataOutputStudent.get(studentUpdate.getPayment_status_fifth_year().split("--")[1]));
            }
            if (studentUpdate.getPayment_status_sixth_year() != null) {
                singleData.put(studentUpdate.getPayment_status_sixth_year().split("--")[1], dataOutputStudent.get(studentUpdate.getPayment_status_sixth_year().split("--")[1]));
            }
            if (studentUpdate.getPractice_learning_type() != null) {
                singleData.put(studentUpdate.getPractice_learning_type().split("--")[1], dataOutputStudent.get(studentUpdate.getPractice_learning_type().split("--")[1]));
            }
            if (studentUpdate.getStay_type() != null) {
                singleData.put(studentUpdate.getStay_type().split("--")[1], dataOutputStudent.get(studentUpdate.getStay_type().split("--")[1]));
            }
            if (studentUpdate.getOff_school_stay_address() != null) {
                singleData.put(studentUpdate.getOff_school_stay_address().split("--")[1], dataOutputStudent.get(studentUpdate.getOff_school_stay_address().split("--")[1]));
            }
            if (studentUpdate.getArea_id() != null) {
                singleData.put(studentUpdate.getArea_id().split("--")[1], dataOutputStudent.get(studentUpdate.getArea_id().split("--")[1]));
            }
            if (studentUpdate.getFloor_id() != null) {
                singleData.put(studentUpdate.getFloor_id().split("--")[1], dataOutputStudent.get(studentUpdate.getFloor_id().split("--")[1]));
            }
            if (studentUpdate.getRoom_id() != null) {
                singleData.put(studentUpdate.getRoom_id().split("--")[1], dataOutputStudent.get(studentUpdate.getRoom_id().split("--")[1]));
            }
            if (studentUpdate.getCounselor_id() != null) {
                singleData.put(studentUpdate.getCounselor_id().split("--")[1], dataOutputStudent.get(studentUpdate.getCounselor_id().split("--")[1]));
            }
            if (studentUpdate.getIs_out() != null) {
                singleData.put(studentUpdate.getIs_out().split("--")[1], dataOutputStudent.get(studentUpdate.getIs_out().split("--")[1]));
            }
            if (studentUpdate.getReligion() != null) {
                singleData.put(studentUpdate.getReligion().split("--")[1], dataOutputStudent.get(studentUpdate.getReligion().split("--")[1]));
            }
            if (studentUpdate.getReligionText() != null) {
                singleData.put(studentUpdate.getReligionText().split("--")[1], dataOutputStudent.get(studentUpdate.getReligionText().split("--")[1]));
            }
            if (studentUpdate.getHard_type() != null) {
                singleData.put(studentUpdate.getHard_type().split("--")[1], dataOutputStudent.get(studentUpdate.getHard_type().split("--")[1]));
            }
            if (studentUpdate.getArrears_first_year() != null) {
                singleData.put(studentUpdate.getArrears_first_year().split("--")[1], dataOutputStudent.get(studentUpdate.getArrears_first_year().split("--")[1]));
            }
            if (studentUpdate.getArrears_second_year() != null) {
                singleData.put(studentUpdate.getArrears_second_year().split("--")[1], dataOutputStudent.get(studentUpdate.getArrears_second_year().split("--")[1]));
            }
            if (studentUpdate.getArrears_third_year() != null) {
                singleData.put(studentUpdate.getArrears_third_year().split("--")[1], dataOutputStudent.get(studentUpdate.getArrears_third_year().split("--")[1]));
            }
            if (studentUpdate.getArrears_forth_year() != null) {
                singleData.put(studentUpdate.getArrears_forth_year().split("--")[1], dataOutputStudent.get(studentUpdate.getArrears_forth_year().split("--")[1]));
            }
            if (studentUpdate.getArrears_fifth_year() != null) {
                singleData.put(studentUpdate.getArrears_fifth_year().split("--")[1], dataOutputStudent.get(studentUpdate.getArrears_fifth_year().split("--")[1]));
            }
            if (studentUpdate.getArrears_sixth_year() != null) {
                singleData.put(studentUpdate.getArrears_sixth_year().split("--")[1], dataOutputStudent.get(studentUpdate.getArrears_sixth_year().split("--")[1]));
            }
            if (studentUpdate.getTeacher_id() != null) {
                singleData.put(studentUpdate.getTeacher_id().split("--")[1], dataOutputStudent.get("teacher_name"));
            }
            if (studentUpdate.getCommunity_teacher_id() != null) {
                singleData.put(studentUpdate.getCommunity_teacher_id().split("--")[1], dataOutputStudent.get(studentUpdate.getCommunity_teacher_id().split("--")[1]));
            }
            if (studentUpdate.getGroup() != null) {
                singleData.put(studentUpdate.getGroup().split("--")[1], dataOutputStudent.get(studentUpdate.getGroup().split("--")[1]));
            }
            if (studentUpdate.getFirst_year() != null) {
                singleData.put(studentUpdate.getFirst_year().split("--")[1], dataOutputStudent.get(studentUpdate.getFirst_year().split("--")[1]));
            }
            if (studentUpdate.getFirst_scholarship() != null) {
                singleData.put(studentUpdate.getFirst_scholarship().split("--")[1], dataOutputStudent.get(studentUpdate.getFirst_scholarship().split("--")[1]));
            }
            if (studentUpdate.getFirst_stipend() != null) {
                singleData.put(studentUpdate.getFirst_stipend().split("--")[1], dataOutputStudent.get(studentUpdate.getFirst_stipend().split("--")[1]));
            }
            if (studentUpdate.getSecond_year() != null) {
                singleData.put(studentUpdate.getSecond_year().split("--")[1], dataOutputStudent.get(studentUpdate.getSecond_year().split("--")[1]));
            }
            if (studentUpdate.getSecond_scholarship() != null) {
                singleData.put(studentUpdate.getSecond_scholarship().split("--")[1], dataOutputStudent.get(studentUpdate.getSecond_scholarship().split("--")[1]));
            }
            if (studentUpdate.getSecond_stipend() != null) {
                singleData.put(studentUpdate.getSecond_stipend().split("--")[1], dataOutputStudent.get(studentUpdate.getSecond_stipend().split("--")[1]));
            }
            if (studentUpdate.getThird_year() != null) {
                singleData.put(studentUpdate.getThird_year().split("--")[1], dataOutputStudent.get(studentUpdate.getThird_year().split("--")[1]));
            }
            if (studentUpdate.getThird_scholarship() != null) {
                singleData.put(studentUpdate.getThird_scholarship().split("--")[1], dataOutputStudent.get(studentUpdate.getThird_scholarship().split("--")[1]));
            }
            if (studentUpdate.getThird_stipend() != null) {
                singleData.put(studentUpdate.getThird_stipend().split("--")[1], dataOutputStudent.get(studentUpdate.getThird_stipend().split("--")[1]));
            }
            if (studentUpdate.getUnits_or_projects_practical_type() != null) {
                singleData.put(studentUpdate.getUnits_or_projects_practical_type().split("--")[1], dataOutputStudent.get(studentUpdate.getUnits_or_projects_practical_type().split("--")[1]));
            }
            if (studentUpdate.getUnits_or_projects_practical_type_contact() != null) {
                singleData.put(studentUpdate.getUnits_or_projects_practical_type_contact().split("--")[1], dataOutputStudent.get(studentUpdate.getUnits_or_projects_practical_type_contact().split("--")[1]));
            }
            if (studentUpdate.getUnits_or_projects_practical_type_contact_phone() != null) {
                singleData.put(studentUpdate.getUnits_or_projects_practical_type_contact_phone().split("--")[1], dataOutputStudent.get(studentUpdate.getUnits_or_projects_practical_type_contact_phone().split("--")[1]));
            }
            if (studentUpdate.getUpdateOffCampusContactPhone() != null) {
                singleData.put(studentUpdate.getUpdateOffCampusContactPhone().split("--")[1], dataOutputStudent.get(studentUpdate.getUpdateOffCampusContactPhone().split("--")[1]));
            }
            if (studentUpdate.getUpdateOffCampusContactName() != null) {
                singleData.put(studentUpdate.getUpdateOffCampusContactName().split("--")[1], dataOutputStudent.get(studentUpdate.getUpdateOffCampusContactName().split("--")[1]));
            }
            if (studentUpdate.getOtherHealthStatus() != null) {
                singleData.put(studentUpdate.getOtherHealthStatus().split("--")[1], dataOutputStudent.get(studentUpdate.getOtherHealthStatus().split("--")[1]));
            }
            if (studentUpdate.getPartyOrGroupOrganization() != null) {
                singleData.put(studentUpdate.getPartyOrGroupOrganization().split("--")[1], dataOutputStudent.get(studentUpdate.getPartyOrGroupOrganization().split("--")[1]));
            }
            if (studentUpdate.getPartyOrGroupOrganizationText() != null) {
                singleData.put(studentUpdate.getPartyOrGroupOrganizationText().split("--")[1], dataOutputStudent.get(studentUpdate.getPartyOrGroupOrganizationText().split("--")[1]));
            }
            if (studentUpdate.getFirst_time_medical_insurance() != null) {
                singleData.put(studentUpdate.getFirst_time_medical_insurance().split("--")[1], dataOutputStudent.get(studentUpdate.getFirst_time_medical_insurance().split("--")[1]));
            }
            if (studentUpdate.getSecond_time_medical_insurance() != null) {
                singleData.put(studentUpdate.getSecond_time_medical_insurance().split("--")[1], dataOutputStudent.get(studentUpdate.getSecond_time_medical_insurance().split("--")[1]));
            }
            if (studentUpdate.getThird_time_medical_insurance() != null) {
                singleData.put(studentUpdate.getThird_time_medical_insurance().split("--")[1], dataOutputStudent.get(studentUpdate.getThird_time_medical_insurance().split("--")[1]));
            }
            if (studentUpdate.getFirst_medical_insurance() != null) {
                singleData.put(studentUpdate.getFirst_medical_insurance().split("--")[1], dataOutputStudent.get(studentUpdate.getFirst_medical_insurance().split("--")[1]));
            }
            if (studentUpdate.getSecond_medical_insurance() != null) {
                singleData.put(studentUpdate.getSecond_medical_insurance().split("--")[1], dataOutputStudent.get(studentUpdate.getSecond_medical_insurance().split("--")[1]));
            }
            if (studentUpdate.getThird_medical_insurance() != null) {
                singleData.put(studentUpdate.getThird_medical_insurance().split("--")[1], dataOutputStudent.get(studentUpdate.getThird_medical_insurance().split("--")[1]));
            }
            if (studentUpdate.getPre_admissionOrReward() != null) {
                singleData.put(studentUpdate.getPre_admissionOrReward().split("--")[1], dataOutputStudent.get(studentUpdate.getPre_admissionOrReward().split("--")[1]));
            }
            if (studentUpdate.getPre_admissionOrRewardText() != null) {
                singleData.put(studentUpdate.getPre_admissionOrRewardText().split("--")[1], dataOutputStudent.get(studentUpdate.getPre_admissionOrRewardText().split("--")[1]));
            }

            exportedData.add(singleData);
        }
    }

}
