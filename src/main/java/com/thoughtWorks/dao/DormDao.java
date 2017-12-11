package com.thoughtWorks.dao;

import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface DormDao {


    Long queryAreasTotalCount(Map<String,Object> data);

    List<Map<String,Object>> queryAreas(Map<String, Object> data);

    void addArea(String name);

    void updateArea(Map<String, Object> data);

    void deleteArea(String id);

    Long queryFloorsTotalCount(Map<String,Object> data);

    List<Map<String,Object>> queryFloors(Map<String, Object> data);

    void addFloor(@Param("name") String name,@Param("areaId") String areaId);

    void updateFloor(Map<String, Object> data);

    void deleteFloor(String id);

    Long queryRoomsTotalCount(Map<String,Object> data);

    List<Map<String,Object>> queryRooms(Map<String, Object> data);

    void addRoom(Map<String,Object> data);

    void updateRoom(Map<String, Object> data);

    void deleteRoom(String id);

    List<Map<String,Object>> selectAreaOfFloor();

    List<Map<String,Object>> queryAreaOfRoom();

    List<Map<String,Object>> queryFloorOfRoom(@Param("areaId") String areaId);

    List<Map<String,Object>> showFloorsAndRooms(String floorId)throws Exception;

    Map<String, Object> queryAreaAndFloorAndRoomByRoomId(String roomId) throws Exception;

    List<Map<String,Object>> queryAllArea();
}
