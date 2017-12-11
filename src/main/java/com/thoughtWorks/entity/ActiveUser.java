package com.thoughtWorks.entity;

import java.io.Serializable;
import java.util.List;

public class ActiveUser implements Serializable {
    private boolean available;
    private String userName;
    private String password;
    private String name;
    private String headImage;
    private int roleId;
    private List<Permission> menus;// 菜单
    private List<Permission> permissions;// 权限

    public String getHeadImage() {
        return headImage;
    }

    public void setHeadImage(String headImage) {
        this.headImage = headImage;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public boolean isAvailable() {
        return available;
    }

    public void setAvailable(boolean available) {
        this.available = available;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public List<Permission> getMenus() {
        return menus;
    }

    public void setMenus(List<Permission> menus) {
        this.menus = menus;
    }

    public List<Permission> getPermissions() {
        return permissions;
    }

    public void setPermissions(List<Permission> permissions) {
        this.permissions = permissions;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public int getRoleId() {
        return roleId;
    }

    public void setRoleId(int roleId) {
        this.roleId = roleId;
    }

    @Override
    public String toString() {
        return "ActiveUser{" +
                "available=" + available +
                ", userName='" + userName + '\'' +
                ", password='" + password + '\'' +
                ", name='" + name + '\'' +
                ", headImage='" + headImage + '\'' +
                ", roleId=" + roleId +
                ", menus=" + menus +
                ", permissions=" + permissions +
                '}';
    }
}
