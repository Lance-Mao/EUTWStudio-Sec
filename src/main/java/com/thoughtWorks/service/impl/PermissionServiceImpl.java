package com.thoughtWorks.service.impl;

import com.thoughtWorks.dao.PermissionDao;
import com.thoughtWorks.entity.ActiveUser;
import com.thoughtWorks.entity.Permission;
import com.thoughtWorks.service.PermissionService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class PermissionServiceImpl implements PermissionService {
    @Autowired
    private PermissionDao permissionDao;


    @Override
    public ActiveUser getSysUserByUserName(String roleId) throws Exception {
        return permissionDao.getSysUserByUserName(roleId);
    }

    @Override
    public List<Permission> findMenuListByRoleId(int roleId) throws Exception {
        return permissionDao.findMenuListByRoleId(roleId);
    }

    @Override
    public List<Permission> findPermissionListByRoleId(int roleId) throws Exception {
        return permissionDao.findPermissionListByRoleId(roleId);
    }

    @Override
    public List<Map<String, String>> getTopMenus(int roleId) throws Exception {
        return permissionDao.getTopMenus(roleId);
    }

    @Override
    public List<Map<String, String>> getSideMenus(String parentId, String roleId) throws Exception {
        return permissionDao.getSideMenus(parentId, roleId);
    }

    @Override
    public void addFirstMenu(Permission permission) throws Exception {
        permission.setType("menu");
        permission.setParentId((long) 1);
        permission.setParentIds("0/1/");
        permission.setSortString("1");
        permission.setAvailable("1");
        addPermission(permission);
    }

    @Override
    public void addSecondMenu(Permission permission) throws Exception {
        Permission per = permissionDao.queryPermissionsById(permission.getParentId());
        permission.setType("menu");
        permission.setParentIds(per.getParentIds() +permission.getParentId() + "/");
        permission.setSortString("2");
        permission.setAvailable("1");
        addPermission(permission);
    }

    @Override
    public void deleteSecondMenu(String id) throws Exception {
        permissionDao.delete(id);
        permissionDao.deletePermissionByParentId(id);
    }


    @Override
    public void delete(String id) throws Exception {
        permissionDao.delete(id);
        permissionDao.deleteHasPermissionById(id);
        List<String> ids = permissionDao.queryIdsByParents(id);
        if (ids.size() != 0) {
            ids.add(id);
            permissionDao.deletePermissionsByIds(ids);
            permissionDao.deleteHasPermissionsByIds(ids);
        }
    }

    @Override
    public List<Map<String, Object>> secondMenus(String id) throws Exception {
        List<Map<String, Object>> menus = permissionDao.queryPermissionsByParentId(id);
        for (Map<String, Object> menu : menus) {
            menu.put("permissions", permissionDao.queryPermissionsByParentId(menu.get("id").toString()));
        }

        return menus;
    }

    @Override
    public void addPer(Permission permission) throws Exception {
        Permission per = permissionDao.queryPermissionsById(permission.getParentId());
        permission.setType("permission");
        permission.setParentIds(per.getParentIds()+permission.getParentId() + "/");
        permission.setSortString("3");
        permission.setAvailable("1");
        addPermission(permission);
    }

    private void addPermission(Permission permission) {
        permissionDao.addPermission(permission);
    }

    @Override
    public List<Permission> queryFirstMenus() throws Exception {
        return permissionDao.queryFirstMenus();
    }

    @Override
    public Map<String, Object> getMenus(int roleId) throws Exception {
        Map<String, Object> result = new HashMap<>();
        List<Map<String, String>> topMenus = new ArrayList<>();
        Map<String, List<Map<String, String>>> sideMenus = new HashMap<>();

        List<Map<String, String>> menus = permissionDao.queryMenus(roleId);

        for (Map<String, String> menu : menus) {
            if ("1".equals(String.valueOf(menu.get("parentid")))) {
                List<Map<String, String>> temp = new ArrayList<>();
                topMenus.add(menu);
                sideMenus.put(String.valueOf(menu.get("pid")), temp);
            } else {
                sideMenus.get(String.valueOf(menu.get("parentid"))).add(menu);
            }
        }
        result.put("topMenus", topMenus);
        result.put("sideMenus", sideMenus);

        return result;
    }
}
