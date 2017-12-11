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
                <shiro:hasPermission name="trainProgram:add">
                <ul class="layui-tab-title">
                    <li class="layui-btn " onclick="trainProgram.add()"><i class="layui-icon">&#xe61f;</i>添加方案
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
                            <th>年级</th>
                            <th>系名称</th>
                            <th>就业方向</th>
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
    let trainProgram;
    layui.use(['jquery', 'layer', 'element', 'laypage', 'form', 'laytpl', 'tree'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;
        var element = layui.element(),
            form = layui.form(),
            laytpl = layui.laytpl;


        trainProgram = {
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
                            trainProgram.list();
                        }
                    }
                });
            },
            list: function () {
                $.ajax({
                    url: baseUrl + "/trainProgram/list",
                    data: {currentIndex: currentIndex, pageSize: pageSize},
                    success: function (data) {
                        if (data.result) {
                            currentIndex = data.page.currentIndex;
                            totalSize = data.page.totalSize;
                            trainProgram.page();
                            laytpl($("#list-tpl").text()).render(data, function (html) {
                                $("#list").html(html);
                            });
                            form.render();
                        }
                    }
                });
            },
            clearHtml: function () {
                $("#modelCourses-add").html("");
                $("#modelCourses-update").html("");
                $("#modelCourses-preview").html("");
            },
            add: function () {
                trainProgram.clearHtml();
                $.post(baseUrl + "/trainProgram/loadDepartmentsAndDirectionsAndModuleCourses", function (data) {
                    if (data.result) {
                        console.log(data)
                        $("#level").html(trainProgram.loadLevel());
                        $("#department").html(trainProgram.loadDepartmentOrDirection(data.data.departments));
                        $("#direction").html(trainProgram.loadDepartmentOrDirection(data.data.directions));
                        $("#modelCourses-add").html(trainProgram.loadModuleCourse(data.data.moduleCourses));

                        form.render();
                        layer.open({
                            type: 1,
                            title: '添加',
                            area: ["100%", "100%"]
                            , content: $("#add")
                        });
                    } else {
                        layer.msg(data.msg)
                    }
                });
            },
            update: function (id, level, department, direction) {
                trainProgram.clearHtml();
                $("#id").val(id);
                $("#level-update").val(level);
                $("#department-update").val(department);
                $("#direction-update").val(direction);

                $.post(baseUrl + "/trainProgram/loadModuleCoursesByProgram", {id: id}, function (data) {
                    if (data.result) {
                        $("#modelCourses-update").html(trainProgram.loadModuleCourse(data.data));
                        form.render();
                        layer.open({
                            type: 1,
                            title: '修改',
                            area: ["100%", "100%"]
                            , content: $("#update")
                        });
                    } else {
                        layer.msg(data.msg);
                    }
                });

            },
            delete: function (id) {
                layer.confirm('确定删除？', {icon: 3, title: '提示'}, function (index) {
                    layer.close(index);
                    $.post(baseUrl + "/trainProgram/delete", {id: id}, function (data) {
                        layer.msg(data.msg);
                        setTimeout("location.reload()", 500);
                    })
                });
            },
            preview: function (id, level, department, direction) {
                let title = `西安欧亚学院高职学院` + department + level + `级` + direction + `方向人才培养方案`;
                $("#title-preview").text(title);

                $.post(baseUrl + "/trainProgram/loadModuleCoursesByProgram", {id: id}, function (data) {
                    if (data.result) {
                        $("#modelCourses-preview").html(`
                            <tr >
                            <th >课程模块</th>
                            <th style="width: 60px">序号</th>
                            <th>课程代码</th>
                            <th style="width: 300px">课程名称</th>
                            <th>课程学分</th>
                            <th>学时</th>
                            <th>课程性质</th>
                            <th>考试方式</th>
                            <th>课程简介</th>
                            <th>教师简介</th>
                            </tr>`);
                        $("#modelCourses-preview").append(trainProgram.loadHasModuleCourse(data.data));
                        form.render();
                        layer.open({
                            type: 1,
                            title: '预览',
                            area: ["100%", "100%"]
                            , content: $("#preview")
                        });
                    } else {
                        layer.msg(data.msg);
                    }
                });

            },
            addAjax: function () {
                let data = $("#add-form").serialize();

                let moduleCoursesStr = trainProgram.getModuleCoursesStr();
                data += "&moduleCoursesStr=" + moduleCoursesStr;
                $.post(baseUrl + "/trainProgram/add", data, function (data) {
                    layer.msg(data.msg);
                    if (data.result) {
                        setTimeout("location.reload()", 500);
                    }
                })
            },
            updateAjax: function () {
                let id = $("#id").val();
                let moduleCoursesStr = trainProgram.getModuleCoursesStr();
                let data = {
                    id: id,
                    moduleCoursesStr: moduleCoursesStr
                }
                $.post(baseUrl + "/trainProgram/update", data, function (data) {
                    layer.msg(data.msg);
                    if (data.result) {
                        setTimeout("location.reload()", 500);
                    }

                })
            },
            loadDepartmentOrDirection: function (data) {
                let _html = "";
                for (let i = 0; i < data.length; ++i)
                    _html += `<option value="` + data[i].id + `">` + data[i].name + `</option>`;

                return _html;
            },
            loadModuleCourse: function (moduleCourses) {
                let totalHtml = "";
                let _html = "";
                let moduleId = moduleCourses.length === 0 ? 0 : moduleCourses[0].id;
                for (let i = 0; i < moduleCourses.length; ++i) {
                    let isChecked = moduleCourses[i].isChecked == "checked" ? "checked" : "";
                    if (moduleCourses[i].id !== moduleId) {
                        totalHtml += `<div class="modules"  data='` + moduleId + `'> <div class="layui-form-item">
                                          <label class="layui-form-label " style="margin-left: 5%">` + moduleCourses[i - 1].moduleName + `</label>

                                             <div class="layui-input-block" >`
                            + _html + `
                                             </div>
                                       </div></div>`;

                        moduleId = moduleCourses[i].id;
                        _html = ` <input class="course" type="checkbox" ` + isChecked + ` value="` + moduleCourses[i].courseId + `" title="` + moduleCourses[i].courseName + `" >`
                    } else {
                        _html += ` <input class="course" type="checkbox" ` + isChecked + ` value="` + moduleCourses[i].courseId + `" title="` + moduleCourses[i].courseName + `" >`
                    }
                    if (i === moduleCourses.length - 1 && moduleCourses[i].id === moduleId) {
                        totalHtml += ` <div class="modules"  data='` + moduleId + `'> <div class="layui-form-item">
                                          <label class="layui-form-label "  style="margin-left: 5%">` + moduleCourses[i].moduleName + `</label>
                                             <div class="layui-input-block" >`
                            + _html + `
                                             </div>
                                       </div></div>`;
                    }
                }
                return totalHtml;
            },
            loadHasModuleCourse: function (allModuleCourses) {
                let electiveSocre = 0, compulsorySocre = 0;
                let no = 1;

                let moduleCourses = [];
                for (let i = 0; i < allModuleCourses.length; ++i)
                    if (allModuleCourses[i].isChecked == "checked") moduleCourses.push(allModuleCourses[i]);
                let totalHtml = "";
                let _html = "";
                let moduleId = moduleCourses.length === 0 ? 0 : moduleCourses[0].id;
                for (let i = 0; i < moduleCourses.length; ++i) {
                    moduleCourses[i].nature === "选修" ? electiveSocre += moduleCourses[i].schoolScore : compulsorySocre += moduleCourses[i].schoolScore;

                        moduleId = moduleCourses[i].id;
                    totalHtml += ` <tr>
                                            <th > ` + moduleCourses[i].moduleName + `</th>
                                            <th > ` + (no++) + `</th>
                                            <th>` + moduleCourses[i].code + `</th>
                                            <th>` + moduleCourses[i].courseName + `</th>
                                            <th>` + moduleCourses[i].schoolScore + ` 学分</th>
                                            <th>` + moduleCourses[i].schoolHours + ` 课时</th>
                                            <th>` + moduleCourses[i].nature + `</th>
                                            <th>` + (moduleCourses[i].testMethodName!==undefined ?moduleCourses[i].testMethodName:"暂无") + `</th>
                                            <th> 查看 </th>
                                            <th> 查看 </th>
                                  </tr>`
                }

                $("#electiveScore").text(electiveSocre);
                $("#compulsoryScore").text(compulsorySocre);
                $("#totalScore").text(compulsorySocre + electiveSocre);
                return totalHtml;
            },
            loadLevel: function () {
                let currentYear = new Date().getFullYear();
                let _html = "";
                for (let i = -2; i < 3; ++i) {
                    let next = currentYear+i;
                    _html += `<option value="` + next + `">` + next + `</option>`;
                }

                return _html;
            },
            getModuleCoursesStr: function () {
                let str = "";
                let moduleNodes = $(".modules");

                for (let i = 0; i < moduleNodes.length; ++i) {
                    str += $(moduleNodes[i]).attr("data") + "-";
                    let courseNodes = $(moduleNodes[i]).find(".course:checked");
                    for (let j = 0; j < courseNodes.length; ++j)
                        str += $(courseNodes[j]).val() + " ";
                    str = str.substr(0, str.length - 1) + ",";
                }
                return str.substr(0, str.length - 1);
            },
            direction: function (data) {
                $.post(baseUrl + "/communication/queryDirectionByDepartmentId", {departmentId: data}, function (data) {
                    if (data.result) {
                        $("#direction").html(`<option value="">方向</option>`).append(trainProgram.loadDepartmentOrDirection(data.data, "-"))
                        form.render();
                    }
                })
            },
        };

        $(function () {
            trainProgram.list();

            form.on('select(department)', function (data) {
                trainProgram.direction(data.value);
            });
        });
    })
    ;


</script>

</html>
