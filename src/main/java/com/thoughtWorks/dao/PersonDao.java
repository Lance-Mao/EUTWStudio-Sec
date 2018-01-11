package com.thoughtWorks.dao;

import com.thoughtWorks.dto.SearchDto;
import com.thoughtWorks.entity.*;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface PersonDao {

    List<Map<String, String>> queryPersonList(Map<String, Object> data);

    Long queryPersonTotalCount();

    void addTeacher(Teacher teacher);

    void updateTeacher(Teacher teacher);

    void deleteTeacherById(String id);

    List<Map<String, String>> queryStudentsByLikes(Map<String, Object> data);

    Map<String, String> queryTeacherByNo(String userName);

    void distributedClass(@Param("classesId") String classesId, @Param("ids") List<String> ids);

    List<Map<String, String>> queryStudentsByClassesIdsAndLikeName(Map<String, Object> data);

    long queryStudentsCount(@Param("searchDto") SearchDto searchDto);

    Student queryStudentByNo(String stuNo);

    void addCommunication(CommunicationContent content);

    List<Map<String, Object>> queryCommunicationByStudentId(String studentNo);

    void updateCommunicationContent(CommunicationContent communicationContent);

    void distributeDirection(@Param("directionId") String directionId, @Param("ids") List<String> ids);

    List<Map<String, Object>> queryAllDept(Map<String, Object> data);

    Long queryDeptTotalCount();

    void addDept(String name);

    void updateDept(Map<String, Object> data);

    void deleteDept(String id);

    Teacher queryUserById(String no);

    List<Direction> queryDirectionByDepartmentId(int departmentId);

    List<Direction> queryDirectionByDepartment();

    List<Classes> queryClass();

    List<Classes> queryClassByDepartmentId(int departmentId);

    List<Map<String, Object>> queryStudentInfoById(String studentNo) throws Exception;

    Long queryStudentsListCount(@Param("searchDto") SearchDto searchDto);

    List<Map<String, Object>> queryStudentList(Map<String, Object> data);

    List<Map<String, Object>> updateByStudentNo(String studentNo) throws Exception;

    List<Map<String, Object>> queryOwnPunishmentByStudentNo(String studentNo) throws Exception;

    List<Map<String, Object>> queryDisciplineAndPunishmentByStudentNo(String studentNo) throws Exception;

    List<Map<String, Object>> queryGroupActivitiesByStudentNo(String studentNo) throws Exception;

    List<Map<String, Object>> updateExperienceByStudentNo(String studentNo) throws Exception;

    List<Map<String, Object>> updateFamilyByStudentNo(String studentNo) throws Exception;

    Map<String, Object> queryStudentsToUpdate(String studentNo) throws Exception;

    List<Map<String, Object>> queryStudentFamily(String studentNo) throws Exception;

    List<Map<String, String>> queryStudentsProfessionList(@Param("departmentId") String departmentId) throws Exception;

    List<Map<String, String>> queryStudentsDirection(@Param("departmentId") String departmentId) throws Exception;

    List<Map<String, Object>> queryStudentsClassList(@Param("searchLevel") String searchLevel) throws Exception;

    List<Map<String, Object>> queryStudentExperienceList(@Param("studentNo") String studentNo) throws Exception;

    List<Map<String, Object>> queryStudentScholarshipsList(@Param("studentNo") String studentNo) throws Exception;

    void insertCommunityTeacher(@Param("no") String no, @Param("areaId") int areaId, @Param("floorId") List<String> floorId) throws Exception;

    List<Map<String, Object>> queryTeacherCommunity(@Param("no") String no) throws Exception;

    void updateStudentTeacherId(@Param("teacherId") String teacherId, @Param("ids") List<String> ids)throws Exception;

    List<Map<String, Object>> teacherCommunity(String no)throws Exception;

    List<Map<String, Object>> teacherCommunity_floors(String no)throws Exception;

    List<Map<String, Object>> queryTeacherList() throws Exception;

    void updateExperienceList(@Param("experiences") List<Map<String, Object>> experiences);

    void updateStudentList(StudentUpdate studentUpdate)throws Exception;

    void addTeacherToUser(@Param("teacher") Teacher teacher, @Param("roleId") int roleId);

    void deleteUserByTeacherId(String id);

    void addFamilyByUpdate(StudentFamily studentFamily);

    void updateFamilyInfo(@Param("list")List<Map<String, Object>> familyList);

    void delStudentFamily(String familyId);

    void delExperience(String experienceId);

    void addExperienceByUpdate(Experience experience);

    Map<String,String> queryFamousFamily(@Param("famousFamily") String famousFamily);

    List<Map<String,Object>> queryDepartmentList();

    List<Map<String,Object>> showAutoClassByDepartment(@Param("departmentId") String departmentId,@Param("searchLevel") String searchLevel);

    String queryStudentNameByStudentNo(String studentNo);

    List<Map<String,Object>> queryFamousFamilyList();

    List<Map<String,String>> queryStudentsByLikesAdmin(Map<String, Object> data);

    List<Map<String,String>> queryStudentsAwardOrPunishmentList(@Param("studentNo") String studentNo);

    void addAwardOrPunishmentByUpdate(OwnOrPunishment ownOrPunishment);

    List<Map<String,Object>> showAutoProfessionListByDepartment(@Param("departmentId") String departmentId);

    List<Map<String,Object>> showAutoDirectionListByDepartment(@Param("departmentId") String departmentId);

    List<Map<String,String>> queryAllStudentsProfessionList();

    List<Map<String,Object>> queryDirectionSelectionClass(@Param("directionId") String directionId);

    List<Map<String,Object>> querylevelSelectionClass(@Param("levelName") String levelName);

    void delAward(String id);

    List<Map<String,Object>> queryDisciplineAndPunishment(@Param("studentNo") String studentNo);

    List<Map<String,Object>> queryGroupActivitiesList(@Param("studentNo") String studentNo);

    void addDisciplineAndPunishmentByUpdate(DisciplineAndPunishmen disciplineAndPunishmen);

    void delDisciplineAndPunishment(@Param("id") String id);

    void addGroupActivitiesByUpdate(GroupActivities groupActivities);

    void delGroupActivities(@Param("id") String id);

    void updateGroupActivitiesInfo(@Param("list")List<Map<String, Object>> groupActivitiesList);

    void updateDisciplineAndPunishmentInfo(@Param("list")List<Map<String, Object>> disciplineAndPunishmentList);

    void updateAwardOrPunishmentInfo(@Param("list")List<Map<String, Object>> awardOrPunishmentList);

    void revokeDisciplineAndPunishment(@Param("id") String id,@Param("revokeDiscipline") String revokeDiscipline);

    String queryStudentZyFile(String no);

    void addStudentZyFile(@Param("no") String no,@Param("zyFile") String zyFile);
}

