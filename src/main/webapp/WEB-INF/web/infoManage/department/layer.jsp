<%@ page contentType="text/html; charset=UTF-8" %>
<script id="list-tpl" type="text/html">
    {{# layui.each(d.departments, function(index, item){ }}
    <tr>
        <td>{{ index+1}}</td>
        <td>{{ item.code}}</td>
        <td>{{ item.name}}</td>
        <td>
            <shiro:hasPermission name="department:update">
                <button class="layui-btn layui-btn-mini " style="background: #21a1a1"
                        onclick="department.update('{{item.id}}','{{item.code}}','{{item.name}}')">
                    <i class="layui-icon">&#xe642;</i>修改
                </button>
            </shiro:hasPermission>
            <shiro:hasPermission name="department:delete">
                <button class="layui-btn layui-btn-mini  layui-btn-danger" onclick="department.delete('{{item.id}}')">
                    <i class="layui-icon">&#xe60a;</i>删除
                </button>
            </shiro:hasPermission>
        </td>
    </tr>
    {{# }); }}

</script>
<div id="add" style="margin: 10px;display: none">
    <form id="add-form" lay-filter="role-add" class="layui-form layui-form-pane" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">系代码</label>
            <div class="layui-input-inline">
                <input type="text" name="code"
                       placeholder="请输入系代码" id="code-add" autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">系名称</label>
            <div class="layui-input-inline">
                <input type="text" name="name"
                       placeholder="请输入系名称" id="name-add" autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">对应专业</label>
            <div class="layui-input-block" id="professions-add">

            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">对应方向</label>
            <div class="layui-input-block" id="directions-add">
            </div>
        </div>


        <div class="layui-form-item" style="margin-top: 30px">
            <div class="layui-input-block">
                <a class="layui-btn" onclick="department.addAjax()">立即提交</a>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<div id="update" style="margin: 10px;display: none">
    <form lay-filter="role-add" class="layui-form layui-form-pane" method="post">
        <input id="id" name="id" type="hidden">

        <div class="layui-form-item">
            <label class="layui-form-label">系代码</label>
            <div class="layui-input-inline">
                <input type="text" name="code"
                       placeholder="请输入系代码" id="code-update" autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">系名称</label>
            <div class="layui-input-inline">
                <input type="text" name="name"
                       placeholder="请输入系名称" id="name-update" autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">对应专业</label>
            <div class="layui-input-block" id="professions-update">

            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">对应方向</label>
            <div class="layui-input-block" id="directions-update">
            </div>
        </div>


        <div class="layui-form-item">
            <div class="layui-input-block">
                <a class="layui-btn" onclick="department.updateAjax()">立即提交</a>
            </div>
        </div>
    </form>
</div>