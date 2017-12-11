package com.thoughtWorks.web.systemManage;

import com.thoughtWorks.dto.Result;
import com.thoughtWorks.entity.Role;
import com.thoughtWorks.service.RoleService;
import com.thoughtWorks.util.Constant;
import com.thoughtWorks.util.PageUtil;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/userRole")
public class RoleController {
    @Resource
    private RoleService roleService;

    @RequestMapping()
    public String index() {
        return "systemManage/role/list";
    }

    @RequestMapping("list")
    @ResponseBody
    public Map<String, Object> getList(PageUtil page) {
        Map<String, Object> data = new HashMap<>();
        try {
            List<Role> roles = roleService.queryList(page);
            data.put("roles", roles);
            data.put("page", page);
            data.put("result", true);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return data;
    }


    @RequestMapping("add")
    @ResponseBody
    public Result add(Role role) {
        try {
            roleService.add(role);

            return Result.success(null, Constant.ADD_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.ADD_FAILURE);
    }

    @RequestMapping("updateRolePermissions")
    @ResponseBody
    public Result updateRolePermissions(String hasPers, String updatePers, String roleId) {
        try {
            roleService.updateRolePermissions(hasPers, updatePers, roleId);

            return Result.success(null, Constant.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.UPDATE_FAILURE);
    }

    @RequestMapping("update")
    @ResponseBody
    public Result update(Role role) {
        try {
            roleService.update(role);

            return Result.success(null, Constant.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.UPDATE_FAILURE);
    }
    @RequestMapping("deletePermission")
    @ResponseBody
    public Result deletePermission(String roleId) {
        try {
            roleService.deletePermission(roleId);
            return Result.success(null, Constant.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.UPDATE_FAILURE);
    }
    @RequestMapping("query")
    @ResponseBody
    public Result query(String roleId) {
        try {
            Role role = roleService.query(roleId);

            return Result.success(role, Constant.SEARCH_FAILURE);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }

    @RequestMapping("viewPermission")
    @ResponseBody
    public Result viewPermission(String roleId) {
        try {
            Map<String, Object> data = roleService.viewPermission(roleId);

            return Result.success(data, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.SEARCH_FAILURE);
    }

    @RequestMapping("updateAvailable")
    @ResponseBody
    public Result updateAvailable(Role role) {
        try {
            roleService.updateAvailable(role);

            return Result.success(null, Constant.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
        }

        return Result.failure(null, Constant.UPDATE_FAILURE);
    }
}
