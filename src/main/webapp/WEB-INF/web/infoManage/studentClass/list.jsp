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
<section class="larry-grid layui-form">
    <div class="larry-personal">
        <div class="layui-tab">
            <blockquote class="layui-elem-quote mylog-info-tit" style="height: 140px" ;>
                <div class="layui-form-item">
                    <div class="layui-input-inline">
                        <div class="layui-inline">
                            <div class="layui-input-inline">
                                <select lay-filter="profession" id="profession_search">
                                    <option value="">专业</option>

                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-input-inline">
                        <div class="layui-inline">
                            <div class="layui-input-inline">
                                <select lay-filter="direction" id="direction_search">
                                    <option value="">方向</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-input-inline">
                        <div class="layui-inline">
                            <div class="layui-input-inline">
                                <select id="level_search" lay-filter="level">
                                    <option value="">年级</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-input-inline">
                        <div class="layui-inline">
                            <div class="layui-input-inline">
                                <select id="classes_search">
                                    <option value="">班级</option>
                                </select>
                            </div>
                        </div>
                    </div>

                </div>
                <div class="layui-form-item">
                    <div class="layui-input-inline">
                        <div class="layui-inline">
                            <div class="layui-input-inline">
                                <input type="text" name="title" id="no_search" lay-verify="title" autocomplete="off"
                                       placeholder="学号" class="layui-input">
                            </div>
                        </div>

                    </div>
                    <div class="layui-input-inline">
                        <div class="layui-inline">
                            <div class="layui-input-inline">
                                <input type="text" name="title" id="name_search" lay-verify="title" autocomplete="off"
                                       placeholder="姓名" class="layui-input">
                            </div>
                        </div>

                    </div>
                    <a class="layui-btn" onclick="studentClass.list()"><i class="layui-icon">&#xe615;</i>搜索</a>

                </div>
            </blockquote>
            <div class="larry-separate"></div>
            <div class="layui-tab-content larry-personal-body clearfix mylog-info-box">
                <a class="layui-btn" onclick="studentClass.distributeDirection()"><i class="layui-icon">&#xe630;</i>就业方向</a>
                <a id="classid" class="layui-btn" onclick="studentClass.add()"><i class="layui-icon">&#xe630;</i>班级选择</a>
                <a class="layui-form-mid layui-word-aux">请先勾选学生</a>
                <div class="layui-form">
                    <table class="layui-table">
                        <thead>
                        <tr>
                            <th><input type="checkbox" lay-filter="checkedAll" name="" lay-skin="primary"
                                       lay-filter="allChoose"></th>
                            <th>学号</th>
                            <th>姓名</th>
                            <th>性别</th>
                            <th>方向</th>
                            <th>专业</th>
                            <th>班级</th>
                        </tr>
                        </thead>
                        <tbody id="list">

                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</section>
</body>
<script id="list-tpl" type="text/html">
    {{# layui.each(d.data.studentClass, function(index, item){ }}
    <tr>
        <th><input type="checkbox" value="{{item.no}}-{{item.name}}" class="no_checkbox" name="" lay-skin="primary"
        ></th>
        <td>{{ item.no}}</td>
        <td>{{ item.name}}</td>
        <td>{{# if(item.gender === 'F'){ }}
            女
            {{# }else{ }}
            男
            {{#}}}
        </td>
        <td> {{# if(item.direction === undefined){ }}
            无
            {{# }else{ }}
            {{ item.direction}}
            {{#}}}
        </td>
        <td>
            {{# if(item.profession === undefined){ }}
            无
            {{# }else{ }}
            {{ item.profession}}
            {{#}}}
        </td>
        <td>
            {{# if(item.classesName === undefined){ }}
            无
            {{# }else{ }}
            {{ item.classesName}}
            {{#}}}
        </td>
    </tr>
    {{# }); }}

</script>
<div id="add" style="margin: 10px;display: none">
    <form id="add-form" class="layui-form layui-form-pane" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">选择一个班级</label>
            <div class="layui-input-inline">
                <select id="classess">
                    <option value="0">请选择</option>
                </select>
            </div>
        </div>
        <div id="studentClasss">

        </div>
        <div class="layui-form-item" style="margin-top: 30px">
            <div class="layui-input-block">
                <a class="layui-btn" onclick="studentClass.addAjax()">立即提交</a>
            </div>
        </div>
    </form>
</div>
<div id="distribute_direction" style="margin: 10px;display: none">
    <form id="direction-form" class="layui-form layui-form-pane" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">选择专业方向</label>
            <div class="layui-input-inline">
                <select id="directions">
                    <option value="0">请选择</option>
                </select>
            </div>
        </div>
        <div class="layui-form-item" style="margin-top: 30px">
            <div class="layui-input-block">
                <a class="layui-btn" onclick="studentClass.distributeDirectionAjax()">立即提交</a>
            </div>
        </div>
    </form>
</div>
<script src="${baseurl}/js/searchJs.js"></script>
<script type="text/javascript" src="${baseurl}/public/common/layui/layui.js"></script>
<script type="text/javascript">
    let studentClass;
    let selectStudents;
    layui.use(['jquery', 'layer', 'element', 'form', 'laytpl'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;
        var element = layui.element(),
            form = layui.form(),
            laytpl = layui.laytpl;


        studentClass = {

            list: function () {
                let data = {
                    name: $("#name_search").val(),
                    studentNo: $("#no_search").val(),
                    directionId: $("#direction_search").val(),
                    professionId: $("#profession_search").val(),
                    level: $("#level_search").val(),
                    classesId: $("#classes_search").val()
                };
                layer.msg("查询中...");
                $.ajax({
                    url: baseUrl + "/studentClass/list",
                    data: data,
                    type: "post",
                    success: function (data) {
                        if (data.result) {
                            let stus = data.data.studentClass;
                            $("#totalCount").remove();
                            $("#classid").after(`<a class=" layui-word-aux" id="totalCount">总记录数`+stus.length+`</a>`);
                            laytpl($("#list-tpl").text()).render(data, function (html) {
                                $("#list").html(html);
                            });
                            form.render();

                        }
                    }
                });
            },
            loadSelectElementHtml: function (data) {
                let _html = "";
                for (let i = 0; i < data.length; ++i) {
                    _html += ` <option  value="` + data[i].id + `">` + data[i].name + `</option>`;
                }

                return _html;
            },
            add: function () {
                let _html = "";
                let selectStudents = $(".no_checkbox:checked");
                if (selectStudents.length === 0) {
                    layer.msg("请先勾选学生");
                    return false;
                }
                _html += `<label class="layui-form-label" style="margin-bottom: 20px">一共` + selectStudents.length + `人</label>`
                for (let i = 0; i < selectStudents.length; ++i) {
                    let val = $(selectStudents[i]).val().split("-");
                    _html += `<input type="checkbox" class="hasSelected" value="` + val[0] + `" title="` + val[1] + `" checked>`;
                }
                $("#studentClasss").html(_html);

                $.post(baseUrl + "/studentClass/loadTeacherHasClassess", function (data) {
                    if (data.result) {
                        $("#classess").html("<option value='0'>班级</option>" + studentClass.loadSelectElementHtml(data.data));
                        form.render();
                        layer.open({
                            type: 1,
                            title: '添加',
                            area: ["100%", "100%"]
                            , content: $("#add")
                        });
                    }
                })
            },
            distributeDirection: function () {
                selectStudents = $(".no_checkbox:checked");
                if (selectStudents.length === 0) {
                    layer.msg("请先勾选学生");
                    return false;
                }

                $.post(baseUrl + "/direction/all", function (data) {
                    if (data.result) {
                        $("#directions").html(studentClass.loadSelectElementHtml(data.data));
                        form.render();
                        layer.open({
                            type: 1,
                            title: '专业方向',
                            area: ["100%", "100%"]
                            , content: $("#distribute_direction")
                        });
                    } else {
                        layer.msg(data.msg);
                    }
                })
            },
            distributeDirectionAjax: function () {
                let directionId = $("#directions").val();

                let studentClassIds = "";
                for (let i = 0; i < selectStudents.length; ++i)studentClassIds += $(selectStudents[i]).val().split("-")[0] + ",";
                console.log(studentClassIds);
                let data = {
                    directionId: directionId,
                    studentIds: studentClassIds
                }
                let msg = "确定分配" + selectStudents.length + "个学生到该方向?"
                layer.confirm(msg, {icon: 3, title: '提示'}, function (index) {
                    layer.close(index);
                    $.post(baseUrl + "/studentClass/distributedDirection", data, function (data) {
                        layer.msg(data.msg);
                        if (data.result) {
                            setTimeout("location.reload()", 500);
                        }
                    })
                });

            },
            addAjax: function () {
                let classesId = $("#classess").val();
                if (classesId == "0") {
                    layer.msg("请选择一个班级");
                    return false;
                }
                let studentClassIds = "";
                let selectStudents = $(".hasSelected:checked");
                for (let i = 0; i < selectStudents.length; ++i)studentClassIds += $(selectStudents[i]).val() + ",";
                let data = {
                    classesId: classesId,
                    studentIds: studentClassIds
                }
                let msg = "确定分配" + selectStudents.length + "个学生到该年级?"
                layer.confirm(msg, {icon: 3, title: '提示'}, function (index) {
                    layer.close(index);
                    $.post(baseUrl + "/studentClass/distributedClass", data, function (data) {
                        layer.msg(data.msg);
                        if (data.result) {
                            setTimeout("location.reload()", 500);
                        }
                    })
                });

            },
            loadAllDirections: function () {
                $.post(baseUrl + "/communication/queryDirectionByDepartment", function (data) {
                    if (data.result) {
                        $("#direction_search").html(`<option value="">方向</option>`).append(loadOptionsHtml(data.data, "-"))
                    }
                    form.render();
                })
            },
            loadAllProfessions: function () {
                $.post(baseUrl + "/profession/all", function (data) {
                    if (data.result) {
                        $("#profession_search").html(`<option value="">专业</option>`).append(loadOptionsHtml(data.data, "-"))
                    }
                    form.render();
                })
            },
            loadClassessByDirectionId: function (id) {
            $.post(baseUrl + "/studentClass/queryClassesByDirectionId", {id: id}, function (data) {
                if (data.result) {
                    $("#classes_search").html(`<option value="">班级</option>`).append(loadOptionsHtml(data.data, "-"))
                }
                form.render();
            })
        }
        };
        $(function () {
            loadAllLevels();
            studentClass.loadAllDirections();
            studentClass.loadAllProfessions();
            form.render();
//            studentClass.list();

            form.on('checkbox(checkedAll)', function (data) {
                $(".no_checkbox").prop({checked: data.elem.checked});
                form.render();
            });
            form.on('select(direction)', function (data) {
                studentClass.loadClassessByDirectionId(data.value);
            });
        });
    });


</script>

</html>
