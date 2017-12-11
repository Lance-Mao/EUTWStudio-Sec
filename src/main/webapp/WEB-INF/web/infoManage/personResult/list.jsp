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
<body>
<section class="larry-grid layui-form">
    <div class="larry-personal">
        <section class="larry-grid">
            <div class="larry-personal" id="container" style="height: 1600px;width: 83%">
                <div style="margin:20px 5%;height: auto">
                    <div>
                        <h2 style="color: #20a1a1;text-align: center;font-weight: bold;padding: 15px">
                    <span>
                        <img src="${baseurl}/images/public/logo_.png" style="width: 16%;height: 5%">
                    </span>西安欧亚学院学生成绩单</h2>
                        <fieldset class="layui-elem-field layui-field-title" style="margin:5px 1px">
                        </fieldset>
                        <table style="width: 90%">
                            <tr>
                                <td>姓名: <span id="name"></span></td>
                                <td>性别: <span id="gender"></span></td>
                                <td>名族: <span id="famous_family"></span></td>
                                <td>籍贯: <span id="address"></span></td>
                                <td>学历: 专科</td>
                                <td rowspan="3">
                                    <img id="headImg" src="${baseurl}/images/public/as.png" width="100px"
                                         height="150px">
                                </td>
                            </tr>
                            <tr>
                                <td>学号: <span id="no"></span></td>
                                <td>政治面貌: <span id="political"></span></td>
                                <td colspan="3">身份证号: <span id="idcard"></span></td>
                            </tr>
                            <tr>
                                <td>专业: <span id="profession"></span></td>
                                <td>方向: <span id="direction"></span></td>
                                <td colspan="3">入学时间: <span id="in_school"></span></td>
                            </tr>
                        </table>

                        <div style="float: left;width: 50%;">
                            <table class="layui-table" lay-even="" lay-skin="nob"
                            >
                                <colgroup>
                                    <col width="20%">
                                    <col width="15%">
                                    <col width="35%">
                                    <col width="15%">
                                    <col width="15%">
                                    <col>
                                </colgroup>
                                <thead>
                                <tr style="color: #20a1a1;border:2px solid #e0e0e0;border-left: none">
                                    <th>时间</th>
                                    <th>属性</th>
                                    <th>课程</th>
                                    <th>学分</th>
                                    <th>成绩</th>
                                </tr>
                                </thead>
                                <tbody id="left_result">

                                </tbody>
                            </table>
                        </div>
                        <div style="float: left;width: 50%">
                            <table class="layui-table" lay-even="" lay-skin="nob">
                                <colgroup>
                                    <col width="20%">
                                    <col width="15%">
                                    <col width="35%">
                                    <col width="15%">
                                    <col width="15%">
                                    <col>
                                </colgroup>
                                <thead>
                                <tr style="color: #20a1a1;border:2px solid #e0e0e0;border-right: none">
                                    <th>时间</th>
                                    <th>属性</th>
                                    <th>课程</th>
                                    <th>学分</th>
                                    <th>成绩</th>
                                </tr>
                                </thead>
                                <tbody id="right_result">

                                </tbody>

                            </table>
                        </div>
                        <div style="float: left;width: 100%">
                            <fieldset class="layui-elem-field layui-field-title" style="margin: 5px;">
                            </fieldset>
                            <p style="color: #20a1a1">必修/实修&nbsp;&nbsp;&nbsp;&nbsp
                                108 / <span id="compulsory_score">75</span>
                                &nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp&nbsp;&nbsp;&nbsp;&nbsp
                                选修/实修&nbsp;&nbsp;&nbsp;&nbsp8/<span id="elective_score">3</span></p>
                            <fieldset class="layui-elem-field layui-field-title" style="margin-top: 5px;">
                            </fieldset>
                            <img src="${baseurl}/images/public/logo_.png" style="width: 16%;height: 5%;float: right">
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>
</section>
</body>

<script type="text/javascript">
    let personResult;

    layui.use(['jquery', 'layer', 'element', 'laypage', 'form', 'laytpl'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;
        var element = layui.element(),
            form = layui.form(),
            laytpl = layui.laytpl;

        personResult = {
            preview: function () {
                $.post(baseUrl + "/resultReport/preview", {studentNo: "<shiro:principal property="userName"/>"}, function (data) {
                    if (data.result) {
                        personResult.loadStudentInfo(data.student);
                        if (data.results != null)
                            personResult.loadResults(data.results);
                    } else {
                        layer.msg(data.msg);
                    }
                });
            },
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
            }, loadDirectionsByDepartmentId: function (id) {
                $.post(baseUrl + "/communication/queryDirectionByDepartmentId", {departmentId: id}, function (data) {
                    if (data.result) {
                        $("#direction_search").html(`<option value="">方向</option>`).append(loadOptionsHtml(data.data, "-"));

                        form.render();
                    }
                })
            }, loadClassByDepartmentId: function (id) {
                $.post(baseUrl + "/communication/queryClassByDepartmentId", {departmentId: id}, function (data) {
                    if (data.result) {
                        $("#classes_search").html(`<option value="">班级</option>`).append(loadOptionsHtml(data.data, "-"));

                        form.render();
                    }
                })
            },
            loadStudentInfo: function (student) {
                if (student.origin_address != null) {
                    let originAddress = student.origin_address.split(ADDRESS_SPLIT_FLAG);
                    $("#address").text(originAddress[0] == undefined ? "" : originAddress[0] + originAddress[1] === undefined ? "" : originAddress[1]);
                } else  $("#address").text("");
                $("#name").text(student.studentName);
                $("#gender").text(student.gender);
                $("#famous_family").text(student.famous_family);

                $("#headImg").attr({src: HEAD_IMAGE_PREFIX + student.head_image});
                $("#no").text(student.no);
                $("#political").text(student.political_status);
                $("#idcard").text(student.idcard);
                $("#profession").text(student.professionName);
                $("#direction").text(student.directionName);
                $("#in_school").text(student.in_school);
            },
            loadResults: function (results) {
                $("#left_result").html("");
                $("#right_result").html("");
                let result_style, test_time, nature, course_name, credit, score, compulsory_score = 0,
                    elective_score = 0;


                for (let i = 0; i < results.length; ++i) {
                    if (results[i].testTime != null) {
                        let testTime = results[i].testTime.split("-");
                        test_time = testTime[0] + testTime[1];
                    } else test_time = "";
                    result_style = results[i].is_pass == 1 ? "" : `style="color:red"`;

                    nature = results[i].nature == 1 ? "选修" : "必修";
                    course_name = results[i].courseName;
                    credit = results[i].credit;
                    score = results[i].score;
                    let _html = `
                                 <tr  ` + result_style + `>
                                    <td>` + test_time + `</td>
                                    <td>` + nature + `</td>
                                    <td>` + course_name + `</td>
                                    <td>` + credit + `</td>
                                    <td>` + score + `</td>
                                </tr>`;
                    if (i < 25) {
                        $("#left_result").append(_html);
                    } else {
                        $("#right_result").append(_html);
                    }
                    if (nature === "选修" && results[i].is_pass == 1) elective_score += credit;
                    if (nature === "必修" && results[i].is_pass == 1) compulsory_score += credit;
                }
                $("#elective_score").text(elective_score);
                $("#compulsory_score").text(compulsory_score);
            }
        };
        $(function () {
            personResult.preview();
        });
    });


    function exportPDF() {
        pdf(document.getElementById("container"), $("#name").text(), "a4");
//        location.reload();
    }
</script>


</html>
