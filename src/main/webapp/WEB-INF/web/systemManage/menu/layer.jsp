<%@ page contentType="text/html; charset=UTF-8" %>
<div id="add" style="margin: 10px;display: none">
    <form id="menu-add" lay-filter="menu-add" class="layui-form layui-form-pane" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">名称</label>
            <div class="layui-input-inline">
                <input type="text" name="name" required
                       placeholder="" autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">url</label>
            <div class="layui-input-inline">
                <input type="text" name="url" required
                       placeholder="" autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <a class="layui-btn" onclick="menu.addMenuAjax()">添加</a>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<div id="secondMenu-add" style="margin: 10px;display: none">
    <form id="secondMenu-add-form" lay-filter="menu-add" class="layui-form layui-form-pane" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">名称</label>
            <div class="layui-input-inline">
                <input type="text" name="name" required
                       placeholder="" autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">url</label>
            <div class="layui-input-inline">
                <input type="text" name="url" required
                       placeholder="" autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <a class="layui-btn" onclick="menu.addSecondMenuAjax()">添加</a>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<div id="permission-add" style="margin: 10px;display: none">
    <form id="permission-add-form" lay-filter="menu-add" class="layui-form layui-form-pane" method="post">
        <input type="hidden" name="parentId" id="parentId-add">
        <div class="layui-form-item">
            <label class="layui-form-label">名称</label>
            <div class="layui-input-inline">
                <input type="text" name="name" required
                       placeholder="" autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">权限</label>
            <div class="layui-input-inline">
                <input type="text" name="perCode" required
                       placeholder="" autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <a class="layui-btn" onclick="menu.addPermissionAjax()">添加</a>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<div id="update" style="margin: 10px;display: none">
    <form id="update_form" class="layui-form layui-form-pane" method="post">
        <input type="hidden" id="update_id" name="id"
               autocomplete="off" class="layui-input ">
        <div class="layui-form-item">
            <label class="layui-form-label">角色名称</label>
            <div class="layui-input-inline">
                <input type="text" id="update_name" name="name"
                       class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">url</label>
            <div class="layui-input-inline">
                <input type="text" id="update_url" name="url"
                       class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <a class="layui-btn" onclick="menu.updateMenuAjax()">立即提交</a>
            </div>
        </div>
    </form>
</div>
<div id="secondMenu-update" style="margin: 10px;display: none">
    <form id="secondMenu-update-form" class="layui-form layui-form-pane" method="post">
        <input type="hidden" id="updateSecond_id" name="id"
               autocomplete="off" class="layui-input ">
        <div class="layui-form-item">
            <label class="layui-form-label">角色名称</label>
            <div class="layui-input-inline">
                <input type="text" id="updateSecond_name" name="name"
                       class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">url</label>
            <div class="layui-input-inline">
                <input type="text" id="updateSecond_url" name="url"
                       class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <a class="layui-btn" onclick="menu.updateSecondMenuAjax()">立即提交</a>
            </div>
        </div>
    </form>
</div>
<div id="permission-update" style="margin: 10px;display: none">
    <form id="permission-update-form" class="layui-form layui-form-pane" method="post">
        <input type="hidden" id="permission_id" name="id"
               autocomplete="off" class="layui-input ">
        <div class="layui-form-item">
            <label class="layui-form-label">角色名称</label>
            <div class="layui-input-inline">
                <input type="text" id="permission_name" name="name"
                       class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">权限</label>
            <div class="layui-input-inline">
                <input type="text" id="permission_perCode" name="perCode"
                       class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <a class="layui-btn" onclick="menu.updatePermissionAjax()">立即提交</a>
            </div>
        </div>
    </form>
</div>
<div id="subMenu" style="margin: 10px;display: none">
    <blockquote class="layui-elem-quote mylog-info-tit">
        <ul class="layui-tab-title">
            <li class="layui-btn " onclick="menu.addSecondMenu()"><i class="layui-icon">&#xe61f;</i>添加菜单
            </li>
        </ul>
    </blockquote>
    <div class="larry-separate"></div>

    <div class="layui-collapse" id="menus" lay-filter="test" style="padding: 30px;">

    </div>
</div>
<script id="list-tpl" type="text/html">
    {{# layui.each(d.data, function(index, item){ }}
    <tr>
        <td>{{ item.id}}</td>
        <td>{{ item.name}}</td>
        <td>{{ item.url}}</td>
        <td>
            <button class="layui-btn layui-btn-mini  layui-btn-danger" onclick="menu.subMenu('{{item.id}}')">
                <i class="layui-icon">&#xe60a;</i>子菜单
            </button>
            <button class="layui-btn layui-btn-mini " style="background: #21a1a1"
                    onclick="menu.update('{{item.id}}','{{item.name}}','{{item.url}}')">
                <i class="layui-icon">&#xe642;</i>修改
            </button>
            <button class="layui-btn layui-btn-mini  layui-btn-danger" onclick="menu.delete('{{item.id}}')">
                <i class="layui-icon">&#xe60a;</i>删除
            </button>
        </td>
    </tr>
    {{# }); }}

</script>