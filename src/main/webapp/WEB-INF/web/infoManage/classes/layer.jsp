<%@ page contentType="text/html; charset=UTF-8" %>
<script id="list-tpl" type="text/html">
    {{# layui.each(d.classess, function(index, item){ }}
    <tr>
        <td>{{ index+1}}</td>
        <td>{{ item.departmentName}}</td>
        <td>{{ item.level}}</td>
        <td>{{ item.directionName}}</td>
        <td>{{ item.name}}</td>
        <td>
            <shiro:hasPermission name="classes:update">
            <button class="layui-btn layui-btn-mini " style="background: #21a1a1"
                    onclick="classes.update('{{item.id}}','{{item.level}}','{{item.name}}','{{item.departmentId}}','{{item.directionId}}')">
                <i class="layui-icon">&#xe642;</i>修改
            </button>
            </shiro:hasPermission>
            <shiro:hasPermission name="classes:delete">
            <button class="layui-btn layui-btn-mini  layui-btn-danger" onclick="classes.delete('{{item.id}}')">
                <i class="layui-icon">&#xe60a;</i>删除
            </button>
            </shiro:hasPermission>
        </td>
    </tr>
    {{# }); }}

</script>
<div id="add" style="margin: 10px;display: none">
    <form id="add-form" lay-filter="role-add" class="layui-form layui-form-pane" method="post" style="width: 400px">
        <div class="layui-form-item">
            <label class="layui-form-label">年级所属系</label>
            <div class="layui-input-inline">
                <select name="departmentId" lay-filter="department-add" id="department-add">
                    <option value="">请选择一个系</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">年级所属方向</label>
            <div class="layui-input-inline">
                <select name="directionId" id="direction-add">
                    <option value="">请选择一个方向</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">年级代码</label>
            <div class="layui-input-inline">
                <input type="number" name="level" id="level-add"
                       placeholder="请输入年级代码" autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">班级名称</label>
            <div class="layui-input-inline">
                <input type="text" name="name" id="name-add"
                       placeholder="请输入班级名称" autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <a class="layui-btn" onclick="classes.addManualAjax()">立即提交</a>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<div id="update" style="margin: 10px;display: none">
    <form id="update-form" lay-filter="role-add" class="layui-form layui-form-pane" method="post"  style="width: 400px">
        <input type="hidden" id="id" name="id"/>
        <div class="layui-form-item">
            <label class="layui-form-label">年级所属系</label>
            <div class="layui-input-inline">
                <select name="departmentId" lay-filter="department-update" id="department-update">
                    <option value="">请选择一个系</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">年级所属方向</label>
            <div class="layui-input-inline">
                <select name="directionId" id="direction-update">
                    <option value="">请选择一个方向</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">年级代码</label>
            <div class="layui-input-inline">
                <input type="text" id="level" name="level" required jq-verify="required"
                       placeholder="请输入年级代码" autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">班级名称</label>
            <div class="layui-input-inline">
                <input type="text" id="name" name="name" required jq-verify="required"
                       placeholder="请输入班级名称" autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <a class="layui-btn" onclick="classes.updateAjax()">立即提交</a>
            </div>
        </div>
    </form>
</div>