package com.thoughtWorks.service.impl;

import com.thoughtWorks.dao.DepartmentDao;
import com.thoughtWorks.entity.Department;
import com.thoughtWorks.entity.Direction;
import com.thoughtWorks.entity.Profession;
import com.thoughtWorks.service.DepartmentService;
import com.thoughtWorks.util.PageUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

@Service
public class DepartmentServiceImpl implements DepartmentService {

    @Resource
    private DepartmentDao departmentDao;

    @Override
    public List<Map<String, String>> queryDepartmentList(PageUtil page) throws Exception {
        Map<String, Object> data = new HashMap<>();
        data.put("start", (page.getCurrentIndex() - 1) * page.getPageSize());
        data.put("end", page.getPageSize());
        page.setTotalSize(departmentDao.queryDepartmentTotalCount());

        return departmentDao.queryDepartmentList(data);
    }

    @Override
    public Map<String, List<Map<String, String>>> getProfessionAndDirectionData() throws Exception {
        Map<String, List<Map<String, String>>> result = new HashMap<>();
        result.put("directions", departmentDao.queryDirections());
        result.put("professions", departmentDao.queryProfessions());

        return result;
    }

    @Override
    public void addDepartment(String code, String name, String professionsIds, String directionsIds) throws Exception {
        List<String> professions = Arrays.asList(professionsIds.split(","));
        List<String> directions = Arrays.asList(directionsIds.split(","));
        Department department = new Department(0, code, name);
        departmentDao.addDepartment(department);

        if (directions.size() != 0) departmentDao.updateDirectionDepartmentId(department.getId(), directions);
        if (professions.size() != 0) departmentDao.updateProfessionDepartmentId(department.getId(), professions);
    }

    @Override
    public void updateDepartment(Department department, String professionsIds, String directionsIds) throws Exception {
        List<String> professions = Arrays.asList(professionsIds.split(","));
        List<String> directions = Arrays.asList(directionsIds.split(","));
        List<String> hasDirections = departmentDao.queryDirectionIdsByDepartmentId(String.valueOf(department.getId()));
        List<String> hasProfessions = departmentDao.queryProfessionIdsByDepartmentId(String.valueOf(department.getId()));

        List<String> shouldDeleteProfessionsDepartmentIds = shouldDelete(professions, hasProfessions);
        List<String> shouldDeleteDirectionsDepartmentIds = shouldDelete(directions, hasDirections);

        List<String> shouldInsertProfessionsDepartmentIds = shouldInsert(professions, hasProfessions);
        List<String> shouldInsertDirectionsDepartmentIds = shouldInsert(directions, hasDirections);

        if (shouldDeleteDirectionsDepartmentIds.size() != 0)
            departmentDao.deleteDirectionsDepartmentId(shouldDeleteDirectionsDepartmentIds);
        if (shouldDeleteProfessionsDepartmentIds.size() != 0)
            departmentDao.deleteProfessionsDepartmentId(shouldDeleteProfessionsDepartmentIds);

        if (shouldInsertDirectionsDepartmentIds.size() != 0)
            departmentDao.insertDirectionsDepartmentIds(department.getId(), shouldInsertDirectionsDepartmentIds);
        if (shouldInsertProfessionsDepartmentIds.size() != 0)
            departmentDao.insertProfessionsDepartmentIds(department.getId(), shouldInsertProfessionsDepartmentIds);

        departmentDao.updateDepartment(department);
    }

    private List<String> shouldInsert(List<String> oldIds, List<String> newIds) throws Exception {
        List<String> shouldDelete = new ArrayList<>();
        for (String id : oldIds) {
            if (!newIds.contains(id) && !"".equals(id)) {
                shouldDelete.add(id);
            }
        }

        return shouldDelete;
    }

    private List<String> shouldDelete(List<String> oldIds, List<String> newIds) throws Exception {
        List<String> shouldInsert = new ArrayList<>();
        for (String id : newIds) {
            if (!oldIds.contains(id) && !"".equals(id)) {
                shouldInsert.add(id);
            }
        }

        return shouldInsert;
    }

    @Override
    public Map<String, List<Map<String, String>>> getFullProfessionAndDirectionData(String id) throws Exception {
        Map<String, List<Map<String, String>>> professionAndDirectionData = getProfessionAndDirectionData();
        List<String> directions = departmentDao.queryDirectionIdsByDepartmentId(id);
        List<String> professions = departmentDao.queryProfessionIdsByDepartmentId(id);

        changeDirectionCurrentState(professionAndDirectionData.get("directions"), directions);
        changeProfessionCurrentState(professionAndDirectionData.get("professions"), professions);

        return professionAndDirectionData;
    }

    private void changeDirectionCurrentState(List<Map<String, String>> dataList, List<String> directions) {
        for (int i = 0; i < dataList.size(); ++i) {
            Direction data = (Direction) dataList.get(i);
            if (directions.contains(String.valueOf(data.getId())))
                data.setDepartmentId("checked");
            else if (!directions.contains(String.valueOf(data.getId())) && null != data.getDepartmentId() && !"".equals(data.getDepartmentId().trim()))
                data.setDepartmentId("disabled");
            else if (directions.contains(String.valueOf(data.getId())) && null != data.getDepartmentId() && "".equals(data.getDepartmentId().trim()))
                data.setDepartmentId("");
        }
    }

    private void changeProfessionCurrentState(List<Map<String, String>> dataList, List<String> professions) {
        for (int i = 0; i < dataList.size(); ++i) {
            Profession data = (Profession) dataList.get(i);
            if (professions.contains(String.valueOf(data.getId())))
                data.setDepartmentId("checked");
            else if (!professions.contains(String.valueOf(data.getId())) && null != data.getDepartmentId() && !"".equals(data.getDepartmentId().trim()))
                data.setDepartmentId("disabled");
            else if (professions.contains(String.valueOf(data.getId())) && null != data.getDepartmentId() && "".equals(data.getDepartmentId().trim()))
                data.setDepartmentId("");
        }
    }

    @Override
    public void deleteDepartment(String id) throws Exception {
        departmentDao.deleteProfessionDepartmentIdByDepartmentId(id);
        departmentDao.deleteDirectionDepartmentIdByDepartmentId(id);
        departmentDao.deleteDepartment(id);
    }

    @Override
    public List<Map<String, String>> queryClassesByDirectionId(String id) throws Exception {
        return departmentDao.queryClassesByDirectionId(id);
    }
  @Override
    public List<Map<String, String>> queryClassByDirectionIdAndLevel(String directionId,String level) throws Exception {
        return departmentDao.queryClassByDirectionIdAndLevel(directionId,level);
    }

    @Override
    public List<Map<String, String>> queryDirectionList(PageUtil page) throws Exception {
        Map<String, Object> data = new HashMap<>();
        data.put("start", (page.getCurrentIndex() - 1) * page.getPageSize());
        data.put("end", page.getPageSize());
        page.setTotalSize(departmentDao.queryDirectTotalCount());

        return departmentDao.queryDirectionList(data);
    }

    @Override
    public void insertDirection(Direction direction) throws Exception {
        departmentDao.insertDirection(direction);
    }

    @Override
    public void updateDirection(Direction direction) throws Exception {
        departmentDao.updateDirection(direction);
    }

    @Override
    public void deleteDirection(String id) throws Exception {
        departmentDao.deleteDirection(id);
    }


    @Override
    public List<Map<String, String>> queryProfessionList(PageUtil page) throws Exception {
        Map<String, Object> data = new HashMap<>();
        data.put("start", (page.getCurrentIndex() - 1) * page.getPageSize());
        data.put("end", page.getPageSize());
        page.setTotalSize(departmentDao.queryProfessionTotalCount());

        return departmentDao.queryProfessionList(data);
    }

    @Override
    public void insertProfession(Profession profession) throws Exception {
        departmentDao.insertProfession(profession);
    }

    @Override
    public void updateProfession(Profession profession) throws Exception {
        departmentDao.updateProfession(profession);
    }

    @Override
    public void deleteProfession(String id) throws Exception {
        departmentDao.deleteProfession(id);
    }
}
