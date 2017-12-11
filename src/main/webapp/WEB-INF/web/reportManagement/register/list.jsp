<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../../../public/tag.jsp" %>
<html>
<head>
    <title></title>
    <script type="text/javascript" src="${baseurl}/public/common/js/jquery-3.2.0.min.js"></script>
    <script src="${baseurl}/public/common/layui/layui.js" charset="utf-8"></script>
    <link rel="stylesheet" href="${baseurl}/public/common/layui/css/layui.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/layui/css/layui.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/bootstrap/css/bootstrap.min.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/css/global.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/css/common.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/css/personal.css" media="all">
</head>
<style>
    #preview li {
        float: left;
        font-size: 14px;
        margin: 3% 0 1% 3%;
        font-weight: 400;
    }

    #stu_info td {
        text-align: center;
        font-size:   12px;
    }

    #actual{
        padding: 0px 2px;
    }
    /*导出PDF样式*/
    @media   print   {
        #stu_info td   {
            text-align: center;
            font-size:   12px;
            padding: 3px 5px;
            -webkit-transform-origin-x: 0;
            -webkit-transform: scale(0.80);
        }
        #head_image1{

        }
        #head_image{
            width:130px;
            height:150px;
            margin: -2em -5em;
        }
        #head li {
            float: left;
            font-size: 14px;
            margin: 5px 0 1% 3%;
            font-weight: 400;
        }
        #excel{
            display: none;
        }
        #actual{
           padding: 0px 2px;
        }
        #title{
            margin-left: 32%;
            margin-top: 0px;
        }
    }

</style>
<body>
<section class="larry-grid layui-form">

    <div class="larry-personal">
        <div class="layui-tab">
            <blockquote class="layui-elem-quote mylog-info-tit">
                <div class="layui-form-item">
                    <div class="layui-input-inline">
                        <div class="layui-inline">
                            <div class="layui-input-inline">
                                <select lay-filter="department" id="department_search">
                                    <option value="">系</option>

                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="layui-input-inline">
                        <div class="layui-inline">
                            <div class="layui-input-inline">
                                <select lay-filter="level" id="level_search">
                                    <option value="">年级</option>
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
                                <select lay-filter="profession" id="classes_search">
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
                                <input type="text" name="no" id="no_search" lay-verify="title" autocomplete="off"
                                       placeholder="学号" value="" class="layui-input">
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
                    <a class="layui-btn" style="width: auto ;margin-bottom: 10px;"
                       onclick="currentIndex=1;resultReport.list()"><i
                            class="layui-icon">&#xe615;</i>搜索</a>
                </div>
            </blockquote>
        </div>
        <div class="larry-separate"></div>
        <div class="layui-tab-content larry-personal-body clearfix mylog-info-box">
            <div class="layui-form">
                <table class="layui-table">
                    <thead>
                    <tr>
                        <th>系</th>
                        <th>年级</th>
                        <th>就业方向</th>
                        <th>班级</th>
                        <th>学号</th>
                        <th>姓名</th>
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
<script src="${baseurl}/js/searchJs.js"/>
<script type="text/javascript" src="${baseurl}/public/js/pdf/html2canvas.js"></script>
<script type="text/javascript" src="${baseurl}/public/js/pdf/jspdf.debug.js"></script>
<script type="text/javascript" src="${baseurl}/public/js/pdf/renderPDF.js"></script>
<script type="text/javascript" src="${baseurl}/public/common/layui/layui.js"></script>
<script type="text/javascript" src="${baseurl}/js/searchJs.js"></script>
<script type="text/javascript">
    let resultReport;
    let totalSize = 10;
    let currentIndex = 1;
    let pageSize = 10;
    let department;
    layui.use(['jquery', 'layer', 'element', 'laypage', 'form', 'laytpl'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;
        var element = layui.element(),
            form = layui.form(),
            laytpl = layui.laytpl;

        resultReport = {
            page: function () {
                layui.laypage({
                    cont: 'demo1',
                    pages: totalSize, //总页数
                    curr: currentIndex,
                    last: totalSize,
                    groups: 5,//连续显示分页数
                    skin: '#1E9FFF',
                    jump: function (obj, first) {
                        currentIndex = obj.curr;
                        if (!first) {
                            resultReport.list();
                        }
                    }
                });
            },
            list: function () {
                let data = {
                    departmentId: $("#department_search").val(),
                    level: $("#level_search").val(),
                    directionId: $("#direction_search").val(),
                    classesId: $("#classes_search").val(),
                    studentNo: $("#no_search").val(),
                    name: $("#name_search").val(),
                    currentIndex: currentIndex,
                    pageSize: pageSize
                };
                $.ajax({
                    url: baseUrl + "/resultReport/list",
                    data: data,
                    type: "post",
                    success: function (data) {
                        if (data.result) {
                            currentIndex = data.page.currentIndex;
                            totalSize = data.page.totalSize;
                            resultReport.page();
                            showTotalCount(data.page.totalCount);
                            laytpl($("#list-tpl").text()).render(data, function (html) {
                                $("#list").html(html);
                            });
                            form.render();
                        }
                    }
                });
            },
            preview: function (no) {
                $.post(baseUrl + "/newStudentRegister/student", {no: no}, function (data) {
                    if (data.result) {
                        resultReport.loadStudentInfo(data.data);
                        form.render();
                        layer.open({
                            type: 1,
                            title: "成绩单",
                            area: ["100%", "100%"]
                            , content: $("#preview")
                        });
                    } else {
                        layer.msg(data.msg);
                    }
                });
            },
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
            }, loadDirectionsByDepartmentId: function (id) {
                $.post(baseUrl + "/communication/queryDirectionByDepartmentId", {departmentId: id}, function (data) {
                    if (data.result) {
                        $("#direction_search").html(loadOptionsHtml(data.data, "-"));

                        form.render();
                    }
                })
            }, loadClassByDepartmentId: function (id) {
                $.post(baseUrl + "/communication/queryClassByDepartmentId", {departmentId: id}, function (data) {
                    if (data.result) {
                        $("#classes_search").html(loadOptionsHtml(data.data, "-"));

                        form.render();
                    }
                })
            },
            loadStudentInfo: function (student) {
                resultReport.showStudentBasicInfo(student.basicStudentInfo);
                resultReport.showStudentExperienceInfo(student.experience);
                resultReport.showStudentFamilyInfo(student.family);
            },
            showStudentBasicInfo: function (student) {
                $("#student_classify").text("☐本科 ☐专升本 ☑专科");

                $(".studentName").text(student.studentName == undefined ? "无" : student.studentName);
                $("#professionName").text(student.professionName == undefined ? "无" : student.professionName);
                $("#classesName").text(student.classesName == undefined ? "无" : student.classesName);
                $("#no").text(student.no == undefined ? "无" : student.no);
                $("#in_school").text(student.in_school == undefined ? "无" : student.in_school + "-09-01");
                $("#gender").text(student.gender == undefined ? "无" : (student.gender === "F" ? "女" : "男"));
                $("#born").text(getBirthday(student.idcard));
                $("#famous_family").text(student.famous_family == undefined ? "无" : student.famous_family);
                $("#pre_school_education").text(student.pre_school_education == undefined ? "无" : student.pre_school_education);
                $("#is_marry").text(student.is_marry == undefined ? "无" : student.is_marry);
                $("#head_image").attr({src: HEAD_IMAGE_PREFIX + student.head_image});
                $("#origin_address").text(student.origin_address == undefined ? "无" : student.origin_address);
                $("#political_status").text(student.political_status == undefined ? "无" : student.political_status);
                $("#actual_address").text(student.actual_address == undefined ? "无" : student.actual_address);
                $("#family_zip_code").text(student.family_zip_code == undefined ? "无" : student.family_zip_code);
                $("#family_phone").text(student.phone == undefined ? "无" : student.phone);
                $("#pre_school_work").text(student.pre_school_name == undefined ? "无" : student.pre_school_name);
                $("#pre_school_staff").text(student.pre_school_staff == undefined ? "无" : student.pre_school_staff);
                $("#health_status").text(student.health_status == undefined ? "无" : student.health_status);
                $("#idcard").text(student.idcard == undefined ? "无" : student.idcard);
                $("#own_experience").text(student.partyOrGroupOrganizationText == "" ? "无" : student.partyOrGroupOrganizationText);
                $("#own_punishment").text(student.Pre_admissionOrRewardText == "" ? "无" : student.Pre_admissionOrRewardText);

            },
            showStudentExperienceInfo: function (experiences) {
                $(".experience_node").remove();
                let start_time, end_time, work_place, staff;
                for (let i = 0; i < 4; ++i) {
                    let experience = experiences[i];
                    if (experience) {
                        [start_time, end_time, work_place, staff] = [experience.start_time, experience.end_time, experience.work_place, experience.staff];
                    } else {
                        [start_time, end_time, work_place, staff] = [" ", " ", " ", " "];
                    }
                    $("#experience").before(`
                     <tr class="experience_node">
                        <td colspan="2" style="height: 35px;">` + start_time + `</td>
                        <td colspan="2">` + end_time + `</td>
                        <td colspan="6">` + work_place + `</td>
                        <td colspan="1">` + staff + `</td>
                    </tr>
                    `);
                }
            },
            showStudentFamilyInfo: function (familys) {
                $(".family_node").remove();
                let relationship, name, political_status, staff, work_place, phone;
                for (let i = 0; i < 4; ++i) {
                    let family = familys[i];
                    if (family) {
                        [relationship, name, political_status, staff, work_place, phone] =
                            [family.relationship, family.name, family.political_status, family.staff, family.work_place, family.phone];
                    } else {
                        [relationship, name, political_status, staff, work_place, phone] = [" ", " ", " ", " ", "", ""];
                    }
                    $("#family").before(`
                     <tr class="family_node">
                        <td colspan="1" style="height: 35px;">` + relationship + `</td>
                        <td colspan="1">` + name + `</td>
                        <td colspan="1">` + political_status + `</td>
                        <td colspan="1">` + staff + `</td>
                        <td colspan="6">` + work_place + `</td>
                        <td colspan="1">` + phone + `</td>
                    </tr>
                    `);
                }
            },
            queryClassByDirectionIdAndLevel: function (directionId, level) {
                $.post(baseUrl + "/studentClass/queryClassByDirectionIdAndLevel", {
                    directionId: directionId,
                    level: level
                }, function (data) {
                    if (data.result) {
                        $("#classes_search").html(loadOptionsHtml(data.data, "-"))
                    }
                    form.render();
                })
            },
            loadALlDepartments: function () {
                $.post(baseUrl + "/department/allDepartments", function (data) {
                    if (data.result) {
                        $("#department_search").html(loadOptionsHtml(data.data, "-"));
                    }
                    form.render();
                });
            },
            exportRegisterReport: function () {
                printPdf()
//                location.href = baseUrl + "/newStudentRegister/exportRegisterReport?no=" + $("#no").text() + "";
            }
        };
        $(function () {
            resultReport.loadALlDepartments();
//            loadAllDirections();
            loadAllLevels();
//            loadAllClassess();
            form.render();

            form.on('select(department)', function (data) {

                $("#department_search").html(resultReport.loadClassByDepartmentId(data.value));
                $("#direction_search").html(resultReport.loadDirectionsByDepartmentId(data.value));
            });
            form.on('select(direction)', function (data) {
                resultReport.queryClassByDirectionIdAndLevel(data.value, $("#level_search").val());
            });
            form.on('select(level)', function (data) {
                resultReport.queryClassByDirectionIdAndLevel($("#direction_search").val(), data.value);
            });
        });
    })
    function printPdf() {

        var headstr = "<html><head><title>123131</title></head><body>";
        var footstr = "</body>";
        var printData = document.getElementById("preview").innerHTML;// 获得 div 里的所有 html 数据
        var oldstr = document.body.innerHTML;
        document.body.innerHTML = headstr+printData+footstr;

        window.print();
        document.body.innerHTML = oldstr;
        return false;
    }

</script>


</html>
