package com.thoughtWorks.service.impl;

import com.thoughtWorks.dao.RoleDao;
import com.thoughtWorks.entity.ActiveUser;
import com.thoughtWorks.entity.Permission;
import com.thoughtWorks.entity.Role;
import com.thoughtWorks.service.RoleService;
import com.thoughtWorks.util.PageUtil;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

@Service
public class RoleServiceImpl implements RoleService {

    @Resource
    private RoleDao roleDao;

    @Override
    public List<Role> queryList(PageUtil page) throws Exception {
        Map<String, Object> data = new HashMap<>();
        data.put("start", (page.getCurrentIndex() - 1) * page.getPageSize());
        data.put("end", page.getPageSize());
        page.setTotalSize(roleDao.queryTotalCount());

        return roleDao.queryList(data);
    }

    @Override
    public void add(Role role) throws Exception {
        roleDao.add(role);
    }

    @Override
    public Role query(String roleId) throws Exception {
        return roleDao.query(roleId);
    }

    @Override
    public void update(Role role) throws Exception {
        roleDao.update(role);
    }
    @Override
    public void deletePermission(String roleId) throws Exception {
        roleDao.deletePermission(roleId);
    }

    @Override
    public void updateRolePermissions(String hasPers, String updatePers, String roleId) throws Exception {
        List<String> oldPermissions = Arrays.asList(hasPers.split(","));
        List<String> newPermissions = Arrays.asList(updatePers.split(","));
        List<String> shouldDelete = shouldDeletePers(oldPermissions, newPermissions);
        List<String> shouldInsert = shouldInsertPers(oldPermissions, newPermissions);

        if (shouldDelete.size() != 0) roleDao.deleteRolePermissions(shouldDelete, roleId);
        if (shouldInsert.size() != 0 && !"".equals(shouldInsert.get(0))) roleDao.addRolePermissions(shouldInsert, roleId);
    }

    @Override
    public void updateAvailable(Role role) throws Exception {
        roleDao.updateAvailable(role);
    }

    @Override
    public List<Map<String, String>> queryUserRoleList(PageUtil page, String name) throws Exception {
        Map<String, Object> data = new HashMap<>();
        data.put("start", (page.getCurrentIndex() - 1) * page.getPageSize());
        data.put("end", page.getPageSize());
        data.put("name", "%" + name + "%");
        page.setTotalSize(roleDao.queryUserRoleTotalCount("%" + name + "%"));

        return roleDao.queryUserRoleList(data);
    }

    @Override
    public List<Role> queryAll() throws Exception {
        return roleDao.queryAll();
    }

    private List<String> shouldInsertPers(List<String> oldPermissions, List<String> newPermissions) {
        List<String> shouldInsert = new ArrayList<>();
        for (String permission : newPermissions) {
            if (!oldPermissions.contains(permission)) {
                shouldInsert.add(permission);
            }
        }

        return shouldInsert;
    }

    @Override
    public void updateUserRole(ActiveUser user) throws Exception {
        roleDao.updateUserRole(user);
    }


    private List<String> shouldDeletePers(List<String> oldPermissions, List<String> newPermissions) {
        List<String> shouldDelete = new ArrayList<>();
        for (String permission : oldPermissions) {
            if (!newPermissions.contains(permission)) {
                shouldDelete.add(permission);
            }
        }

        return shouldDelete;
    }

    @Override
    public Map<String, Object> viewPermission(String roleId) {
        Map<String, Object> result = new HashMap<>();
        Map<String, Object> nodes = new HashMap<>();
        List<Permission> permissions = roleDao.queryAllPermission();
        List<String> hasPermissions = roleDao.queryPermissionByRoleId(roleId);

        changePermissionState(nodes, permissions, hasPermissions);

        Collection<Object> topMenus = removeMapKey(nodes);
        result.put("permissions", topMenus);
        result.put("hasPermissions", hasPermissions);

        return result;
    }

    private Collection<Object> removeMapKey(Map<String, Object> nodes) {
        Collection<Object> topMenus = nodes.values();
        Iterator<Object> iterator = topMenus.iterator();
        while (iterator.hasNext()) {
            Map<String, Object> next = (Map<String, Object>) iterator.next();
            Collection<Object> sideMenus = ((Map<String, Object>) next.get("children")).values();
            next.put("children", sideMenus);
            Iterator<Object> iterator1 = sideMenus.iterator();
            while (iterator1.hasNext()) {
                Map<String, Object> next1 = (Map<String, Object>) iterator1.next();
                Collection<Object> permission = ((Map<String, Object>) next1.get("children")).values();
                next1.put("children", permission);
            }
        }

        return topMenus;
    }

    private void changePermissionState(Map<String, Object> nodes, List<Permission> permissions, List<String> hasPermissions) {
        for (Permission permission : permissions) {
            String[] deep = permission.getParentIds().split("/");
            Map<String, Object> node = new HashMap<>();
            node.put("id", permission.getId());
            node.put("name", permission.getName());

            if (hasPermissions.contains(permission.getId().toString())) { //判断是否有该权限
                node.put("has", true);
            }
            if (deep.length == 2) { // 一级菜单
                node.put("children", new HashMap<String, Map<String, String>>());
                nodes.put(permission.getId() + "", node);
            } else if (deep.length == 3) {//二级菜单
                node.put("children", new HashMap<String, Map<String, String>>());
                ((Map<String, Object>) ((Map<String, Object>) nodes.get(deep[2])).get("children")).put(permission.getId() + "", node);
            } else if (deep.length == 4) {//权限
                Map<String, Object> children = (Map<String, Object>) ((Map<String, Object>) ((Map<String, Object>) nodes.get(deep[2])).get("children")).get(deep[3]);
                ((Map<String, Object>) children.get("children")).put(permission.getId() + "", node);
            }
        }
    }
}
