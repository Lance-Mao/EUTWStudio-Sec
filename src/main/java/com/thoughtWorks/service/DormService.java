package com.thoughtWorks.service;

import com.thoughtWorks.util.PageUtil;
import jdk.nashorn.internal.runtime.ECMAException;

import java.util.List;
import java.util.Map;

public interface DormService {

    List<Map<String,Object>> queryAreas(PageUtil pageUtil,String areaId,String areaName)throws Exception;

    void addArea(String name)throws Exception;

    void updateArea(String name, String id)throws Exception;

    void deleteArea(String id)throws Exception;

    List<Map<String,Object>> queryFloors(PageUtil pageUtil,Map<String,Object> data)throws Exception;

    void addFloor(String name,String areaId)throws Exception;

    void updateFloor(String name, String id)throws Exception;

    void deleteFloor(String id)throws Exception;

    List<Map<String,Object>> queryRooms(PageUtil pageUtil, Map<String, Object> data)throws Exception;

    void addRoom(String name,String floorId,String areaId)throws Exception;

    void updateRoom(String name, String id,String floorId)throws Exception;

    void deleteRoom(String id)throws Exception;

    List<Map<String,Object>> selectAreaOfFloor()throws Exception;

    Map<String,Object> showAreaAndFloorInfos(String areaId)throws Exception;

    Map<String,Object> showFloorsAndRooms(String floorId)throws Exception;

    Map<String,Object> showDorms(String areaId, String floorId)throws Exception;

    Map<String, Object> queryAreaAndFloorAndRoomByRoomId(String roomId) throws Exception;

    List<Map<String, Object>> queryAllArea() throws ECMAException;
}
