package com.thoughtWorks.service.impl;

import com.thoughtWorks.dao.DormDao;
import com.thoughtWorks.service.DormService;
import com.thoughtWorks.util.PageUtil;
import jdk.nashorn.internal.runtime.ECMAException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service

public class DormServiceImpl implements DormService {

    @Autowired
    private DormDao dormDao;

    @Override
    public List<Map<String, Object>> queryAreas(PageUtil pageUtil, String areaId, String areaName) throws Exception {
        Map<String, Object> data = new HashMap<>();
        data.put("start", (pageUtil.getCurrentIndex() - 1) * pageUtil.getPageSize());
        data.put("pageSize", pageUtil.getPageSize());
        data.put("areaId", "%" + areaId + "%");
        if (areaName.length() > 6) {
            data.put("areaName", "%" + "%");
        } else {
            data.put("areaName", "%" + areaName + "%");
        }
        pageUtil.setTotalSize(dormDao.queryAreasTotalCount(data));

        return dormDao.queryAreas(data);
    }

    @Override
    public void addArea(String name) throws Exception {
        dormDao.addArea(name);
    }

    @Override
    public void updateArea(String name, String id) throws Exception {
        Map<String, Object> data = new HashMap<>();
        data.put("name", name);
        data.put("id", id);
        dormDao.updateArea(data);
    }

    @Override
    public void deleteArea(String id) throws Exception {
        dormDao.deleteArea(id);
    }

    @Override
    public List<Map<String, Object>> queryFloors(PageUtil pageUtil, Map<String, Object> data1) throws Exception {
        Map<String, Object> data = new HashMap<>();
        data.put("start", (pageUtil.getCurrentIndex() - 1) * pageUtil.getPageSize());
        data.put("pageSize", pageUtil.getPageSize());

        if (data1.get("areaName").toString().length() > 6) {
            data.put("areaName", "%" + "%");
        } else {
            data.put("areaName", data1.get("areaName"));
        }

        if (data1.get("floorName").toString().length() > 6) {
            data.put("floorName", "%" + "%");
        } else {
            data.put("floorName", data1.get("floorName"));
        }

        data.put("areaId", data1.get("areaId"));
        data.put("floorId", data1.get("floorId"));


        pageUtil.setTotalSize(dormDao.queryFloorsTotalCount(data));

        return dormDao.queryFloors(data);
    }

    @Override
    public void addFloor(String name, String areaId) throws Exception {
        dormDao.addFloor(name, areaId);
    }

    @Override
    public void updateFloor(String name, String id) throws Exception {
        Map<String, Object> data = new HashMap<>();
        data.put("name", name);
        data.put("id", id);
        dormDao.updateFloor(data);

    }

    @Override
    public void deleteFloor(String id) throws Exception {
        dormDao.deleteFloor(id);

    }

    @Override
    public List<Map<String, Object>> queryRooms(PageUtil pageUtil, Map<String, Object> data) throws Exception {
        Map<String, Object> data1 = new HashMap<>();
        data1.put("start", (pageUtil.getCurrentIndex() - 1) * pageUtil.getPageSize());
        data1.put("pageSize", pageUtil.getPageSize());
        data1.put("roomNo", "%" + data.get("roomNo") + "%");
        if (data.get("areaName").toString().length()>6){
            data1.put("areaName","");
        }else {
            data1.put("areaName","%"+data.get("areaName")+"%");
        }

        if (data.get("floorName").toString().length()>6){
            data1.put("floorName","");
        }else {
            data1.put("floorName","%"+data.get("floorName")+"%");
        }

        data1.put("areaId", data.get("areaId"));
        data1.put("floorId", data.get("floorId"));
        pageUtil.setTotalSize(dormDao.queryRoomsTotalCount(data1));

        return dormDao.queryRooms(data1);
    }

    @Override
    public void addRoom(String name, String floorId, String areaId) throws Exception {
        Map<String, Object> data = new HashMap<>();
        data.put("name", name);
        data.put("floorId", floorId);
        dormDao.addRoom(data);
    }

    @Override
    public void updateRoom(String name, String id, String floorId) throws Exception {
        Map<String, Object> data = new HashMap<>();
        data.put("name", name);
        data.put("id", id);
        data.put("floorId", floorId);


        dormDao.updateRoom(data);
    }

    @Override
    public void deleteRoom(String id) throws Exception {
        dormDao.deleteRoom(id);
    }

    @Override
    public List<Map<String, Object>> selectAreaOfFloor() throws Exception {
        return dormDao.selectAreaOfFloor();
    }

    @Override
    public Map<String, Object> showAreaAndFloorInfos(String areaId) throws Exception {
        Map<String, Object> data = new HashMap<>();
        data.put("queryAreaOfRoom", dormDao.queryAreaOfRoom());
        data.put("queryFloorOfRoom", dormDao.queryFloorOfRoom(areaId));

        return data;
    }

    @Override
    public Map<String, Object> showFloorsAndRooms(String floorId) throws Exception {
        Map<String, Object> data = new HashMap<>();
        data.put("queryRoomList",dormDao.showFloorsAndRooms(floorId));
        return data;
    }

    @Override
    public Map<String, Object> showDorms(String areaId, String floorId) throws Exception {
        Map<String, Object> data = new HashMap<>();
        data.put("areaList", dormDao.queryAreaOfRoom());
        data.put("floorList", dormDao.queryFloorOfRoom(areaId));
        data.put("roomList", dormDao.showFloorsAndRooms(floorId));
        return data;
    }

    @Override
    public Map<String, Object> queryAreaAndFloorAndRoomByRoomId(String roomId) throws Exception {
        return dormDao.queryAreaAndFloorAndRoomByRoomId(roomId);
    }

    @Override
    public List<Map<String, Object>> queryAllArea() throws ECMAException {
        return dormDao.queryAllArea();
    }

}
