package com.thoughtWorks.service;

import com.thoughtWorks.dto.SearchDto;
import com.thoughtWorks.entity.Classes;
import com.thoughtWorks.entity.Course;
import com.thoughtWorks.entity.CourseModule;
import com.thoughtWorks.entity.TrainModule;
import com.thoughtWorks.util.PageUtil;

import java.util.List;
import java.util.Map;

public interface TrainModuleService {
    List<Map<String,String>> queryTrainModuleList(PageUtil page)throws Exception;

    void insertCourseModule(CourseModule courseModule)throws Exception;

    void updateCourseModule(CourseModule courseModule)throws Exception;

    void deleteCourseModule(String id)throws Exception;


    List<Map<String,String>> queryClassesList(PageUtil page) throws Exception;

    List<Map<String,String>> queryCoursesLikes(PageUtil page, SearchDto searchDto)throws Exception;

    List<Map<String,String>> queryAllTrainModules() throws Exception;

    void addCourse(Course course)throws Exception;

    void updateCourse(Course course)throws Exception;

    void deleteCourse(String id)throws Exception;

    List<Classes> queryTrainPrograms(PageUtil page)throws Exception;

    Map<String,Object> loadDepartmentsAndDirectionsAndModuleCourses();

    void addTrainProgram(TrainModule trainModule, String moduleCoursesStr)throws Exception;

    List<Map<String,String>> loadModuleCoursesByProgram(int id)throws Exception;

    void updateProgramModuleCourses(int id, String moduleCoursesStr)throws Exception;

    void deleteProgramById(int id)throws Exception;

    List<Map<String,Object>> queryAllTestMethod(PageUtil pageUtil);

    void addTestMethod(String name);

    void updateTestMethod(String name,String id);

    void deleteTestMethod(String id);

    Map<String,Object> queryTrainProgramByNo(String studentNo) throws Exception;
}
