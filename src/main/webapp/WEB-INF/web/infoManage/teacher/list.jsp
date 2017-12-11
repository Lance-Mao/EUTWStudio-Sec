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
                <shiro:hasPermission name="teacher:add">
                    <ul class="layui-tab-title">
                        <li class="layui-btn " onclick="teacher.add()"><i class="layui-icon">&#xe61f;</i>添加教师
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
                            <th>工号</th>
                            <th>名字</th>
                            <th>性别</th>
                            <th>所属类别</th>
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
    let teacher;
    let classId = 0;
    layui.use(['jquery', 'layer', 'element', 'laypage', 'form', 'laytpl', 'tree', 'layedit'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;

        var element = layui.element(),
            form = layui.form(),
            layedit = layui.layedit,
            laytpl = layui.laytpl;


        teacher = {
            page: function () {
                layui.laypage({
                    cont: 'demo1',
                    pages: totalSize, //总页数
                    last: totalSize,
                    curr: currentIndex,
                    groups: 5,//连续显示分页数
                    skin: '#1E9FFF',
                    jump: function (obj, first) {
                        currentIndex = obj.curr;
                        if (!first) {
                            teacher.list();
                        }
                    }
                });
            },
            list: function () {
                $.ajax({
                    url: baseUrl + "/teacher/list",
                    data: {currentIndex: currentIndex, pageSize: pageSize},
                    success: function (data) {
                        if (data.result) {
                            currentIndex = data.page.currentIndex;
                            totalSize = data.page.totalSize;
                            showTotalCount(data.page.totalCount);
                            teacher.page();
                            laytpl($("#list-tpl").text()).render(data, function (html) {
                                $("#list").html(html);
                            });
                            form.render();
                        }
                    }
                });
            },
            chooseClassify: function (id) {

                if (id == "职业导师") {//职业导师
                    $("#show_dept").hide();
                    $("#show_community").hide();
                    $("#show_career").show();
                } else if (id == "行政") {//行政
                    $("#show_dept").show();
                    $("#show_career").hide();
                    $("#show_community").hide();
                } else {//辅导员
                    $("#show_career").hide();
                    $("#show_dept").hide();
                }
            }
            ,
            loadDepartmentOrDirection: function (data, selectId) {
                let _html = "";
                for (let i = 0; i < data.length; ++i) {
                    if (selectId == data[i].id) {
                        _html += `<option selected value="` + data[i].id + `">` + data[i].name + `</option>`;
                    } else {
                        _html += `<option value="` + data[i].id + `">` + data[i].name + `</option>`;
                    }
                }

                return _html;
            },
            loadClasses: function (classess, no) {
                let totalHtml = "";
                let _html = "";
                let level = classess.length === 0 ? 0 : classess[0].level;
                for (let i = 0; i < classess.length; ++i) {
                    let isChecked = classess[i].teacherId == no ? "checked" : "";
                    if (classess[i].level !== level) {
                        totalHtml += ` <div class="layui-form-item">
                                          <label class="layui-form-label" style="width:100px;margin-left: 0;">` + level + `</label>
                                             <div class="layui-input-block" >`
                            + _html + `
                                             </div>
                                       </div>`;

                        level = classess[i].level;
                        _html = ` <input class="classId" type="checkbox" ` + isChecked + ` value="` + classess[i].id + `" title="` + classess[i].name + `" >`
                    } else {
                        _html += ` <input class="classId" type="checkbox" ` + isChecked + ` value="` + classess[i].id + `" title="` + classess[i].name + `" >`
                    }
                    if (i === classess.length - 1 && classess[i].level === level) {
                        totalHtml += ` <div class="layui-form-item">
                                          <label class="layui-form-label" style="width: 100px;margin-left: 0;">` + level + `</label>
                                             <div class="layui-input-block" >`
                            + _html + `
                                             </div>
                                       </div>`;
                    }
                }
                return totalHtml;
            },
            loadFloor: function (floor, no) {
                let totalHtml = "";
                let _html = "";

                for (let i = 0; i < floor.length; ++i) {
                    let a = 0;
                    let isChecked;
                    for (let j = 0; j < no.length; j++) {
                        if (floor[i].id == no[j].floor_id) a++;
                    }
                    if (a != 0) isChecked = "checked";
                    else isChecked = "";
                    _html += ` <input class="floorId_update" type="checkbox" ` + isChecked + ` value="` + floor[i].id + `" title="` + floor[i].name + `" >`
                    if (i === floor.length - 1) {
                        totalHtml += ` <div class="layui-form-item">
                                             <div class="layui-input-block" >`
                            + _html + `
                                             </div>
                                       </div>`;
                    }
                }
                return totalHtml;
            },
            loadFloorId: function (floor, no) {
                let totalHtml = "";
                let _html = "";

                for (let i = 0; i < floor.length; ++i) {
                    let a = 0;
                    let isChecked;
                    for (let j = 0; j < no.length; j++) {
                        if (floor[i].id == no[j].floor_id) a++;
                    }
                    if (a != 0) isChecked = "checked";
                    else isChecked = "";
                    _html += ` <input class="floorId" type="checkbox" ` + isChecked + ` value="` + floor[i].id + `" title="` + floor[i].name + `" >`
                    if (i === floor.length - 1) {
                        totalHtml += ` <div class="layui-form-item">
                                             <div class="layui-input-block" >`
                            + _html + `
                                             </div>
                                       </div>`;
                    }
                }
                return totalHtml;
            },
            add: function () {
                $.post(baseUrl + "/teacher/loadDepartmentsAndDirectionsAndClasses", function (data) {
                    if (data.result) {
                        let classess = data.data.classess;
                        $("#classes").html(teacher.loadClasses(classess, "-"));
                        $("#no-add").val("");
                        $("#name-add").val("");
                        $("#identityCard-add").val("");
                        form.render();
                        layer.open({
                            type: 1,
                            title: '添加',
                            area: ["100%", "100%"]
                            , content: $("#add")
                        });
                    }
                });

            },
            update: function (no, identityCard, departmentId, directionId, name, gender, classify, deptId) {

                $.post(baseUrl + "/teacher/loadDirectionsAndClassesByDepartmentId", {departmentId: departmentId}, function (data) {
                    if (data.result) {
                        let classess = data.data.classess;
                        let depts = data.data.depts;
                        $("#id").val(no)
                        $("#no-update").val(no);
                        $("#identityCard-update").val(identityCard);
                        $("#name-update").val(name);
                        $("#classify_text").val(classify);
                        $("#classify_hidden").val(classify);
                        if (gender === "男") $("#gender-man").prop({checked: true});
                        else $("#gender-woman").prop({checked: true});
                        if (classify === "职业导师") {
                            $("#show_dept_update").hide();
                            $("#show_community_update").hide();
                            $("#show_career_update").show();
                            $("#classes-update").html(teacher.loadClasses(classess, no));
                        } else if (classify === "行政"){
                            $("#show_community_update").hide();
                            $("#show_career_update").hide();
                            $("#show_dept_update").show();
                            $("#dept_update").html(teacher.loadDepartmentOrDirection(depts, deptId))
                        }else  {
                            $("#show_dept_update").hide();
                            $("#show_career_update").hide();
                            $("#show_community_update").show();
                            $.post(baseUrl + "/teacher/teacherCommunity", {no: no}, function (data) {
                                let floorsId = data.data.floors;
                                let _no = data.data.area[0].area_id;
                                teacher.queryFloorAndArea(_no, floorsId);
                            });
                        }

                        form.render();
                        layer.open({
                            type: 1,
                            title: '修改',
                            area: ["100%", "100%"]
                            , content: $("#update")
                        });
                    }
                })
            },
            delete: function (id) {
                layer.confirm('确定删除？', {icon: 3, title: '提示'}, function (index) {
                    layer.close(index);
                    $.post(baseUrl + "/teacher/delete", {id: id}, function (data) {
                        layer.msg(data.msg);
                        setTimeout("location.reload()", 500);
                    })
                });
            },
            addAjax: function () {
                let data = $("#add-form").serialize();
                let classedIds = "";
                let floorIds = "";
                let classes = $(".classId");
                let floors = $(".floorId");
                for (let i = 0; i < classes.length; ++i) {
                    if ($(classes[i]).prop("checked")) classedIds += $(classes[i]).val() + ",";
                }
                data += "&classIds=" + classedIds;
                for (let i = 0; i < floors.length; ++i) {
                    if ($(floors[i]).prop("checked")) floorIds += $(floors[i]).val() + ",";
                }

                data += "&floorIds=" + floorIds;

                $.post(baseUrl + "/teacher/add", data, function (data) {
                    layer.msg(data.msg);
                    if (data.msg) {
                        setTimeout("location.reload()", 500);
                    }
                })
            },
            updateAjax: function () {
                if ($("#classify_text").val() === "职业导师") {
                    $("#dept_update").val(0);
                    $("#queryAreaOfRoom_update").val(0);
                    $("#floor_update").val("");
                    let data = $("#update-form").serialize();
                    let classedIds = "";
                    let classes = $(".classId");
                    for (let i = 0; i < classes.length; ++i) {
                        if ($(classes[i]).prop("checked")) classedIds += $(classes[i]).val() + ",";
                    }
                    data += "&classIds=" + classedIds;

                    layer.confirm('确定修改?如果您修改了系,那么原来的班级就会被删除', {icon: 3, title: '提示'}, function (index) {
                        layer.close(index);
                        $.post(baseUrl + "/teacher/update", data, function (data) {

                            layer.msg(data.msg);
                            setTimeout("location.reload()", 500);
                        })
                    });
                } else if ($("#classify_text").val() === "行政") {
                    $("#department-update").val(0);
                    $("#direction-update").val(0);
                    $("#classes-update").val("");
                    $("#queryAreaOfRoom_update").val(0);
                    $("#floor_update").val("");
                    let data = $("#update-form").serialize();
                    layer.confirm('确定修改?', {icon: 3, title: '提示'}, function (index) {
                        layer.close(index);
                        $.post(baseUrl + "/teacher/update", data, function (data) {
                            layer.msg(data.msg);
                            setTimeout("location.reload()", 500);
                        })
                    });
                } else if ($("#classify_text").val() === "社区辅导员") {
                    $("#dept_update").val(0);
                    $("#department-update").val(0);
                    $("#direction-update").val(0);
                    $("#classes-update").val("");
                    let data = $("#update-form").serialize();
                    let floorIds = "";
                    let floorId = $(".floorId_update");

                    for (let i = 0; i < floorId.length; ++i) {
                        if ($(floorId[i]).prop("checked")) floorIds += $(floorId[i]).val() + ",";
                    }
                    data += "&floorIds=" + floorIds;
                    layer.confirm('确定修改?', {icon: 3, title: '提示'}, function (index) {
                        layer.close(index);
                        $.post(baseUrl + "/teacher/update", data, function (data) {
                            layer.msg(data.msg);
                            setTimeout("location.reload()", 500);
                        })
                    });
                }
            }
            ,
            loadDepartmentOrDirection: function (data, selectId) {
                let _html = ""
                for (let i = 0; i < data.length; ++i) {
                    if (selectId == data[i].id) {
                        _html += `<option selected value="` + data[i].id + `">` + data[i].name + `</option>`;
                    } else {
                        _html += `<option value="` + data[i].id + `">` + data[i].name + `</option>`;
                    }
                }

                return _html;
            }
            ,
            queryFloorAndAreaOfRoom: function () {
                $.post(baseUrl + "/dorm/room/showAreaAndFloorsToQuery", function (data) {
                    if (data.result) {

                        $("#queryAreaOfRoom").html(`<option value="0">区号</option>`).append(teacher.loadDepartmentOrDirection(data.data.queryAreaOfRoom, "-"))
                        $("#floor").html(teacher.loadFloorId(data.data.queryFloorOfRoom, "-"));
                        form.render();
                    }
                })
            },
            queryFloorAndArea: function (no, floorsId) {
                $.post(baseUrl + "/dorm/room/showAreaAndFloors", {areaId: no}, function (data) {
                    if (data.result) {
                        $("#queryAreaOfRoom_update").html(`<option value="0">区号</option>`).append(teacher.loadDepartmentOrDirection(data.data.queryAreaOfRoom, no))
                        $("#floor_update").html(teacher.loadFloor(data.data.queryFloorOfRoom, floorsId));
                        form.render();
                    }
                })
            }

        };
        $(function () {
            teacher.list();
            teacher.queryFloorAndAreaOfRoom();

            form.on('select(department)', function (data) {
                $.post(baseUrl + "/teacher/loadDirectionsAndClassesByDepartmentId", {departmentId: data.value}, function (data) {
                    if (data.result) {
                        let directions = data.data.directions;
                        let classess = data.data.classess;
                        $("#direction").html(teacher.loadDepartmentOrDirection(directions, "-"));
                        $("#classes").html(teacher.loadClasses(classess, "-"));
                        $("#direction-update").html(teacher.loadDepartmentOrDirection(directions, "-"));
                        $("#classes-update").html(teacher.loadClasses(classess, "-"));

                        form.render();
                    }
                });
            });
            form.on('select(classify)', function (data) {
                teacher.chooseClassify(data.value);
                $.post(baseUrl + "/teacher/queryDeptList",
                    function (data) {
                        if (data.result) {
                            let depts = data.data;
                            $("#dept").html(teacher.loadDepartmentOrDirection(depts, "-"));
                            form.render();
                        } else {
                            layer.msg(data.msg);
                        }
                    })
            });

            form.on('select(queryAreaOfRoom)', function (data) {
                var id = data.value;
                $.post(baseUrl + "dorm/room/showAreaAndFloors", {areaId: data.value}, function (data) {
                    if (data.result) {

                        var queryAreaOfRoom = data.data.queryAreaOfRoom
                        var queryFloorOfRoom = data.data.queryFloorOfRoom
                        $("#queryAreaOfRoom").html(teacher.loadDepartmentOrDirection(queryAreaOfRoom, id))
                        $("#floor").html(teacher.loadFloorId(queryFloorOfRoom, "-"));

                        form.render();
                    }
                })
            });
            form.on('select(queryAreaOfRoom_update)', function (data) {
                var id = data.value;
                $.post(baseUrl + "dorm/room/showAreaAndFloors", {areaId: data.value}, function (data) {
                    if (data.result) {

                        var queryAreaOfRoom = data.data.queryAreaOfRoom
                        var queryFloorOfRoom = data.data.queryFloorOfRoom
                        $("#queryAreaOfRoom_update").html(teacher.loadDepartmentOrDirection(queryAreaOfRoom, id))
                        $("#floor_update").html(teacher.loadFloor(queryFloorOfRoom, "-"));

                        form.render();
                    }
                })
            })

        });
    });
    $(function () {
        $('#no-add').blur(function () {
            let no = $('#no-add').val()
            $.post(baseUrl + "/teacher/queryUserById", {no: no}, function (data) {
                if (data.result) {
                    $("#no-add").focus();
                    layer.msg(data.msg);
                }
            })
        })
        $('#identityCard-add').blur(function () {
            var reg = new RegExp("^[1-9]\\d{5}[1-9]\\d{3}((0\\d)|(1[0-2]))(([0|1|2]\\d)|3[0-1])\\d{3}([0-9]|X)$");
            if (!reg.test($("#identityCard-add").val())) {
                $("#identityCard-add").focus();
                layer.msg("你的身份证输入有误,请重新输入");
            }
        });
        $('#no-add').blur(function () {
            var reg = new RegExp("^[0-9]*$");
            if ((!reg.test($("#no-add").val())) || $("#no-add").val() === '') {
                $("#no-add").focus();
                layer.msg("您的工号输入有误");
            }
        });
    })

</script>

</html>
