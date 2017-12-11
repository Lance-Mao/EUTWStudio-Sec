package com.thoughtWorks.shiro;

import com.thoughtWorks.entity.ActiveUser;
import com.thoughtWorks.entity.Permission;
import com.thoughtWorks.entity.Role;
import com.thoughtWorks.service.PermissionService;
import com.thoughtWorks.service.RoleService;
import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by huhao on 15-10-20.
 */
@Component
public class CustomRealm extends AuthorizingRealm {
    @Autowired
    private PermissionService permissionService;
    @Autowired
    private RoleService roleService;

    /**
     * 进行认证
     *
     * @param token
     * @return
     * @throws AuthenticationException
     */
    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        Role role = null;
        List<Permission> menu = null;
        ActiveUser activeUser = null;
        String userName = (String) token.getPrincipal();
        try {
            activeUser = permissionService.getSysUserByUserName(userName);
            role = roleService.query(activeUser.getRoleId() + "");
        } catch (Exception e) {
            e.printStackTrace();
        }
        if ("false".equals(role.getAvailable())) {
            throw new LockedAccountException();
        }
        if (activeUser == null) {
            throw new UnknownAccountException();//没找到帐号
        }
        if (!activeUser.isAvailable()) {
            throw new LockedAccountException();
        }
        //获得菜单
        try {
            menu = permissionService.findMenuListByRoleId(activeUser.getRoleId());
        } catch (Exception e) {
            e.printStackTrace();
        }
        activeUser.setMenus(menu);


        //这里查询到用户的信息后，将用户的username和password放在simpleAuthenticationInfo中，以供submit.login();
        //new SimpleAuthenticationInfo(对象或则是userName或是对象,password,this.getName());  在这里第一个参数传入对象的时候，在后面可以使用(ActiveUser)SecurityUtils.getSubject().getPrincipal()获得对象
        SimpleAuthenticationInfo simpleAuthenticationInfo = new SimpleAuthenticationInfo(activeUser, activeUser.getPassword(), this.getName());
        return simpleAuthenticationInfo;
    }


    /**
     * 用于授权  在进行需要权限判断的时候会执行该方法
     *
     * @param principals
     * @return
     */
    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        List<Permission> permissionList = null;
        //从 principals获取主身份信息
        //将getPrimaryPrincipal方法返回值转为真实身份类型（在上边的doGetAuthenticationInfo认证通过填充到SimpleAuthenticationInfo中身份类型），
        ActiveUser activeUser = (ActiveUser) principals.getPrimaryPrincipal();
        //获得所有的权限
        try {
            permissionList = permissionService.findPermissionListByRoleId(activeUser.getRoleId());
        } catch (Exception e) {
            e.printStackTrace();
        }
        List<String> permissions = new ArrayList<String>();
        if (permissionList != null) {
            for (Permission sysPermission : permissionList) {
                permissions.add(sysPermission.getPerCode());
            }
        }
        //查到权限数据，返回授权信息(要包括 上边的permissions)
        SimpleAuthorizationInfo simpleAuthorizationInfo = new SimpleAuthorizationInfo();
        simpleAuthorizationInfo.addStringPermissions(permissions);
        return simpleAuthorizationInfo;
    }

}
