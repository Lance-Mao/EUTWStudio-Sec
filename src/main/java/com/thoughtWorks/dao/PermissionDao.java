package com.thoughtWorks.dao;

import com.thoughtWorks.entity.ActiveUser;
import com.thoughtWorks.entity.Permission;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

public interface PermissionDao {

    ActiveUser getSysUserByUserName(String userName);

    List<Permission> findMenuListByRoleId(int roleId);

    List<Permission> findPermissionListByRoleId(int roleId);

    List<Map<String,String>> getTopMenus(int roleId);

    List<Map<String, String>> getSideMenus(@Param("parentId") String parentId,@Param("roleId") String roleId);

    List<Map<String,String>> queryMenus(int roleId);

    List<Permission> queryFirstMenus();

    void addPermission(Permission permission);

    void delete(String id)throws Exception;

    void updateFirstMenu(Permission permission);

    void deleteHasPermissionById(String id);

    List<Map<String, Object>> queryPermissionsByParentId(String id);

    Permission queryPermissionsById(Long parentId);

    void deletePermissionByParentId(String id);

    void updatePermission(Permission permission);

    List<String> queryIdsByParents(String id);

    void deletePermissionsByIds(@Param("ids") List<String> ids);

    void deleteHasPermissionsByIds(@Param("ids") List<String> ids);
}
