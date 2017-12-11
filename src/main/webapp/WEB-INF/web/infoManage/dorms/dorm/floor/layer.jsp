<%@ page contentType="text/html; charset=UTF-8" %>
<script id="list-tpl" type="text/html">
    {{# layui.each(d.data.pageInfos, function(index, item){ }}
    <tr>
        <td>{{ index+1}}</td>
        <td>{{ item.areaName}}</td>
        <td>{{ item.name}}</td>
        <td>
            <button class="layui-btn layui-btn-mini " style="background: #21a1a1"
                    onclick="floor.update('{{item.id}}','{{item.name}}','{{ item.areaName}}','{{item.area_id}}')">
                <i class="layui-icon">&#xe642;</i>修改
            </button>
            <button class="layui-btn layui-btn-mini  layui-btn-danger" onclick="floor.delete('{{item.id}}')">
                <i class="layui-icon">&#xe60a;</i>删除
            </button>
        </td>
    </tr>
    {{# }); }}
</script>
<script id="list-areas" type="text/html">
    {{# layui.each(d.data.dormInfos, function(index, item){ }}
    <option value="{{item.id}}" class="updateShowAreas">{{item.name}}</option>
    {{# }); }}

</script>
<div id="add" style="margin: 10px;display: none">
    <form id="add-form" lay-filter="role-add" class="layui-form layui-form-pane" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">区</label>
            <div class="layui-input-inline">
                <div class="layui-inline">
                    <div class="layui-input-inline">
                        <select name="modules" lay-verify="required" lay-search="" id="showAreasAdd">
                            <option value="">直接选择或搜索选择</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">楼层</label>
            <div class="layui-input-inline">
                <input id="addFloorName"
                       placeholder="请输入楼层名称" autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <a class="layui-btn" onclick="floor.addAjax()">立即提交</a>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<div id="update" style="margin: 10px;display: none;text-align: center">
    <form id="update-form" lay-filter="role-add" class="layui-form layui-form-pane" method="post">
        <input type="hidden" id="updateFloorId" name="id"/>

        <div class="layui-form-item">
            <label class="layui-form-label">区</label>
            <div class="layui-input-inline">
                <div class="layui-inline">
                    <div class="layui-input-inline">
                        <select name="modules" id="showAreasUpdates">
                            <option value="">直接选择或搜索选择</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">楼层名称</label>
            <div class="layui-input-inline">
                <input type="text" id="updateFloorName" name="name" required jq-verify="required"
                       placeholder="请输入楼层名称" autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <a class="layui-btn" onclick="floor.updateAjax()">立即提交</a>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>