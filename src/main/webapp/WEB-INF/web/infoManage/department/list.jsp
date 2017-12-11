<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../../../public/tag.jsp" %>

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
            <blockquote class="layui-elem-quote mylog-info-tit" style="height: 70px";>
                <shiro:hasPermission name="department:add">
                    <ul class="layui-tab-title">
                        <li class="layui-btn " onclick="department.add()"><i class="layui-icon">&#xe61f;</i>添加系
                        </li>
                    </ul>
                </shiro:hasPermission>
            </blockquote>
            <div class="larry-separate"></div>

            <div class="layui-tab-content larry-personal-body clearfix mylog-info-box">
                <div class="layui-form ">
                    <table id="example" class="layui-table lay-even " data-name="articleCatData">
                        <thead>
                        <tr>
                            <th>序号</th>
                            <th>系代码</th>
                            <th>系名称</th>
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
<script type="text/javascript">
    let totalSize = 10;
    let currentIndex = 1;
    let pageSize = 10;
    let department;
    layui.use(['jquery', 'layer', 'element', 'laypage', 'form', 'laytpl', 'tree'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;
        var element = layui.element(),
            form = layui.form(),
            laytpl = layui.laytpl;


        department = {
            page: function () {
                layui.laypage({
                    cont: 'demo1',
                    pages: totalSize, //总页数
                    curr: currentIndex,
                    groups: 5,//连续显示分页数
                    skin: '#1E9FFF',
                    jump: function (obj, first) {
                        currentIndex = obj.curr;
                        if (!first) {
                            department.list();
                        }
                    }
                });
            },
            list: function () {
                $.ajax({
                    url: baseUrl + "/department/list",
                    data: {currentIndex: currentIndex, pageSize: pageSize},
                    success: function (data) {
                        if (data.result) {
                            currentIndex = data.page.currentIndex;
                            totalSize = data.page.totalSize;
                            department.page();
                            laytpl($("#list-tpl").text()).render(data, function (html) {
                                $("#list").html(html);
                            });
                            form.render();
                        }
                    }
                });
            },
            add: function () {
                $.post(baseUrl + "/department/professionAndDirectionData", function (data) {
                    layer.msg(data.msg);
                    if (data.result) {
                        console.log(data)
                        let _html = "";
                        let professions = data.data.professions;
                        let directions = data.data.directions;
                        professions.forEach(profession => {
                            let id = profession.id;
                            let name = profession.name;
                            let isDisable = (profession.departmentId) == null ? "" : "disabled";
                            _html += `<input type="checkbox" class="profession-add" value="` + id + `" title="` + name + `" ` + isDisable + `>`;
                        });
                        $("#professions-add").html(_html);
                        _html = "";
                        directions.forEach(direction => {
                            let id = direction.id;
                            let name = direction.name;
                            let isDisable = (direction.departmentId) == null ? "" : "disabled";
                            _html += `<input type="checkbox" class="direction-add" value="` + id + `" title="` + name + `" ` + isDisable + `>`;
                        });
                        $("#directions-add").html(_html);
                        form.render();
                        layer.open({
                            type: 1,
                            title: '添加',
                            area: ['100%', '100%'],
                            content: $("#add")
                        });
                    }
                });
            },
            update: function (id, code, name) {
                $("#id").val(id);
                $("#code-update").val(code);
                $("#name-update").val(name);
                $.post(baseUrl + "/department/fullProfessionAndDirectionData", {id: id}, function (data) {
                    if (data.result) {
                        console.log(data);
                        let _html = "";
                        let professions = data.data.professions;
                        let directions = data.data.directions;
                        for (let i = 0; i < professions.length; ++i) {
                            let profession = professions[i];
                            let id = profession.id;
                            let name = profession.name;
                            let isDisable = profession.departmentId;
                            _html += `<input type="checkbox" class="profession-update" value="` + id + `" title="` + name + `" ` + isDisable + `>`;
                        }
                        ;
                        $("#professions-update").html(_html);
                        _html = "";
                        for (let i = 0; i < directions.length; ++i) {
                            let direction = directions[i];
                            let id = direction.id;
                            let name = direction.name;
                            let isDisable = direction.departmentId;
                            _html += `<input type="checkbox" class="direction-update" value="` + id + `" title="` + name + `" ` + isDisable + `>`;
                        }

                        $("#directions-update").html(_html);
                        form.render();
                        layer.open({
                            type: 1,
                            title: '修改',
                            area: ['100%', '100%'],
                            content: $("#update")
                        });
                    } else {
                        layer.msg(data.msg)
                    }
                })
            },
            delete: function (id) {
                layer.confirm('确定删除？', {icon: 3, title: '提示'}, function (index) {
                    layer.close(index);
                    $.post(baseUrl + "/department/delete", {id: id}, function (data) {
                        layer.msg(data.msg);
                        setTimeout("location.reload()", 500);
                    })
                });
            }
            ,
            addAjax: function () {
                let professionsIds = "";
                let directionIds = "";
                let code = $("#code-add").val();
                let name = $("#name-add").val();
                let professions = $(".profession-add");
                let directions = $(".direction-add");
                for (let i = 0; i < professions.length; ++i) {
                    if ($(professions[i]).prop("checked")) professionsIds += $(professions[i]).val() + ",";
                }
                for (let i = 0; i < directions.length; ++i) {
                    if ($(directions[i]).prop("checked")) directionIds += $(directions[i]).val() + ",";
                }

                $.post(baseUrl + "/department/add", {
                    code: code,
                    name: name,
                    professionsIds: professionsIds,
                    directionsIds: directionIds
                }, function (data) {
                    layer.msg(data.msg);
                    if (data.result) {
                        setTimeout("location.reload()", 500);
                    }
                })
            }
            ,
            updateAjax: function () {
                let professionsIds = "";
                let directionIds = "";
                let id = $("#id").val();
                let code = $("#code-update").val();
                let name = $("#name-update").val();
                let professions = $(".profession-update");
                let directions = $(".direction-update");
                for (let i = 0; i < professions.length; ++i) {
                    if ($(professions[i]).prop("checked")) professionsIds += $(professions[i]).val() + ",";
                }
                for (let i = 0; i < directions.length; ++i) {
                    if ($(directions[i]).prop("checked")) directionIds += $(directions[i]).val() + ",";
                }

                $.post(baseUrl + "/department/update", {
                    id: id,
                    code: code,
                    name: name,
                    professionsIds: professionsIds,
                    directionsIds: directionIds
                }, function (data) {
                    layer.msg(data.msg);
                    if (data.result) {
                        setTimeout("location.reload()", 500);
                    }
                })
            }
        }
        ;
        $(function () {
            department.list();
        });
    })
    ;


</script>

</html>
