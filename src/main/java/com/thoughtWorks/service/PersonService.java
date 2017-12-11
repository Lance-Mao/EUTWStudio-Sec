package com.thoughtWorks.service;

import com.thoughtWorks.dto.SearchDto;
import com.thoughtWorks.entity.*;
import com.thoughtWorks.util.PageUtil;

import java.util.List;
import java.util.Map;

public interface PersonService {


    List<Map<String, String>> queryTeachersList(PageUtil page) throws Exception;

    void addTeacher(Teacher teacher, String classIds, String floorIds, int areaId) throws Exception;

    void updateTeacher(Teacher teacher, String classIds, String floorIds, int areaId) throws Exception;

    void deleteTeacherById(String id) throws Exception;

    Map<String, Object> queryStudentsByLikes(ActiveUser user, SearchDto searchDto) throws Exception;

    List<Classes> loadTeacherHasClassess(String no) throws Exception;

    void distributedClass(String classesId, String studentIds) throws Exception;

    List<Map<String, String>> queryStudentsByTeacherHasClasses(SearchDto searchDto, PageUtil page) throws Exception;

    Student queryStudentByNo(String stuNo) throws Exception;

    void addCommunication(CommunicationContent communicationContent) throws Exception;

    List<Map<String, Object>> queryCommunicationByStudentId(String studentNo) throws Exception;

    void updateCommunicationContent(CommunicationContent communicationContent) throws Exception;

    void distributedDirection(String directionId, String studentIds) throws Exception;

    List<Map<String, Object>> queryAllDept(PageUtil pageUtil) throws Exception;

    void addDept(String name) throws Exception;

    void updateDept(String name, String id) throws Exception;

    void deleteDept(String id) throws Exception;

    Teacher queryUserById(String no) throws Exception;

    List<Direction> queryDirectionByDepartmentId(int departmentId) throws Exception;

    List<Direction> queryDirectionByDepartment() throws Exception;

    List<Classes> queryClass() throws Exception;

    List<Classes> queryClassByDepartmentId(int departmentId) throws Exception;

    List<Map<String, Object>> queryStudentInfoById(String studentNo) throws Exception;

    List<Map<String, Object>> queryStudentList(SearchDto searchDto, PageUtil page) throws Exception;

    Map<String, Object> updateByStudentNo(String studentNo) throws Exception;

    Map<String, Object> queryStudentsToUpdate(String studentNo) throws Exception;

    List<Map<String, Object>> queryStudentFamily(String studentNo) throws Exception;

    List<Map<String, String>> queryStudentsProfessionList(String departmentId) throws Exception;

    List<Map<String, String>> queryStudentsDirection(String departmentId) throws Exception;

    List<Map<String, Object>> queryStudentsClassList(String searchLevel) throws Exception;

    List<Map<String, Object>> queryStudentExperienceList(String studentNo) throws Exception;

    List<Map<String, Object>> queryStudentScholarshipsList(String studentNo) throws Exception;


    List<Map<String, Object>> queryTeacherCommunity(String no) throws Exception;


    void updateStudentTeacherId(String teacherId, String studentIds) throws Exception;

    List<Map<String, Object>> teacherCommunity(String no) throws Exception;

    List<Map<String, Object>> teacherCommunity_floors(String no) throws Exception;

    List<Map<String, Object>> queryTeacherList() throws Exception;

    void updateStudentList(StudentUpdate studentUpdate) throws Exception;

    void updateExperienceList(List<Map<String, Object>> experiences) throws Exception;

    void addFamilyByUpdate(StudentFamily studentFamily) throws Exception;

    void updateFamilyInfo(List<Map<String, Object>> familyList);

    void delStudentFamily(String familyId) throws Exception;

    void delExperience(String experienceId) throws Exception;

    void addExperienceByUpdate(Experience experience) throws Exception;

    Map<String, String> queryFamousFamily(String famousFamily) throws Exception;

    List<Map<String, Object>> queryDepartmentList() throws Exception;

    List<Map<String, Object>> showAutoClassByDepartment(String departmentId,String searchLevel) throws Exception;

    String queryStudentNameByStudentNo(String studentNo) throws Exception;

    List<Map<String, Object>> queryFamousFamilyList() throws Exception;

    Map<String, Object> queryStudentsByLikesAdmin(SearchDto searchDto) throws Exception;

    List<Map<String,String>> queryStudentsAwardOrPunishmentList(String studentNo)throws Exception;

    void addAwardOrPunishmentByUpdate(OwnOrPunishment ownOrPunishment)throws Exception;

    List<Map<String,Object>> showAutoProfessionListByDepartment(String departmentId)throws Exception;

    List<Map<String,Object>> showAutoDirectionListByDepartment(String departmentId)throws Exception;

    List<Map<String,String>> queryAllStudentsProfessionList()throws Exception;

    List<Map<String,Object>> queryDirectionSelectionClass(String directionId)throws Exception;

    List<Map<String,Object>> querylevelSelectionClass(String levelName)throws Exception;

    void delAward(String id)throws Exception;

    List<Map<String,Object>> queryDisciplineAndPunishment(String studentNo) throws Exception;

    List<Map<String,Object>> queryGroupActivitiesList(String studentNo)throws Exception;

    void addDisciplineAndPunishmentByUpdate(DisciplineAndPunishmen disciplineAndPunishmen)throws Exception;

    void delDisciplineAndPunishment(String id)throws Exception;

    void addGroupActivitiesByUpdate(GroupActivities groupActivities)throws Exception;

    void delGroupActivities(String id)throws Exception;

    void updateGroupActivitiesInfo(List<Map<String, Object>> groupActivitiesList)throws Exception;

    void updateDisciplineAndPunishmentInfo(List<Map<String, Object>> disciplineAndPunishmentList)throws Exception;

    void updateAwardOrPunishmentInfo(List<Map<String, Object>> awardOrPunishmentList)throws Exception;

    void revokeDisciplineAndPunishment(String id,String revokeDiscipline)throws Exception;
}
