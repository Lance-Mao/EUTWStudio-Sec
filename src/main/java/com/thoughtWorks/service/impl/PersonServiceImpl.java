package com.thoughtWorks.service.impl;

import com.thoughtWorks.dao.DepartmentDao;
import com.thoughtWorks.dao.PersonDao;
import com.thoughtWorks.dao.TrainModuleDao;
import com.thoughtWorks.dto.SearchDto;
import com.thoughtWorks.entity.*;
import com.thoughtWorks.service.PersonService;
import com.thoughtWorks.util.Constant;
import com.thoughtWorks.util.DateUtil;
import com.thoughtWorks.util.PageUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

@Service
public class PersonServiceImpl implements PersonService {
    @Resource
    private PersonDao personDao;
    @Resource
    private TrainModuleDao trainModuleDao;
    @Resource
    private DepartmentDao departmentDao;

    @Override
    public List<Map<String, String>> queryTeachersList(PageUtil page) throws Exception {
        Map<String, Object> data = new HashMap<>();
        data.put("start", (page.getCurrentIndex() - 1) * page.getPageSize());
        data.put("end", page.getPageSize());
        page.setTotalSize(personDao.queryPersonTotalCount());

        return personDao.queryPersonList(data);
    }

    @Override
    public void addTeacher(Teacher teacher, String classIds, String floorIds, int areaId) throws Exception {
        List<String> ids;
        int roleId = 0;
        if (teacher.getClassify().equals("3")) {
            teacher.setClassify("社区辅导员");
            teacher.setDepartmentId("0");
            teacher.setDirectionId("0");
            teacher.setDeptId(0);
            roleId = 0;
            personDao.addTeacher(teacher);

        } else {
            if (teacher.getClassify().equals("1")) {
                teacher.setClassify("职业导师");
                ids = Arrays.asList(classIds.split(","));
                teacher.setDeptId(0);
                roleId = 0;
                if (ids.size() != 0) trainModuleDao.updateClassTeacher(teacher.getNo(), ids);
            } else if (teacher.getClassify().equals("2")) {
                teacher.setClassify("行政");
                teacher.setDepartmentId("0");
                teacher.setDirectionId("0");
                roleId = 0;
            }
            personDao.addTeacher(teacher);
        }
        String str = teacher.getIdentityCard();
        if (str.length() >= 6) {
            teacher.setIdentityCard(str.substring(str.length() - 6));
        }
        personDao.addTeacherToUser(teacher, roleId);


    }

    @Override
    public void updateTeacher(Teacher teacher, String classIds, String floorIds, int areaId) throws Exception {
        List<String> ids;
        if (teacher.getClassify().equals("职业导师")) {
            ids = Arrays.asList(classIds.split(","));
            trainModuleDao.deleteTeacherAllClassesId(teacher.getNo());
            if (ids.size() != 0) trainModuleDao.updateClassTeacher(teacher.getNo(), ids);
        } else if (teacher.getClassify().equals("行政")) {
            teacher.setDepartmentId("0");
            teacher.setDirectionId("0");
        } else {
            teacher.setDepartmentId("0");
            teacher.setDirectionId("0");
            trainModuleDao.deleteTeacherCommunityAllClassesId(teacher.getNo());
        }
        personDao.updateTeacher(teacher);
    }

    @Override
    public void deleteTeacherById(String id) throws Exception {
        personDao.deleteTeacherById(id);
        trainModuleDao.deleteTeacherAllClassesId(id);
        personDao.deleteUserByTeacherId(id);
    }

    @Override
    public Map<String, Object> queryStudentsByLikesAdmin(SearchDto searchDto) throws Exception {
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> data = new HashMap<>();
        data.put("professionId", searchDto.getProfessionId());
        data.put("directionId", searchDto.getDirectionId());
        data.put("classesId", searchDto.getClassesId());
        data.put("level", searchDto.getLevel());
        data.put("studentNo", searchDto.getStudentNo() + "%");
        data.put("name", "%" + searchDto.getName() + "%");
        List<Map<String, String>> students = personDao.queryStudentsByLikesAdmin(data);

        result.put("studentClass", students);

        return result;
    }

    @Override
    public List<Map<String, String>> queryStudentsAwardOrPunishmentList(String studentNo) throws Exception {
        return personDao.queryStudentsAwardOrPunishmentList(studentNo);
    }

    @Override
    public void addAwardOrPunishmentByUpdate(OwnOrPunishment ownOrPunishment) throws Exception {
        personDao.addAwardOrPunishmentByUpdate(ownOrPunishment);
    }

    @Override
    public List<Map<String, Object>> showAutoProfessionListByDepartment(String departmentId) throws Exception {
        return personDao.showAutoProfessionListByDepartment(departmentId);
    }

    @Override
    public List<Map<String, Object>> showAutoDirectionListByDepartment(String departmentId) throws Exception {
        return personDao.showAutoDirectionListByDepartment(departmentId);
    }

    @Override
    public List<Map<String, String>> queryAllStudentsProfessionList() throws Exception {
        return personDao.queryAllStudentsProfessionList();
    }

    @Override
    public List<Map<String, Object>> queryDirectionSelectionClass(String directionId) throws Exception {
        return personDao.queryDirectionSelectionClass(directionId);
    }

    @Override
    public List<Map<String, Object>> querylevelSelectionClass(String levelName) throws Exception {
        return personDao.querylevelSelectionClass(levelName);
    }

    @Override
    public void delAward(String id) throws Exception {
        personDao.delAward(id);
    }

    @Override
    public List<Map<String, Object>> queryDisciplineAndPunishment(String studentNo) throws Exception {
        return personDao.queryDisciplineAndPunishment(studentNo);
    }

    @Override
    public List<Map<String, Object>> queryGroupActivitiesList(String studentNo) throws Exception {
        return personDao.queryGroupActivitiesList(studentNo);
    }

    @Override
    public void addDisciplineAndPunishmentByUpdate(DisciplineAndPunishmen disciplineAndPunishmen) throws Exception {
        personDao.addDisciplineAndPunishmentByUpdate(disciplineAndPunishmen);
    }

    @Override
    public void delDisciplineAndPunishment(String id) throws Exception {
        personDao.delDisciplineAndPunishment(id);
    }

    @Override
    public void addGroupActivitiesByUpdate(GroupActivities groupActivities) throws Exception {
        personDao.addGroupActivitiesByUpdate(groupActivities);
    }

    @Override
    public void delGroupActivities(String id) throws Exception {
        personDao.delGroupActivities(id);
    }

    @Override
    public void updateGroupActivitiesInfo(List<Map<String, Object>> groupActivitiesList)throws Exception {
        personDao.updateGroupActivitiesInfo(groupActivitiesList);
    }

    @Override
    public void updateDisciplineAndPunishmentInfo(List<Map<String, Object>> disciplineAndPunishmentList) throws Exception {
        personDao.updateDisciplineAndPunishmentInfo(disciplineAndPunishmentList);
    }

    @Override
    public void updateAwardOrPunishmentInfo(List<Map<String, Object>> awardOrPunishmentList) throws Exception {
        personDao.updateAwardOrPunishmentInfo(awardOrPunishmentList);
    }

    @Override
    public void revokeDisciplineAndPunishment(String id,String revokeDiscipline) throws Exception {
        personDao.revokeDisciplineAndPunishment(id,revokeDiscipline);
    }

    @Override
    public Map<String, Object> queryStudentsByLikes(ActiveUser user, SearchDto searchDto) throws Exception {
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> data = new HashMap<>();
        data.put("no", user.getUserName());
        data.put("professionId", searchDto.getProfessionId());
        data.put("directionId", searchDto.getDirectionId());
        data.put("level", searchDto.getLevel());
        data.put("classesId", searchDto.getClassesId());
        data.put("studentNo", searchDto.getStudentNo() + "%");
        data.put("name", "%" + searchDto.getName() + "%");

        List<Map<String, String>> students = personDao.queryStudentsByLikes(data);
        Map<String, String> teacher = personDao.queryTeacherByNo(user.getUserName());

        result.put("studentClass", students);

        return result;
    }

    @Override
    public List<Classes> loadTeacherHasClassess(String no) throws Exception {
        return trainModuleDao.loadTeacherHasClassess(no);
    }

    @Override
    public void distributedClass(String classesId, String studentIds) throws Exception {
        List<String> ids = Arrays.asList(studentIds.split(","));
        if (ids.size() != 0) personDao.distributedClass(classesId, ids);
    }

    @Override
    public void distributedDirection(String directionId, String studentIds) throws Exception {
        List<String> ids = Arrays.asList(studentIds.split(","));
        if (ids.size() != 0) personDao.distributeDirection(directionId, ids);
    }

    @Override
    public List<Map<String, Object>> queryAllDept(PageUtil pageUtil) throws Exception {
        Map<String, Object> data = new HashMap<>();
        data.put("start", (pageUtil.getCurrentIndex() - 1) * pageUtil.getPageSize());
        data.put("pageSize", pageUtil.getPageSize());
        pageUtil.setTotalSize(personDao.queryDeptTotalCount());
        return personDao.queryAllDept(data);
    }

    @Override
    public void addDept(String name) throws Exception {
        personDao.addDept(name);
    }

    @Override
    public void updateDept(String name, String id) throws Exception {
        Map<String, Object> data = new HashMap<>();
        data.put("id", id);
        data.put("name", name);
        personDao.updateDept(data);
    }

    @Override
    public void deleteDept(String id) throws Exception {
        personDao.deleteDept(id);
    }

    @Override
    public List<Map<String, String>> queryStudentsByTeacherHasClasses(SearchDto searchDto, PageUtil page) throws Exception {
        Map<String, Object> data = new HashMap<>();
        searchDto.setStudentNo("%" + searchDto.getStudentNo() + "%");
        searchDto.setName("%" + searchDto.getName() + "%");
        data.put("start", (page.getCurrentIndex() - 1) * page.getPageSize());
        data.put("pageSize", page.getPageSize());
        data.put("searchDto", searchDto);
        page.setTotalSize(personDao.queryStudentsCount(searchDto));
        return personDao.queryStudentsByClassesIdsAndLikeName(data);
    }

    @Override
    public Student queryStudentByNo(String stuNo) throws Exception {
        return personDao.queryStudentByNo(stuNo);
    }

    @Override
    public void addCommunication(CommunicationContent communicationContent) throws Exception {
        communicationContent.setTime(new Date());

        personDao.addCommunication(communicationContent);
    }

    @Override
    public List<Map<String, Object>> queryCommunicationByStudentId(String studentNo) throws Exception {
        List<Map<String, Object>> communications = personDao.queryCommunicationByStudentId(studentNo);
        for (Map<String, Object> communication : communications) {
            String content = communication.get("content") + "";
            communication.put("contents", content.split(Constant.SPLIT_TAG));
            String time = ((Date) communication.get("time")).toString();
            communication.put("time", time.substring(0, time.length() - 2));
        }

        return communications;
    }

    @Override
    public void updateCommunicationContent(CommunicationContent communicationContent) throws Exception {
        personDao.updateCommunicationContent(communicationContent);
    }

    @Override
    public Teacher queryUserById(String no) throws Exception {
        return personDao.queryUserById(no);
    }

    @Override
    public List<Direction> queryDirectionByDepartmentId(int departmentId) throws Exception {

        return personDao.queryDirectionByDepartmentId(departmentId);
    }

    @Override
    public List<Direction> queryDirectionByDepartment() throws Exception {

        return personDao.queryDirectionByDepartment();
    }

    @Override
    public List<Classes> queryClass() throws Exception {

        return personDao.queryClass();
    }

    @Override
    public List<Classes> queryClassByDepartmentId(int departmentId) throws Exception {

        return personDao.queryClassByDepartmentId(departmentId);
    }

    @Override
    public List<Map<String, Object>> queryStudentInfoById(String studentNo) throws Exception {

        return personDao.queryStudentInfoById(studentNo);
    }

    @Override
    public List<Map<String, Object>> queryStudentList(SearchDto searchDto, PageUtil page) throws Exception {
        Map<String, Object> data = new HashMap<>();
        searchDto.setStudentNo("%" + searchDto.getStudentNo() + "%");
        searchDto.setName("%" + searchDto.getName() + "%");
        searchDto.setRoomId("%" + searchDto.getRoomId() + "%");
        if (searchDto.getSex() == null) {
            searchDto.setSex("%" + "%");
        } else {
            searchDto.setSex("%" + searchDto.getSex() + "%");
        }

        if (searchDto.getTypeOfAccommodation() == null) {
            searchDto.setTypeOfAccommodation("");
        } else {
            searchDto.setTypeOfAccommodation(searchDto.getTypeOfAccommodation());
        }
        data.put("start", (page.getCurrentIndex() - 1) * page.getPageSize());
        data.put("pageSize", page.getPageSize());
        data.put("searchDto", searchDto);

        page.setTotalSize(personDao.queryStudentsListCount(searchDto));
        return personDao.queryStudentList(data);

    }

    @Override
    public Map<String, Object> updateByStudentNo(String studentNo) throws Exception {
        Map<String, Object> data = new HashMap<>();

        data.put("student", personDao.updateByStudentNo(studentNo));
        data.put("family", personDao.updateFamilyByStudentNo(studentNo));
        data.put("experience", personDao.updateExperienceByStudentNo(studentNo));
        data.put("ownPunishment", personDao.queryOwnPunishmentByStudentNo(studentNo));
        data.put("disciplineAndPunishment", personDao.queryDisciplineAndPunishmentByStudentNo(studentNo));
        data.put("groupActivities", personDao.queryGroupActivitiesByStudentNo(studentNo));
        return data;
    }

    @Override
    public Map<String, Object> queryStudentsToUpdate(String studentNo) throws Exception {
        return personDao.queryStudentsToUpdate(studentNo);
    }

    @Override
    public List<Map<String, Object>> queryStudentFamily(String studentNo) throws Exception {
        return personDao.queryStudentFamily(studentNo);
    }

    @Override
    public List<Map<String, String>> queryStudentsProfessionList(String departmentId) throws Exception {
        return personDao.queryStudentsProfessionList(departmentId);
    }

    @Override
    public List<Map<String, String>> queryStudentsDirection(String departmentId) throws Exception {
        return personDao.queryStudentsDirection(departmentId);
    }

    @Override
    public List<Map<String, Object>> queryStudentsClassList(String searchLevel) throws Exception {
        return personDao.queryStudentsClassList(searchLevel);
    }

    @Override
    public List<Map<String, Object>> queryStudentExperienceList(String studentNo) throws Exception {
        return personDao.queryStudentExperienceList(studentNo);
    }
    @Override
    public List<Map<String, Object>> queryStudentScholarshipsList(String studentNo) throws Exception {
        return personDao.queryStudentScholarshipsList(studentNo);
    }

    @Override
    public List<Map<String, Object>> queryTeacherCommunity(String no) throws Exception {

        return personDao.queryTeacherCommunity(no);
    }

    @Override
    public void updateStudentTeacherId(String teacherId, String studentIds) throws Exception {
        List<String> ids = Arrays.asList(studentIds.split(","));
        if (ids.size() != 0) personDao.updateStudentTeacherId(teacherId, ids);
    }

    public List<Map<String, Object>> teacherCommunity(String no) throws Exception {

        return personDao.teacherCommunity(no);
    }

    @Override
    public List<Map<String, Object>> teacherCommunity_floors(String no) throws Exception {

        return personDao.teacherCommunity_floors(no);
    }

    @Override
    public List<Map<String, Object>> queryTeacherList() throws Exception {
        return personDao.queryTeacherList();
    }

    @Override
    public void updateStudentList(StudentUpdate studentUpdate) throws Exception {
        personDao.updateStudentList(studentUpdate);
    }

    @Override
    public void updateExperienceList(List<Map<String, Object>> experiences) throws Exception {
        personDao.updateExperienceList(experiences);
    }


    @Override
    public void addFamilyByUpdate(StudentFamily studentFamily) throws Exception {
        personDao.addFamilyByUpdate(studentFamily);
    }

    @Override
    public void updateFamilyInfo(List<Map<String, Object>> familyList) {
        personDao.updateFamilyInfo(familyList);
    }

    @Override
    public void delStudentFamily(String familyId) throws Exception {
        personDao.delStudentFamily(familyId);
    }

    @Override
    public void delExperience(String experienceId) throws Exception {
        personDao.delExperience(experienceId);
    }

    @Override
    public void addExperienceByUpdate(Experience experience) throws Exception {
        personDao.addExperienceByUpdate(experience);
    }

    @Override
    public Map<String, String> queryFamousFamily(String famousFamily) throws Exception {
        return personDao.queryFamousFamily(famousFamily);
    }

    @Override
    public List<Map<String, Object>> queryDepartmentList() throws Exception {
        return personDao.queryDepartmentList();
    }

    @Override
    public List<Map<String, Object>> showAutoClassByDepartment(String departmentId,String searchLevel) throws Exception {
        return personDao.showAutoClassByDepartment(departmentId,searchLevel);
    }

    @Override
    public String queryStudentNameByStudentNo(String studentNo) throws Exception {
        return personDao.queryStudentNameByStudentNo(studentNo);
    }

    @Override
    public List<Map<String, Object>> queryFamousFamilyList() throws Exception {
        return personDao.queryFamousFamilyList();
    }
}