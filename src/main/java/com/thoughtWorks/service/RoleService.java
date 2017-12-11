package com.thoughtWorks.service;

import com.thoughtWorks.entity.ActiveUser;
import com.thoughtWorks.entity.Permission;
import com.thoughtWorks.entity.Role;
import com.thoughtWorks.util.PageUtil;

import java.util.List;
import java.util.Map;

public interface RoleService {

    List<Role> queryList(PageUtil page) throws Exception;

    void add(Role role) throws Exception;

    Map<String, Object> viewPermission(String roleId) throws Exception;

     void deletePermission(String roleId) throws Exception;

    Role query(String roleId) throws Exception;

    void update(Role role) throws Exception;

    void updateRolePermissions(String hasPers, String updatePers, String roleId) throws Exception;

    void updateAvailable(Role role) throws Exception;

    List<Map<String, String>> queryUserRoleList(PageUtil page, String name) throws Exception;

    List<Role> queryAll() throws Exception;

    void updateUserRole(ActiveUser user) throws Exception;

}
