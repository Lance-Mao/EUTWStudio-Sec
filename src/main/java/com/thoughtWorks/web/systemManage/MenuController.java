package com.thoughtWorks.web.systemManage;

import com.thoughtWorks.dao.PermissionDao;
import com.thoughtWorks.dto.Result;
import com.thoughtWorks.entity.Permission;
import com.thoughtWorks.service.PermissionService;
import com.thoughtWorks.util.Constant;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("/menu")
public class MenuController {
    @Resource
    private PermissionService permissionService;
    @Resource
    private PermissionDao permissionDao;

    @RequestMapping()
    public String index() {
        return "systemManage/menu/list";
    }

    @RequestMapping("list")
    @ResponseBody
    public Result list() {
        try {
            List<Permission> menus = permissionService.queryFirstMenus();

            return Result.success(menus, Constant.SEARCH_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.success(null, Constant.SEARCH_FAILURE);
        }
    }

    @RequestMapping("addFirstMenu")
    @ResponseBody
    public Result addFirstMenu(Permission permission) {
        try {
            permissionService.addFirstMenu(permission);

            return Result.success(null, Constant.ADD_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.success(null, Constant.ADD_FAILURE);
        }
    }

    @RequestMapping("addPermission")
    @ResponseBody
    public Result addPermission(Permission permission) {
        try {
            permissionService.addPer(permission);

            return Result.success(null, Constant.ADD_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.success(null, Constant.ADD_FAILURE);
        }
    }

    @RequestMapping("addSecondMenu")
    @ResponseBody
    public Result addSecondMenu(Permission permission) {
        try {
            permissionService.addSecondMenu(permission);

            return Result.success(null, Constant.ADD_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.success(null, Constant.ADD_FAILURE);
        }
    }
    @RequestMapping("updatePermission")
    @ResponseBody
    public Result updatePermission(Permission permission) {
        try {
            permissionDao.updatePermission(permission);

            return Result.success(null, Constant.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.success(null, Constant.UPDATE_FAILURE);
        }
    }

    @RequestMapping("deleteSecondMenu")
    @ResponseBody
    public Result deleteSecondMenu(String id) {
        try {
            permissionService.deleteSecondMenu(id);

            return Result.success(null, Constant.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.success(null, Constant.DELETE_FAILURE);
        }
    }

    @RequestMapping("updateMenu")
    @ResponseBody
    public Result updateMenu(Permission permission) {
        try {
            permissionDao.updateFirstMenu(permission);

            return Result.success(null, Constant.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.success(null, Constant.UPDATE_FAILURE);
        }
    }

    @RequestMapping("secondMenus")
    @ResponseBody
    public Result secondMenus(String id) {
        try {
            List<Map<String, Object>> secondMenus = permissionService.secondMenus(id);

            return Result.success(secondMenus, Constant.UPDATE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.success(null, Constant.UPDATE_FAILURE);
        }
    }

    @RequestMapping("delete")
    @ResponseBody
    public Result delete(String id) {
        try {
            permissionService.delete(id);

            return Result.success(null, Constant.DELETE_SUCCESS);
        } catch (Exception e) {
            e.printStackTrace();
            return Result.success(null, Constant.DELETE_FAILURE);
        }
    }


}
