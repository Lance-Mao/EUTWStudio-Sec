<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../../../../../public/tag.jsp" %>

<html>
<head>
    <meta charset="utf-8">
    <title></title>
    <script type="text/javascript" src="${baseurl}/public/common/js/jquery-3.2.0.min.js"></script>
    <script type="text/javascript" src="${baseurl}/public/js/verify/jquery.metadata.js"></script>
    <script type="text/javascript" src="${baseurl}/public/js/verify/jquery.validate.js"></script>
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/layui/css/layui.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/layui/css/layui.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/bootstrap/css/bootstrap.min.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/css/global.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/css/common.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/css/personal.css" media="all">
</head>
<body>

<section class="larry-grid layui-form">
    <div class="larry-personal">
        <div class="layui-tab">
            <form id="update-form1" lay-filter="role-add" class="layui-form layui-form-pane" method="post">
                <blockquote class="layui-elem-quote mylog-info-tit" style="height: 70px">


                    <div class="layui-input-inline">
                        <label class="layui-form-label" style="width: 65px;font-size: 14px">区</label>
                        <div class="layui-inline">
                            <div class="layui-input-inline">
                                <select name="modules" lay-filter="modules_3" lay-verify="required" lay-search=""
                                        id="queryAreas">
                                    <option value="">直接选择或搜索选择</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="layui-input-inline">
                        <label class="layui-form-label" style="width: 65px;font-size: 14px">楼层</label>
                        <div class="layui-inline">
                            <div class="layui-input-inline">
                                <select name="modules1" lay-filter="modules_2" lay-verify="required" lay-search=""
                                        id="queryFloors">
                                    <option value="">直接选择或搜索选择</option>
                                </select>
                            </div>
                        </div>
                    </div>

                    <div class="layui-input-inline">
                        <label class="layui-form-label" style="width: 65px;font-size: 14px">宿舍</label>
                        <div class="layui-inline">
                            <div class="layui-input-inline">
                                <div class="layui-inline">
                                    <input type="text" name="title" id="roomNo" lay-verify="title"
                                           autocomplete="off"
                                           placeholder="宿舍号" value="" class="layui-input">
                                </div>
                                <a class="layui-btn" onclick="currentIndex = 1;room.list()"><i class="layui-icon">&#xe615;</i>搜索</a>
                                <a class="layui-btn " onclick="room.add()"><i class="layui-icon">&#xe61f;</i>添加宿舍
                                </a>
                            </div>
                        </div>
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
                            <th>楼层</th>
                            <th>宿舍号</th>
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
</body>

<%@include file="layer.jsp" %>
<script type="text/javascript" src="${baseurl}/public/common/layui/layui.js"></script>
<script type="text/javascript" src="${baseurl}/js/searchJs.js"></script>
<script type="text/javascript">
    let totalSize = 10;
    let currentIndex = 1;
    let pageSize = 10;
    let room;
    layui.use(['jquery', 'layer', 'element', 'laypage', 'form', 'laytpl', 'tree'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;
        var element = layui.element(),
            form = layui.form(),
            laytpl = layui.laytpl;


        room = {
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
                            room.list();
                        }
                    }
                });
            },
            list: function () {
                var areaId = $("#queryAreas").val();
                var floorId = $("#queryFloors").val();
                var areaName = $("#queryAreas").find("option:selected").text();
                var floorName = $("#queryFloors").find("option:selected").text();
                var roomNo = $("#roomNo").val();
                $.ajax({
                    url: baseUrl + "dorm/room/list",
                    data: {
                        currentIndex: currentIndex,
                        pageSize: pageSize,
                        areaId: areaId,
                        floorId: floorId,
                        roomNo: roomNo,
                        areaName: areaName,
                        floorName: floorName
                    },
                    success: function (data) {
                        if (data.result) {
                            currentIndex = data.data.pageUtil.currentIndex;
                            totalSize = data.data.pageUtil.totalSize;
                            showTotalCount(data.data.pageUtil.totalCount);
                            room.page();
                            laytpl($("#list-tpl").text()).render(data, function (html) {
                                $("#list").html(html);
                            });
                            form.render();
                        }
                    }
                });
            },
            queryAreaAndFloor: function () {
                $.post(baseUrl + "dorm/room/showAreaAndFloorsToQuery", function (data) {
                    if (data.result) {
                        $("#queryAreas").html(room.loadDepartmentOrDirection(data.data.queryAreaOfRoom, "-"))
                        $("#queryFloors").html(room.loadDepartmentOrDirection(data.data.queryFloorOfRoom, "-"))
                    }
                    form.render();
                })
            },
            add: function () {
                $.post(baseUrl + "dorm/room/showAreaAndFloorsToAdd", function (data) {
                    if (data.result) {
                        $("#showAreasAdd").html(room.loadDepartmentOrDirection(data.data.queryAreaOfRoom, "-"))
                        $("#showFloorsAdd").html(room.loadDepartmentOrDirection(data.data.queryFloorOfRoom, "-"))

                    }
                    form.render();
                })
                layer.open({
                    type: 1,
                    area: 'auto',
                    title: '添加'
                    , content: $("#add")
                });

            },
            addAjax: function () {
                var idFloor = $("#showFloorsAdd").val();
                var idArea = $("#showAreasAdd").val();
                let name = $("#addRoomName").val();
                let areaName = $("#showAreasAdd").find("option:selected").text();
                let floorName = $("#showFloorsAdd").find("option:selected").text();

                layer.confirm('确定添加？', {icon: 3, title: '提示'}, function (index) {
                    layer.close(index);
                    $.post(baseUrl + "dorm/room/add", {
                        name: name,
                        floorId: idFloor,
                        areaId: idArea
                    }, function (data) {
                        layer.msg(data.msg);
                        if (data.result) {
                            setTimeout("location.reload()", 500);
                        }
                    })
                })
            },
            update: function (id, name, floorId, areaId) {
                $.post(baseUrl + "dorm/room/showAreaAndFloors", {areaId: areaId}, function (data) {
                    $("#updateRoomName").val(name);
                    $("#updateRoomId").val(id);
                    $("#showAreasUpdate").html(room.loadDepartmentOrDirection(data.data.queryAreaOfRoom, areaId))
                    $("#showFloorsUpdate").html(room.loadDepartmentOrDirection(data.data.queryFloorOfRoom, floorId))
                    form.render()
                    layer.open({
                        type: 1,
                        area: "auto",
                        title: '修改'
                        , content: $("#update")
                    });
                })

            },
            delete: function (id) {
                layer.confirm('确定删除？', {icon: 3, title: '提示'}, function (index) {
                    layer.close(index);
                    $.post(baseUrl + "dorm/room/delete", {id: id}, function (data) {
                        layer.msg(data.msg);
                        setTimeout("location.reload()", 400);
                    })
                });
            },
            updateAjax: function () {
                var idFloor = $("#showFloorsUpdate").val();
                let name = $("#updateRoomName").val();
                let id = $("#updateRoomId").val();
                layer.confirm('确定修改？', {icon: 3, title: '提示'}, function (index) {
                    layer.close(index);
                    $.post(baseUrl + "dorm/room/update", {
                        name: name,
                        id: id,
                        floorId: idFloor
                    }, function (data) {
                        layer.msg(data.msg);

                        if (data.result) {
                            setTimeout("location.reload()", 500);
                        }
                    })
                })
            },
            loadDepartmentOrDirection: function (data, selectId) {
                let _html = `<option value="">请选择</option><option value="">请选择</option>`;
                for (let i = 0; i < data.length; ++i) {
                    if (selectId == data[i].id) {
                        _html += `<option  selected value="` + data[i].id + `">` + data[i].name + `</option>`;
                    } else {
                        _html += `<option value="` + data[i].id + `">` + data[i].name + `</option>`;
                    }
                }

                return _html;
            },
            loadArea: function () {
                $.post(baseUrl + "dorm/area/loadAllArea", function (dataResult) {
                    if (dataResult.result) {
                        var queryAreaOfRoom = dataResult.data.allArea;

                        $("#queryAreas").html(floor.loadDepartmentOrDirection(queryAreaOfRoom), "-")
                        form.render();
                    }
                })
            }
        };
        $(function () {
            room.list();
            room.loadArea();
            room.queryAreaAndFloor()

            form.on('select(modules_1)', function (data) {
                var id = data.value;

                $.post(baseUrl + "dorm/room/showAreaAndFloors", {areaId: data.value}, function (data) {
                    if (data.result) {
                        var queryAreaOfRoom = data.data.queryAreaOfRoom
                        var queryFloorOfRoom = data.data.queryFloorOfRoom

                        $("#showAreasAdd").html(room.loadDepartmentOrDirection(queryAreaOfRoom, id))
                        $("#showFloorsAdd").html(room.loadDepartmentOrDirection(queryFloorOfRoom, "-"))

                        form.render();
                    }
                })
            })

            form.on('select(modules_2)', function (data) {
                var id = data.value;

                $.post(baseUrl + "dorm/room/showAreaAndFloors", {areaId: data.value}, function (data) {
                    if (data.result) {
                        var queryAreaOfRoom = data.data.queryAreaOfRoom
                        var queryFloorOfRoom = data.data.queryFloorOfRoom

                        $("#showAreasUpdate").html(room.loadDepartmentOrDirection(queryAreaOfRoom, id))
                        $("#showFloorsUpdate").html(room.loadDepartmentOrDirection(queryFloorOfRoom, "-"))

                        form.render();
                    }
                })
            })

            form.on('select(modules_3)', function (data) {
                var id = data.value;

                $.post(baseUrl + "dorm/room/showAreaAndFloors", {areaId: data.value}, function (data) {
                    if (data.result) {
                        var queryAreaOfRoom = data.data.queryAreaOfRoom
                        var queryFloorOfRoom = data.data.queryFloorOfRoom

                        $("#queryAreas").html(room.loadDepartmentOrDirection(queryAreaOfRoom, id))
                        $("#queryFloors").html(room.loadDepartmentOrDirection(queryFloorOfRoom), "-")
                        form.render();
                    }
                })
            })
        });
    });

</script>

</html>
