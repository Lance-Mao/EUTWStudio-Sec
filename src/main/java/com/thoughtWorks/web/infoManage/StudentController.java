package com.thoughtWorks.web.infoManage;

import com.thoughtWorks.dto.Result;
import com.thoughtWorks.dto.SearchDto;
import com.thoughtWorks.entity.*;
import com.thoughtWorks.service.PersonService;
import com.thoughtWorks.service.StudentDataOutputService;
import com.thoughtWorks.util.Constant;
import com.thoughtWorks.util.ImgUtil;
import com.thoughtWorks.util.PageUtil;
import com.thoughtWorks.web.UpdateStudentUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Component
@RequestMapping("/student")
public class StudentController {

    @Autowired
    private PersonService personService;
    @Autowired
    private StudentDataOutputService studentDataOutputService;
    @Autowired
    private UpdateStudentUtil updateStudentUtil;

    @RequestMapping()
    public String index() {
        return "infoManage/student/list";
    }

    @RequestMapping("/list")
    @ResponseBody
    public Map<String, Object> list(PageUtil page, SearchDto searchDto) {
        Map<String, Object> data = new HashMap<>();
        try {
            List<Map<String, String>> allProfessionList = personService.queryAllStudentsProfessionList();
            List<Map<String, Object>> student = personService.queryStudentList(searchDto, page);
            data.put("student", student);
            data.put("allProfessionList", allProfessionList);
            data.put("msg", Constant.SEARCH_SUCCESS);
            data.put("page", page);
            data.put("result", true);

        } catch (Exception e) {
            e.printStackTrace();
            data.put("msg", Constant.SEARCH_FAILURE);
            data.put("result", false);
        }

        return data;
    }

    @RequestMapping("/queryProfessionByDepartment")
    @ResponseBody
    public Map<String, Object> queryProfessionByDepartment() {
        try {
            Map<String, Object> data = new HashMap<>();
            List<Map<String, String>> allProfessionList = personService.queryAllStudentsProfessionList();
            data.put("allProfessionList", allProfessionList);
            return data;
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    @RequestMapping("/update")
    @ResponseBody
    public Map<String, Object> update(String studentNo) {
        Map<String, Object> data = new HashMap<>();
        try {

            data.putAll(personService.updateByStudentNo(studentNo));
            data.put("result", true);
            data.put("msg", Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            new RuntimeException(e);
            data.put("msg", Constant.SEARCH_FAILURE);
            data.put("result", false);
        }
        return data;
    }

    @RequestMapping("/studentUpdate")
    @ResponseBody
    public Map<String, Object> studentUpdate(String studentNo,String searchLevel) {
        Map<String, Object> data = new HashMap<>();
        try {
            Map<String, Object> students = personService.queryStudentsToUpdate(studentNo);
            List<Map<String, Object>> students_family = personService.queryStudentFamily(studentNo);
            List<Map<String, String>> professionList = personService.queryStudentsProfessionList((String) students.get("department_id"));
            List<Map<String, String>> allProfessionList = personService.queryAllStudentsProfessionList();
            List<Map<String, String>> AwardOrPunishmentList = personService.queryStudentsAwardOrPunishmentList(studentNo);
            List<Map<String, String>> directionList = personService.queryStudentsDirection((String) students.get("department_id"));
            List<Map<String, Object>> classesList = personService.queryStudentsClassList(searchLevel);
            List<Map<String, Object>> experienceList = personService.queryStudentExperienceList(studentNo);
            List<Map<String, Object>> teacherList = personService.queryTeacherList();
            List<Map<String, Object>> departmentList = personService.queryDepartmentList();
            List<Map<String, Object>> famousFamilyList = personService.queryFamousFamilyList();
            List<Map<String, Object>> disciplineAndPunishmentList = personService.queryDisciplineAndPunishment(studentNo);
            List<Map<String, Object>> groupActivitiesList = personService.queryGroupActivitiesList(studentNo);
            String famousFamily = (String) students.get("famous_family");
            Map<String, String> famousFamilyFoUpdate = personService.queryFamousFamily(famousFamily);
            data.put("students", students);
            data.put("students_family", students_family);
            data.put("professionList", professionList);
            data.put("allProfessionList", allProfessionList);
            data.put("directionList", directionList);
            data.put("classesList", classesList);
            data.put("AwardOrPunishmentList", AwardOrPunishmentList);
            data.put("experienceList", experienceList);
            data.put("teacherList", teacherList);
            data.put("famousFamily", famousFamilyFoUpdate);
            data.put("departmentList", departmentList);
            data.put("famousFamilyList", famousFamilyList);
            data.put("disciplineAndPunishmentList", disciplineAndPunishmentList);
            data.put("groupActivitiesList", groupActivitiesList);
            data.put("msg", Constant.SEARCH_SUCCESS);
            data.put("result", true);


        } catch (Exception e) {
            data.put("msg", Constant.SEARCH_FAILURE);
            data.put("result", false);
            e.printStackTrace();
        }

        return data;
    }

    @RequestMapping("/updateStudentAjax")
    @ResponseBody()
    public Result updateStudentAjax(StudentUpdate studentUpdate,
                                    int familyInfoCount,
                                    @RequestParam(value = "educational_experience_start_list[]", required = false, defaultValue = "") List educational_experience_start_list,
                                    @RequestParam(value = "educational_experience_end_list[]", required = false, defaultValue = "") List educational_experience_end_list,
                                    @RequestParam(value = "update_schoolName_list[]", required = false, defaultValue = "") List update_schoolName_list,
                                    @RequestParam(value = "update_duties_start_list[]", required = false, defaultValue = "") List update_duties_start_list,
                                    @RequestParam(value = "experienceIds[]", required = false, defaultValue = "") List experienceIds,
                                    @RequestParam(value = "updateStudentParentsNameList[]", required = false, defaultValue = "") List updateStudentParentsNameList,
                                    @RequestParam(value = "updateStudentParent_political_statusList[]", required = false, defaultValue = "") List updateStudentParent_political_statusList,
                                    @RequestParam(value = "updateStudentParent_employerList[]", required = false, defaultValue = "") List updateStudentParent_employerList,
                                    @RequestParam(value = "updateStudentParent_dutiesList[]", required = false, defaultValue = "") List updateStudentParent_dutiesList,
                                    @RequestParam(value = "updateStudentParentIds[]", required = false, defaultValue = "") List updateStudentParentIds,
                                    @RequestParam(value = "updateStudentParent_phoneList[]", required = false, defaultValue = "") List updateStudentParent_phoneList,
                                    @RequestParam(value = "updateStudent_groupActivities_date_list[]", required = false, defaultValue = "") List updateStudent_groupActivities_date_list,
                                    @RequestParam(value = "updateStudent_groupActivities_id_list[]", required = false, defaultValue = "") List updateStudent_groupActivities_id_list,
                                    @RequestParam(value = "updateStudent_disciplineAndPunishment_date_list[]", required = false, defaultValue = "") List updateStudent_disciplineAndPunishment_date_list,
                                    @RequestParam(value = "updateStudent_disciplineAndPunishment_id_list[]", required = false, defaultValue = "") List updateStudent_disciplineAndPunishment_id_list,
                                    @RequestParam(value = "updateStudent_Award_or_punishment_date_list[]", required = false, defaultValue = "") List updateStudent_Award_or_punishment_date_list,
                                    @RequestParam(value = "updateStudent_Award_or_punishment_content_list[]", required = false, defaultValue = "") List updateStudent_Award_or_punishment_content_list,
                                    @RequestParam(value = "updateStudent_Award_or_punishment_id_list[]", required = false, defaultValue = "") List updateStudent_Award_or_punishment_id_list) {

        try {
            //教育经历
            List<Map<String, Object>> experiences = new ArrayList<>();
            for (int i = 0; i < educational_experience_start_list.size(); i++) {
                Map<String, Object> experience = new HashMap<>();
                experience.put("educational_experience_start_list", educational_experience_start_list.get(i));
                experience.put("educational_experience_end_list", educational_experience_end_list.get(i));
                experience.put("update_schoolName_list", update_schoolName_list.get(i));
                experience.put("update_duties_start_list", update_duties_start_list.get(i));
                experience.put("experienceIds", experienceIds.get(i));
                experiences.add(experience);
            }

            personService.updateStudentList(studentUpdate);
            if (null != experiences && experiences.size() != 0) {
                personService.updateExperienceList(experiences);
            }

            //家庭成员信息
            List<Map<String, Object>> familyList = new ArrayList<>();
            for (int i = 0; i < familyInfoCount; i++) {
                Map<String, Object> family = new HashMap<>();
                family.put("updateStudentParentsNameList", updateStudentParentsNameList.get(i));
                family.put("updateStudentParent_political_statusList", updateStudentParent_political_statusList.get(i));
                family.put("updateStudentParent_employerList", updateStudentParent_employerList.get(i));
                family.put("updateStudentParent_dutiesList", updateStudentParent_dutiesList.get(i));
                family.put("updateStudentParent_phoneList", updateStudentParent_phoneList.get(i));
                family.put("updateStudentParentIds", updateStudentParentIds.get(i));
                familyList.add(family);
            }
            if (null != familyList && familyList.size() != 0) {
                personService.updateFamilyInfo(familyList);
            }
            //荣誉与获奖
            List<Map<String, Object>> awardOrPunishmentList = new ArrayList<>();
            for (int i = 0; i < updateStudent_Award_or_punishment_id_list.size(); i++) {
                Map<String, Object> awardOrPunishment = new HashMap<>();
                awardOrPunishment.put("updateStudent_Award_or_punishment_date_list", updateStudent_Award_or_punishment_date_list.get(i));
                awardOrPunishment.put("updateStudent_Award_or_punishment_content_list", updateStudent_Award_or_punishment_content_list.get(i));
                awardOrPunishment.put("updateStudent_Award_or_punishment_id_list", updateStudent_Award_or_punishment_id_list.get(i));
                awardOrPunishmentList.add(awardOrPunishment);
            }
            if (null != awardOrPunishmentList && awardOrPunishmentList.size() != 0) {
                personService.updateAwardOrPunishmentInfo(awardOrPunishmentList);
            }
            //违纪与处分
            List<Map<String, Object>> disciplineAndPunishmentList = new ArrayList<>();
            for (int i = 0; i < updateStudent_disciplineAndPunishment_id_list.size(); i++) {
                Map<String, Object> disciplineAndPunishment = new HashMap<>();
                disciplineAndPunishment.put("updateStudent_disciplineAndPunishment_date_list", updateStudent_disciplineAndPunishment_date_list.get(i));
                disciplineAndPunishment.put("updateStudent_disciplineAndPunishment_id_list", updateStudent_disciplineAndPunishment_id_list.get(i));
                disciplineAndPunishmentList.add(disciplineAndPunishment);
            }
            if (null != disciplineAndPunishmentList && disciplineAndPunishmentList.size() != 0) {
                personService.updateDisciplineAndPunishmentInfo(disciplineAndPunishmentList);
            }
            //团学活动
            List<Map<String, Object>> groupActivitiesList = new ArrayList<>();
            for (int i = 0; i < updateStudent_groupActivities_id_list.size(); i++) {
                Map<String, Object> groupActivities = new HashMap<>();
                groupActivities.put("updateStudent_groupActivities_date_list", updateStudent_groupActivities_date_list.get(i));
                groupActivities.put("updateStudent_groupActivities_id_list", updateStudent_groupActivities_id_list.get(i));
                groupActivitiesList.add(groupActivities);
            }
            if (null != groupActivitiesList && groupActivitiesList.size() != 0) {
                personService.updateGroupActivitiesInfo(groupActivitiesList);
            }
            //添加修改日志到沟通反馈页面
//            CommunicationContent content = new CommunicationContent(studentUpdate.getNo(), personService.queryStudentNameByStudentNo(studentUpdate.getNo()), "基本信息");
//            updateStudentUtil.updateStudentToCommunication(content);
            return Result.success(null, Constant.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Result.failure(null, Constant.UPDATE_FAILURE);
    }

    @RequestMapping("/updateImage")
    @ResponseBody
    public Result updateImage(MultipartFile file, HttpServletRequest request) {
        try {
            String imgPath = ImgUtil.saveImg(file, request.getServletContext().getRealPath("/images") + Constant.USER_IMAGE_PATH);
            String imgName = imgPath.substring(imgPath.lastIndexOf("/"));

            return Result.success(imgName, Constant.UPLOAD_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.UPDATE_FAILURE);
    }

    @RequestMapping("/addFamilyByUpdate")
    @ResponseBody
    public Result addFamilyByUpdate(StudentFamily studentFamily, String studentNo) {
        try {
            personService.addFamilyByUpdate(studentFamily);
            List<Map<String, Object>> students_family = personService.queryStudentFamily(studentNo);
            return Result.success(students_family, Constant.ADD_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.ADD_FAILURE);
    }

    @RequestMapping("/delStudentFamily")
    @ResponseBody
    public Result delStudentFamily(String familyId, String studentNo) {
        try {
            personService.delStudentFamily(familyId);
            List<Map<String, Object>> students_family = personService.queryStudentFamily(studentNo);
            return Result.success(students_family, Constant.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.DELETE_FAILURE);
    }

    @RequestMapping("/delExperience")
    @ResponseBody
    public Result delExperience(String experienceId, String studentNo) {
        try {
            personService.delExperience(experienceId);
            List<Map<String, Object>> experienceList = personService.queryStudentExperienceList(studentNo);

            return Result.success(experienceList, Constant.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.DELETE_FAILURE);
    }

    @RequestMapping("/delAward")
    @ResponseBody
    public Result delAward(String id, String studentNo) {
        try {
            personService.delAward(id);

            return Result.success(null, Constant.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.DELETE_FAILURE);
    }

    @RequestMapping("/addExperienceByUpdate")
    @ResponseBody
    public Result addExperienceByUpdate(Experience experience) {
        try {
            personService.addExperienceByUpdate(experience);
            List<Map<String, Object>> experienceList = personService.queryStudentExperienceList(experience.getNo());

            return Result.success(experienceList, Constant.ADD_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.ADD_FAILURE);
    }

    @RequestMapping("/showAutoClassAndProAndDirByDepartment")
    @ResponseBody
    public Result showAutoClassAndProAndDirByDepartment(String departmentId,String searchLevel) {
        try {
            List<Map<String, Object>> classesList = personService.showAutoClassByDepartment(departmentId,searchLevel);
            List<Map<String, Object>> professionList = personService.showAutoProfessionListByDepartment(departmentId);
            List<Map<String, Object>> directionList = personService.showAutoDirectionListByDepartment(departmentId);

            Map<String, Object> data = new HashMap<>();
            data.put("classesList", classesList);
            data.put("professionList", professionList);
            data.put("directionList", directionList);

            return Result.success(data, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return Result.failure(null, Constant.SEARCH_FAILURE);
    }

    @RequestMapping("/addAwardOrPunishmentByUpdate")
    @ResponseBody
    public Result addAwardOrPunishmentByUpdate(OwnOrPunishment ownOrPunishment) {
        try {
            personService.addAwardOrPunishmentByUpdate(ownOrPunishment);
            List<Map<String, String>> AwardOrPunishmentList = personService.queryStudentsAwardOrPunishmentList(ownOrPunishment.getStudentNo());

            return Result.success(AwardOrPunishmentList, Constant.ADD_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.ADD_FAILURE);
    }

    @RequestMapping("/showTeacherOfSearch")
    @ResponseBody
    public Map<String, Object> showTeacherOfSearch() {
        try {
            Map<String, Object> data = new HashMap<>();
            List<Map<String, Object>> teacherList = personService.queryTeacherList();
            data.put("teacherList", teacherList);

            return data;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @RequestMapping("/directionSelectionClass")
    @ResponseBody
    public Map<String, Object> directionSelectionClass(String directionId) {
        try {
            Map<String, Object> data = new HashMap<>();
            List<Map<String, Object>> classList = personService.queryDirectionSelectionClass(directionId);
            data.put("classList", classList);

            return data;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @RequestMapping("/levelSelectionClass")
    @ResponseBody
    public Map<String, Object> levelSelectionClass(String levelName) {
        try {
            Map<String, Object> data = new HashMap<>();
            List<Map<String, Object>> classList = personService.querylevelSelectionClass(levelName);
            data.put("classList", classList);

            return data;
        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }

    @RequestMapping("/addDisciplineAndPunishmentByUpdate")
    @ResponseBody
    public Result addDisciplineAndPunishmentByUpdate(DisciplineAndPunishmen disciplineAndPunishmen) {
        try {
            personService.addDisciplineAndPunishmentByUpdate(disciplineAndPunishmen);
            List<Map<String,Object>> disciplineAndPunishmentList = personService.queryDisciplineAndPunishment(disciplineAndPunishmen.getStudentNo());

            return Result.success(disciplineAndPunishmentList,Constant.ADD_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.ADD_FAILURE);
    }
    @RequestMapping("/addGroupActivitiesByUpdate")
    @ResponseBody
    public Result addGroupActivitiesByUpdate(GroupActivities groupActivities) {
        try {
            personService.addGroupActivitiesByUpdate(groupActivities);
            List<Map<String,Object>> groupActivitiesList = personService.queryGroupActivitiesList(groupActivities.getStudentNo());

            return Result.success(groupActivitiesList,Constant.ADD_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.ADD_FAILURE);
    }

    @RequestMapping("/delDisciplineAndPunishment")
    @ResponseBody
    public Result delDisciplineAndPunishment(String id, String studentNo) {
        try {
            personService.delDisciplineAndPunishment(id);

            return Result.success(null, Constant.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.DELETE_FAILURE);
    }

    @RequestMapping("/delGroupActivities")
    @ResponseBody
    public Result delGroupActivities(String id, String studentNo) {
        try {
            personService.delGroupActivities(id);

            return Result.success(null, Constant.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.DELETE_FAILURE);
    }

    @RequestMapping("/revokeDisciplineAndPunishment")
    @ResponseBody
    public Result revokeDisciplineAndPunishment(String id, String revokeDiscipline) {
        try {
            personService.revokeDisciplineAndPunishment(id,revokeDiscipline);

            return Result.success(null, Constant.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.DELETE_FAILURE);
    }

}
