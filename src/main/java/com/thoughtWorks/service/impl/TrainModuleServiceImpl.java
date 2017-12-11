package com.thoughtWorks.service.impl;

import com.thoughtWorks.dao.DepartmentDao;
import com.thoughtWorks.dao.TrainModuleDao;
import com.thoughtWorks.dto.SearchDto;
import com.thoughtWorks.entity.*;
import com.thoughtWorks.service.TrainModuleService;
import com.thoughtWorks.util.PageUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TrainModuleServiceImpl implements TrainModuleService {

    @Resource
    private TrainModuleDao trainModuleDao;
    @Resource
    private DepartmentDao departmentDao;

    @Override
    public List<Map<String, String>> queryCoursesLikes(PageUtil page, SearchDto searchDto) throws Exception {
        Map<String, Object> data = new HashMap<>();
        data.put("start", (page.getCurrentIndex() - 1) * page.getPageSize());
        data.put("end", page.getPageSize());
        data.put("moduleId", searchDto.getModuleId());
        data.put("departmentId", searchDto.getDepartmentId());
        data.put("name", "%" + searchDto.getName() + "%");
        data.put("semester", searchDto.getSemester());
        page.setTotalSize(trainModuleDao.queryCoursesTotalCount(data));

        return trainModuleDao.queryCoursesList(data);
    }

    @Override
    public List<Map<String, String>> queryAllTrainModules() throws Exception {
        return trainModuleDao.queryAllTrainModules();
    }

    @Override
    public void addCourse(Course course) throws Exception {
        trainModuleDao.addCourse(course);
    }

    @Override
    public void updateCourse(Course course) throws Exception {
        trainModuleDao.updateCourse(course);
    }

    @Override
    public void deleteCourse(String id) throws Exception {
        trainModuleDao.deleteCourse(id);
    }

    @Override
    public List<Map<String, String>> queryTrainModuleList(PageUtil page) throws Exception {
        Map<String, Object> data = new HashMap<>();
        data.put("start", (page.getCurrentIndex() - 1) * page.getPageSize());
        data.put("end", page.getPageSize());
        page.setTotalSize(trainModuleDao.queryTrainModuleTotalCount());

        return trainModuleDao.queryTrainModuleList(data);
    }

    @Override
    public List<Classes> queryTrainPrograms(PageUtil page) throws Exception {
        Map<String, Object> data = new HashMap<>();
        data.put("start", (page.getCurrentIndex() - 1) * page.getPageSize());
        data.put("end", page.getPageSize());
        page.setTotalSize(trainModuleDao.queryTrainProgramTotalCount());

        return trainModuleDao.queryTrainPrograms(data);
    }

    @Override
    public Map<String, Object> loadDepartmentsAndDirectionsAndModuleCourses() {
        Map<String, Object> result = new HashMap<>();
        List<Department> departments = departmentDao.queryAllDepartments();
        if (departments.size() > 0)
            result.put("directions", departmentDao.queryDirectionsByDepartmentId(String.valueOf(departments.get(0).getId())));
        result.put("moduleCourses", trainModuleDao.queryAllModuleCourses());
        result.put("departments", departments);

        return result;
    }

    @Override
    public void addTrainProgram(TrainModule trainModule, String moduleCoursesStr) throws Exception {
        trainModuleDao.addTrainProgram(trainModule);
        List<Map<String, String>> moduleCourses = getModuleCourses(moduleCoursesStr, trainModule.getId());

        trainModuleDao.addProgramModuleCourses(moduleCourses);
    }

    @Override
    public List<Map<String, String>> loadModuleCoursesByProgram(int id) throws Exception {
        List<Map<String, String>> allCourses = trainModuleDao.queryAllModuleCourses();
        List<String> ownCourses = trainModuleDao.queryModuleIdsByProgramId(id);
        for (Map<String, String> course : allCourses) {
            if (ownCourses.contains(String.valueOf(course.get("courseId")))) course.put("isChecked", "checked");
        }

        return allCourses;
    }

    @Override
    public void updateProgramModuleCourses(int id, String moduleCoursesStr) throws Exception {
        trainModuleDao.deleteProgramModuleCoursesByProgramId(id);
        List<Map<String, String>> moduleCourses = getModuleCourses(moduleCoursesStr, id);
        trainModuleDao.addProgramModuleCourses(moduleCourses);
    }

    private List<Map<String, String>> getModuleCourses(String moduleCoursesStr, int programId) {
        List<Map<String, String>> moduleCourses = new ArrayList<>();
        String[] moduleCourseStr = moduleCoursesStr.split(",");
        for (String str : moduleCourseStr) {
            if (str.split("-").length < 2) continue; // 当前模块下没有课程
            String moduleId = str.split("-")[0];
            String[] coursesIds = str.split("-")[1].split(" ");
            for (String courseId : coursesIds) {
                Map<String, String> course = new HashMap<>();
                course.put("programId", String.valueOf(programId));
                course.put("moduleId", moduleId);
                course.put("courseId", courseId);
                moduleCourses.add(course);
            }
        }

        return moduleCourses;
    }

    @Override
    public void deleteProgramById(int id) throws Exception {
        trainModuleDao.deleteProgramById(id);
        trainModuleDao.deleteProgramModuleCoursesByProgramId(id);
    }

    @Override
    public List<Map<String, Object>> queryAllTestMethod(PageUtil pageUtil) {
        Map<String, Object> data = new HashMap<>();
        data.put("start", (pageUtil.getCurrentIndex() - 1) * pageUtil.getPageSize());
        data.put("pageSize", 10);
        return trainModuleDao.queryAllTestMethod(data);
    }

    @Override
    public void addTestMethod(String name) {
        trainModuleDao.addTestMethod(name);
    }

    @Override
    public void updateTestMethod(String name, String id) {
        Map<String, Object> data = new HashMap<>();
        data.put("id", id);
        data.put("name", name);
        trainModuleDao.updateTestMethod(data);
    }

    @Override
    public void deleteTestMethod(String id) {
        trainModuleDao.deleteTestMethod(id);
    }

    @Override
    public List<Map<String,String>> queryClassesList(PageUtil page) throws Exception {
        Map<String, Object> data = new HashMap<>();
        data.put("start", (page.getCurrentIndex() - 1) * page.getPageSize());
        data.put("end", page.getPageSize());
        page.setTotalSize(trainModuleDao.queryClassesTotalCount());

        return trainModuleDao.queryClassesList(data);
    }

    @Override
    public void insertCourseModule(CourseModule courseModule) throws Exception {
        trainModuleDao.insertCourseModule(courseModule);
    }

    @Override
    public void updateCourseModule(CourseModule courseModule) throws Exception {
        trainModuleDao.updateCourseModule(courseModule);
    }

    @Override
    public void deleteCourseModule(String id) throws Exception {
        trainModuleDao.deleteCourseModule(id);
    }

    @Override
    public Map<String, Object> queryTrainProgramByNo(String studentNo) throws Exception {
        return trainModuleDao.queryTrainProgramByNo(studentNo);
    }
}
