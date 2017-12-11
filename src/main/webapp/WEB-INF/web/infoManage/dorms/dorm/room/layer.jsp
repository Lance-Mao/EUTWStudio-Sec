<%@ page contentType="text/html; charset=UTF-8" %>
<script id="list-tpl" type="text/html">
    {{# layui.each(d.data.pageInfos, function(index, item){ }}
    <tr>
        <td>{{ index+1}}</td>
        <td>{{ item.areaName}}</td>
        <td>{{ item.floorName}}</td>
        <td>{{ item.name}}</td>
        <td>
            <button class="layui-btn layui-btn-mini " style="background: #21a1a1"
                    onclick="room.update('{{item.id}}','{{item.name}}','{{item.floor_id}}','{{item.areaId}}')">
                <i class="layui-icon">&#xe642;</i>修改
            </button>
            <button class="layui-btn layui-btn-mini  layui-btn-danger" onclick="room.delete('{{item.id}}')">
                <i class="layui-icon">&#xe60a;</i>删除
            </button>
        </td>
    </tr>
    {{# }); }}

</script>
<div id="add" style="margin: 10px;display: none">
    <form id="add-form" lay-filter="role-add" class="layui-form layui-form-pane" method="post">

        <div class="layui-form-item">
            <label class="layui-form-label">区</label>
            <div class="layui-input-inline">
                <div class="layui-inline">
                    <div class="layui-input-inline">
                        <select name="modules" lay-filter="modules_1" lay-verify="required" lay-search="" id="showAreasAdd">
                            <option value="">直接选择或搜索选择</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">楼层</label>
            <div class="layui-input-inline">
                <div class="layui-inline">
                    <div class="layui-input-inline">
                        <select name="modules" lay-verify="required" lay-search="" id="showFloorsAdd">
                            <option value="">直接选择或搜索选择</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>


        <div class="layui-form-item">
            <label class="layui-form-label">宿舍</label>
            <div class="layui-input-inline">
                <input type="text" id="addRoomName"
                       placeholder="请输入宿舍号" autocomplete="off" class="layui-input" lay-verify="roomNo" name="roomNo" data-required data-min="3" data-max="12">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <a class="layui-btn" onclick="room.addAjax()">立即提交</a>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<div id="update" style="margin: 10px;display: none">
    <form id="update-form" lay-filter="role-add" class="layui-form layui-form-pane" method="post">
        <input type="hidden" id="updateRoomId" name="id"/>

        <div class="layui-form-item">
            <label class="layui-form-label">区</label>
            <div class="layui-input-inline">
                <div class="layui-inline">
                    <div class="layui-input-inline">
                        <select name="modules" lay-filter="modules_2" lay-verify="required" lay-search="" id="showAreasUpdate">
                            <option value="">直接选择或搜索选择</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">楼层</label>
            <div class="layui-input-inline">
                <div class="layui-inline">
                    <div class="layui-input-inline">
                        <select name="modules" lay-verify="required" lay-search="" id="showFloorsUpdate">
                            <option value="">直接选择或搜索选择</option>
                        </select>
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">宿舍</label>
            <div class="layui-input-inline">
                <input type="text" id="updateRoomName" name="name" required jq-verify="required"
                       placeholder="请输入宿舍号" autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <a class="layui-btn" onclick="room.updateAjax()">立即提交</a>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>