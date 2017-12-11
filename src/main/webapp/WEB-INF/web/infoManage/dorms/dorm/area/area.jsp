<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../../../../../public/tag.jsp" %>

<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <script type="text/javascript" src="${baseurl}/public/common/js/jquery-3.2.0.min.js"></script>
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/layui/css/layui.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/layui/css/layui.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/bootstrap/css/bootstrap.min.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/css/global.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/css/common.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/css/personal.css" media="all">
</head>
<body>
<section class="larry-grid">

    <div class="larry-personal">
        <div class="layui-tab">

            <form id="update-form1" lay-filter="role-add" class="layui-form layui-form-pane" method="post">
                <blockquote class="layui-elem-quote mylog-info-tit" style="height: 70px">
                    <div class="layui-form-item">
                        <div class="layui-input-inline">
                            <div class="layui-inline">
                                <div class="layui-input-inline">
                                    <select name="modules" lay-filter="modules_1" lay-verify="required" lay-search=""
                                            id="queryAreas">
                                        <option value="">直接选择或搜索选择</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <a class="layui-btn" onclick="currentIndex = 1;area.list()"><i class="layui-icon">&#xe615;</i>搜索</a>
                        <a class="layui-btn " onclick="area.add()"><i class="layui-icon">&#xe61f;</i>添加区
                        </a>
                    </div>
                </blockquote>
            </form>


            <div class="larry-separate"></div>

            <div class="layui-tab-content larry-personal-body clearfix mylog-info-box">
                <div class="layui-form ">
                    <table id="example" class="layui-table lay-even " data-name="articleCatData">
                        <thead>
                        <tr>
                            <th>序号</th>
                            <th>区</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody id="list">
                        </tbody>
                    </table>

                </div>
                <div id="demo1"></div>
            </div>
        </div>
    </div>
</section>
<script src="${baseurl}/js/searchJs.js"></script>
<script id="list-tpl" type="text/html">
    {{# layui.each(d.data.pageInfos, function(index, item){ }}
    <tr>
        <td>{{ index+1}}</td>
        <td>{{ item.name}}</td>
        <td>
            <button class="layui-btn layui-btn-mini " style="background: #21a1a1"
                    onclick="area.update('{{item.id}}','{{item.name}}')">
                <i class="layui-icon">&#xe642;</i>修改
            </button>
            <button class="layui-btn layui-btn-mini  layui-btn-danger" onclick="area.delete('{{item.id}}')">
                <i class="layui-icon">&#xe60a;</i>删除
            </button>
        </td>
    </tr>
    {{# }); }}

</script>
<div id="add" style="margin: 10px;display: none">
    <form id="add-form" lay-filter="role-add" class="layui-form layui-form-pane" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">区名称</label>
            <div class="layui-input-inline">
                <input type="text" id="addAreaName"
                       placeholder="请输入区名称" autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <a class="layui-btn" onclick="area.addAjax()">立即提交</a>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<div id="update" style="margin: 10px;display: none">
    <form id="update-form" lay-filter="role-add" class="layui-form layui-form-pane" method="post">
        <input type="hidden" id="updateAreaId" name="id"/>

        <div class="layui-form-item">
            <label class="layui-form-label">区名称</label>
            <div class="layui-input-inline">
                <input type="text" id="updateAreaName" name="name" required jq-verify="required"
                       placeholder="请输入区名称" autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <a class="layui-btn" onclick="area.updateAjax()">立即提交</a>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript" src="${baseurl}/public/common/layui/layui.js"></script>
<script type="text/javascript">
    let totalSize = 10;
    let currentIndex = 1;
    let pageSize = 10;
    let area;
    layui.use(['jquery', 'layer', 'element', 'laypage', 'form', 'laytpl', 'tree'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;
        var element = layui.element(),
            form = layui.form(),
            laytpl = layui.laytpl;


        area = {
            page: function () {
                layui.laypage({
                    cont: 'demo1',
                    pages: totalSize, //总页数
                    last: totalSize, //总页数
                    curr: currentIndex,
                    groups: 5,//连续显示分页数
                    skin: '#1E9FFF',
                    jump: function (obj, first) {
                        currentIndex = obj.curr;
                        if (!first) {
                            area.list();
                        }
                    }
                });
            },
            list: function () {
                let areaId = $("#queryAreas").val();
                let areaName = $("#queryAreas").find("option:selected").text();
                $.ajax({
                    url: baseUrl + "dorm/area/list",
                    data: {
                        currentIndex: currentIndex,
                        pageSize: pageSize,
                        areaId: areaId,
                        areaName: areaName
                    },
                    success: function (data) {
                        if (data.result) {
                            currentIndex = data.data.pageUtil.currentIndex;
                            totalSize = data.data.pageUtil.totalSize;
                            showTotalCount(data.data.pageUtil.totalCount);
                            area.page();
                            laytpl($("#list-tpl").text()).render(data, function (html) {
                                $("#list").html(html);
                            });
                            form.render();
                        }
                        area.queryAreas();
                    }
                });
            },
            queryAreas: function () {
                $.post(baseUrl + "dorm/room/showAreaAndFloorsToQuery", function (data) {
                    if (data.result) {
                        $("#queryAreas").html(area.loadSelectElementHtml(data.data.queryAreaOfRoom, "-"))
                    }
                    form.render();
                })
            },
            loadSelectElementHtml: function (data, type) {
                let _html = `<option value=''></option><option value=''>请选择</option>`;
                for (let i = 0; i < data.length; ++i) {
                    let isSelected = data[i].id == type ? "selected" : "";
                    _html += ` <option ` + isSelected + `  value="` + data[i].id + `">` + data[i].name + `</option>`;
                }

                return _html;
            },
            add: function () {
                layer.open({
                    type: 1,
                    title: '添加'
                    , content: $("#add")
                });

            },
            addAjax: function () {
                let name = $("#addAreaName").val();
                layer.confirm('确定添加？', {icon: 3, title: '提示'}, function (index) {
                    layer.close(index);
                    $.post(baseUrl + "dorm/area/add", {
                        name: name
                    }, function (data) {
                        layer.msg(data.msg);
                        if (data.result) {
                            setTimeout("location.reload()", 500);
                        }
                    })
                })
            },
            update: function (id, name) {
                $("#updateAreaName").val(name);
                $("#updateAreaId").val(id);
                layer.open({
                    type: 1,
                    title: '修改'
                    , content: $("#update")
                });
            },
            delete: function (id) {
                layer.confirm('确定删除？', {icon: 3, title: '提示'}, function (index) {
                    layer.close(index);
                    $.post(baseUrl + "dorm/area/delete", {id: id}, function (data) {
                        layer.msg(data.msg);
                        setTimeout("location.reload()", 400);
                    })
                });
            },
            updateAjax: function () {
                let name = $("#updateAreaName").val();
                let id = $("#updateAreaId").val();
                layer.confirm('确定修改？', {icon: 3, title: '提示'}, function (index) {
                    layer.close(index);
                    $.post(baseUrl + "dorm/area/update", {
                        name: name,
                        id: id
                    }, function (data) {
                        layer.msg(data.msg);

                        if (data.result) {
                            setTimeout("location.reload()", 500);
                        }
                    })
                })
            }
        };
        $(function () {
            area.list();
        });
    });

</script>
</body>
</html>
