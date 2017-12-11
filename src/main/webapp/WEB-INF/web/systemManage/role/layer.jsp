<%@ page contentType="text/html; charset=UTF-8" %>
<div id="add" style="margin: 10px;display: none">
    <form id="role-add" lay-filter="role-add" class="layui-form layui-form-pane" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">角色名称</label>
            <div class="layui-input-inline">
                <input type="text" name="name" required jq-verify="required" jq-error="请输入角色名称"
                       placeholder="请输入角色描述" autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">状态</label>
            <div class="layui-input-inline">
                <input type="radio" name="available" title="启用" value="true" checked/>
                <input type="radio" name="available" title="禁用" value="false"/>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <button class="layui-btn" jq-submit>立即提交</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<div id="update" style="margin: 10px;display: none">
    <form id="update_form" class="layui-form layui-form-pane" method="post">
        <div class="layui-form-item">
            <input type="hidden" id="update_id" name="id"/>
            <label class="layui-form-label">角色名称</label>
            <div class="layui-input-inline">
                <input type="text" id="update_name" name="name" required jq-verify="required" jq-error="请输入角色名称"
                       autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">状态</label>
            <div class="layui-input-inline">
                <input type="radio" id="update_available_true" name="available" title="启用" value="true"/>
                <input type="radio" id="update_available_false" name="available" title="禁用" value="false"/>
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <a class="layui-btn" onclick="role.updateRole()">立即提交</a>
            </div>
        </div>
    </form>
</div>
<div id="tree" style="display: none;padding: 30px 0 0 30px"></div>
<script id="list-tpl" type="text/html">

    {{# layui.each(d.roles, function(index, item){ }}
    <tr>
        <%--<td>--%>
        <%--<input type="hidden" name="id" lay-skin="primary">--%>
        <%--</td>--%>
        <td>{{ index+1}}</td>
        <td>{{ item.name}}</td>
        <td>
            <shiro:hasPermission name="rolePermission:available">
                <input type="checkbox" name="available" value="{{item.id}}" lay-filter="role-available"
                       lay-skin="switch" lay-text="开启|关闭" {{#if (item.available=="true"){
                       }}checked="checked" {{# } }}>
            </shiro:hasPermission>
            <shiro:lacksPermission name="rolePermission:available">
                <input type="checkbox" name="available" value="{{item.id}}" disabled lay-skin="switch" lay-text="开启|关闭"
                       {{#if (item.available=="true"){
                       }}checked="checked" {{# } }}>
            </shiro:lacksPermission>
        </td>
        <td>
            <shiro:hasPermission name="rolePermission:update">
                <button class="layui-btn layui-btn-mini " style="background: #21a1a1" onclick="role.viewRole({{item.id}})">
                    <i class="layui-icon">&#xe642;</i>角色修改
                </button>
            </shiro:hasPermission>
            <shiro:hasPermission name="rolePermission:setting">
                <button class="layui-btn layui-btn-mini  layui-btn-danger" onclick="role.viewPermission({{item.id}})">
                    <i class="layui-icon">&#xe60a;</i>配置权限
                </button>
            </shiro:hasPermission>
            <shiro:hasPermission name="rolePermission:delete">
                <button class="layui-btn layui-btn-mini  layui-btn-danger" onclick="role.deletePermission({{item.id}})">
                    <i class="layui-icon">&#xe60a;</i>删除角色
                </button>
            </shiro:hasPermission>
        </td>
    </tr>
    {{# }); }}

</script>