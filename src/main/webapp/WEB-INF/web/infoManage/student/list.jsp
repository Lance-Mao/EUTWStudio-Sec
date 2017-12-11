<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../../../public/tag.jsp" %>
<html>
<head>
    <title></title>
    <script type="text/javascript" src="${baseurl}/public/common/js/jquery-3.2.0.min.js"></script>
    <script src="${baseurl}/public/common/layui/layui.js" charset="utf-8"></script>
    <script src="${baseurl}/js/separator.js" charset="utf-8"></script>
    <link rel="stylesheet" href="${baseurl}/public/common/layui/css/layui.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/layui/css/layui.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/bootstrap/css/bootstrap.min.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/css/global.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/css/common.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/css/personal.css" media="all">
    <script type="text/javascript" src="${baseurl}/js/searchJs.js"></script>
    <%--省市区联动--%>
    <script src="${baseurl}/js/city/distpicker.js"></script>
    <script src="${baseurl}/js/city/main.js"></script>
    <script src="${baseurl}/js/city/distpicker.data.js"></script>

    <%--导出pdf--%>
    <script src='${baseurl}/public/pdfMake/pdfmake.min.js'></script>
    <script src='${baseurl}/public/pdfMake/vfs_fonts.js'></script>
    <script src='${baseurl}/public/pdfMake/pdfMake.js'></script>

</head>

<body>

<style>
    .layui-form-radio span {
        font-size: 10px;
    }

    .layui-form-radio i {
        font-size: 15px;
    }

    .layui-elem-quote {
        padding-bottom: 1px;
    }

    .layui-disabled {
        background: none;
    }

    .layui-table td {
        font-size: 12px;
        padding: 4px 15px;

    }
</style>

<section class="larry-grid layui-form">
    <div class="larry-personal">
        <div class="layui-tab">
            <form id="update-form" lay-filter="role-add" class="layui-form layui-form-pane" method="post">
                <blockquote class="layui-elem-quote mylog-info-tit">

                    <div class="layui-form-item" style="margin-bottom: 1px;">
                        <div class="layui-input-inline">
                            <div class="layui-inline" style="margin-bottom: -12px;">
                                <div class="layui-input-inline">
                                    <select name="modules" lay-filter="department" lay-search=""
                                            id="department_search">
                                        <option value="">系</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="layui-input-inline">
                            <div class="layui-inline">
                                <div class="layui-input-inline">
                                    <select name="modules1" lay-filter="modules_level" lay-search=""
                                            id="level_search">
                                        <option value="">年级</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="layui-input-inline">
                            <div class="layui-inline">
                                <div class="layui-input-inline">
                                    <select name="modules1" lay-filter="modules_2" lay-search=""
                                            id="profession_search">
                                        <option value="">专业</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="layui-input-inline">
                            <div class="layui-inline">
                                <div class="layui-input-inline">
                                    <select name="modules" lay-filter="modules_direction" lay-search=""
                                            id="direction_search">
                                        <option value="">方向</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="layui-input-inline" style="display: none">
                            <div class="layui-inline">
                                <div class="layui-input-inline">
                                    <select name="modules" lay-filter="modules_direction" lay-search=""
                                            id="student_status_search">
                                        <option value="">学籍状态</option>
                                        <option value="1">在读</option>
                                        <option value="2">复学</option>
                                        <option value="3">入伍</option>
                                        <option value="4">退学</option>
                                        <option value="5">留级</option>
                                        <option value="6">流失</option>
                                    </select>
                                </div>
                            </div>
                        </div>

                        <div class="layui-input-inline">
                            <div class="layui-inline">
                                <div class="layui-input-inline">
                                    <select name="modules1" lay-filter="modules_2" lay-search=""
                                            id="classes_search">
                                        <option value="">班级</option>
                                    </select>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
                        <div class="layui-form-item" style="margin-bottom: 1px;">
                            <div class="layui-form-inline">
                                <div>
                                    <label class="layui-form-label"
                                           style="font-size: x-small;font-weight: lighter">性别</label>
                                    <div class="layui-input-inline" id="sexQuery" style="width: 250px;">
                                        <input type="radio" name="sexQuery" value="" title="全部" checked="">
                                        <input type="radio" name="sexQuery" value="M" title="男">
                                        <input type="radio" name="sexQuery" value="F" title="女">
                                    </div>
                                </div>
                                <div>
                                    <label class="layui-form-label" style="font-size: x-small">住宿类型</label>
                                    <div class="layui-input-inline" id="TypeOfAccommodation"
                                         onclick="student.showDormAndHideDorm()" style="width: 260px">

                                        <input type="radio" name="TypeOfAccommodation" value="" title="全部" checked=""
                                        >
                                        <input type="radio" name="TypeOfAccommodation" value="1" title="校内"
                                        >
                                        <input type="radio" name="TypeOfAccommodation" value="2" title="校外"
                                        >
                                    </div>
                                </div>
                            </div>

                            <div class="layui-input-inline">
                                <div class="layui-inline">
                                    <div class="layui-input-inline">
                                        <select name="modules" lay-search=""
                                                id="teacher_id">
                                            <option value="">职业导师</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="layui-input-inline">
                                <div class="layui-inline">
                                    <div class="layui-input-inline">
                                        <select name="modules1" lay-filter="modules_2"
                                                lay-search=""
                                                id="community_teacher_id">
                                            <option value="">社区辅导员</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="layui-form-item" style="margin-bottom: 1px;">
                        <span id="dorm">
                            <div class="layui-input-inline">
                                <div class="layui-inline">
                                    <div class="layui-input-inline">
                                        <select name="modules" lay-filter="dorm" lay-search=""
                                                id="area_search">
                                            <option value="">区</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="layui-input-inline">
                                <div class="layui-inline">
                                    <div class="layui-input-inline">
                                        <select name="modules1" lay-filter="modules_2"
                                                lay-search=""
                                                id="floor_search">
                                            <option value="">楼层</option>
                                        </select>
                                    </div>
                                </div>
                            </div>

                            <div class="layui-inline" style="margin-right: -15px">
                                <div class="layui-inline">
                                    <div class="layui-input-inline">
                                        <input type="text" name="title" id="roomNo_search"
                                               autocomplete="off"
                                               placeholder="宿舍" class="layui-input">
                                    </div>
                                </div>
                            </div>
                        </span>

                        <div class="layui-inline" style="margin-right: -15px">
                            <div class="layui-inline">
                                <div class="layui-input-inline">
                                    <input type="text" name="title" id="studentNo_search" lay-verify="title"
                                           autocomplete="off"
                                           placeholder="学号" class="layui-input">
                                </div>

                            </div>
                        </div>

                        <div class="layui-inline" style="margin-right: -15px">
                            <div class="layui-inline" style="margin-right: -10px">
                                <div class="layui-input-inline">
                                    <input type="text" name="title" id="studentName_search" lay-verify="title"
                                           autocomplete="off"
                                           placeholder="姓名" class="layui-input" style="margin-right: 3px">
                                </div>
                                <a class="layui-btn" onclick="currentIndex = 1;student.list()"><i class="layui-icon">&#xe615;</i>搜索</a>
                            </div>
                        </div>
                        &nbsp;&nbsp;&nbsp;
                        <a class="layui-btn" onclick="currentIndex = 1;dataOutput.showDataOutput(dataSearchInfo)"
                           style="float: right;display: none" id="showButtonByDataOutput"><i
                                class="layui-icon">&#xe615;</i>导出数据</a>
                    </div>

                </blockquote>
            </form>
            <div class="larry-separate"></div>
            <div class="layui-tab-content larry-personal-body clearfix mylog-info-box">
                <div class="layui-form">
                    <table class="layui-table">
                        <thead>
                        <tr>
                            <th>学号</th>
                            <th>姓名</th>
                            <th>性别</th>
                            <th>系</th>
                            <th>年级</th>
                            <th>专业</th>
                            <th>方向</th>
                            <th>学籍状态</th>
                            <th>班级</th>
                            <th>职业导师</th>
                            <th>社区辅导员</th>
                            <th>住宿类型</th>
                            <th>区</th>
                            <th>楼层</th>
                            <th>宿舍</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody id="list">

                        </tbody>
                    </table>
                </div>
                <div id="demo1" style="margin-top: -10px;"></div>
            </div>
        </div>
    </div>
</section>
</body>

<%@include file="layer.jsp" %>
<%@include file="pdf.jsp" %>
<%@include file="dataOutput.jsp" %>
<script src="${baseurl}/js/searchJs.js"/>
<script type="text/javascript" src="${baseurl}/public/js/pdf/html2canvas.js"></script>
<script type="text/javascript">
    let student;
    let totalSize = 10;
    let currentIndex = 1;
    let pageSize = 10;
    let studentInfo;
    let teacherInfo;
    let experienceInfo;
    let familyInfo;
    let imgName;
    let famousFamily;
    let departmentList;
    let addStudentFamilyInfoIndex;
    let AwardOrPunishmentInfo;
    let addAwardOrPunishmentInfoIndex;
    let allProfessionInfo;
    let addExperienceByUpdateOffOpen;
    let addDisciplineAndPunishmentInfoIndex;
    let addGroupActivitiesIndex;
    let disciplineAndPunishmentListInfo;
    let groupActivitiesListInfo;
    let searchLevel;
    let searchInfo;
    let dataSearchInfo;

    $(function () {
        //基本信息
        <shiro:lacksPermission name="student:basicInfo">
        $("#student_info").find("input").attr({disabled: "disabled"});
        $("#student_info").find("select").attr({disabled: "disabled"});
        $("#student_info").find("radio").attr({disabled: "disabled"});
        </shiro:lacksPermission>
        //学业状态
        <shiro:lacksPermission name="student:academicInformation">
        $("#updateStudent_Academic_information").find("input").attr({disabled: "disabled"});
        $("#updateStudent_Academic_information").find("select").attr({disabled: "disabled"});
        $("#updateStudent_Academic_information").find("radio").attr({disabled: "disabled"});
        </shiro:lacksPermission>
        //社区管理
        <shiro:lacksPermission name="student:communityManagement">
        $("#communityManagement").find("input").attr({disabled: "disabled"});
        $("#communityManagement").find("select").attr({disabled: "disabled"});
        $("#communityManagement").find("radio").attr({disabled: "disabled"});
        </shiro:lacksPermission>
        //奖学金或助学金
        <shiro:lacksPermission name="student:updateStudentScholarships">
        $("#updateStudent_scholarships").find("input").attr({disabled: "disabled"});
        $("#updateStudent_scholarships").find("select").attr({disabled: "disabled"});
        $("#updateStudent_scholarships").find("radio").attr({disabled: "disabled"});
        </shiro:lacksPermission>
    })

    function showDisabled() {
        //家庭成员信息
        <shiro:lacksPermission name="student:familyInfo">
        $("#family_member_information").find("input").attr({disabled: "disabled"});
        $("#family_member_information").find("select").attr({disabled: "disabled"});
        $("#family_member_information").find("radio").attr({disabled: "disabled"});
        $("#family_member_information").find("button").attr({disabled: "disabled"});
        $("#showButton_addStudentFamilyInfo").attr({disabled: "disabled"});
        </shiro:lacksPermission>
    }

    function showExperience() {
        //教育经历
        <shiro:lacksPermission name="student:experience">
        $("#educational_experience").find("input").attr({disabled: "disabled"});
        $("#educational_experience").find("select").attr({disabled: "disabled"});
        $("#educational_experience").find("radio").attr({disabled: "disabled"});
        $("#educational_experience").find("button").attr({disabled: "disabled"});
        $("#showButton_addExperienceInfo").attr({disabled: "disabled"});
        </shiro:lacksPermission>
    }

    function awardOrPunishment() {
        //荣誉或获奖
        <shiro:lacksPermission name="student:awardOrPunishment">
        $("#updateStudent_Award_or_punishment").find("input").attr({disabled: "disabled"});
        $("#updateStudent_Award_or_punishment").find("select").attr({disabled: "disabled"});
        $("#updateStudent_Award_or_punishment").find("radio").attr({disabled: "disabled"});
        $("#updateStudent_Award_or_punishment").find("button").attr({disabled: "disabled"});
        $("#showButton_addAwardOrPunishmentInfo").attr({disabled: "disabled"});
        </shiro:lacksPermission>
    }

    function disciplineAndPunishment() {
        //违纪或处分
        <shiro:lacksPermission name="student:disciplineAndPunishment">
        $("#updateStudent_disciplineAndPunishment").find("input").attr({disabled: "disabled"});
        $("#updateStudent_disciplineAndPunishment").find("select").attr({disabled: "disabled"});
        $("#updateStudent_disciplineAndPunishment").find("radio").attr({disabled: "disabled"});
        $("#updateStudent_disciplineAndPunishment").find("button").attr({disabled: "disabled"});
        $("#showButton_addDisciplineAndPunishmentInfo").attr({disabled: "disabled"});
        </shiro:lacksPermission>
    }

    function groupActivities() {
        //团学活动
        <shiro:lacksPermission name="student:groupActivites">
        $("#updateStudent_GroupActivities").find("input").attr({disabled: "disabled"});
        $("#updateStudent_GroupActivities").find("select").attr({disabled: "disabled"});
        $("#updateStudent_GroupActivities").find("radio").attr({disabled: "disabled"});
        $("#updateStudent_GroupActivities").find("button").attr({disabled: "disabled"});
        $("#showButton_addGroupActivitiesInfo").attr({disabled: "disabled"});
        </shiro:lacksPermission>
    }

    function showDormInfo() {
        let info = [];
        let area = $("#queryAreas").find("option:selected").text();
        let floor = $("#queryFloors").find("option:selected").text();
        let room = $("#queryRooms").find("option:selected").text();
        if (area !== "请选择") info.push(area);
        if (floor !== "请选择") info.push(floor);
        if (room !== "请选择") info.push(room);
        $("#updateDorms").val(info.join("-"))
    }

    layui.use(['jquery', 'layer', 'element', 'laypage', 'form', 'laytpl', 'tree'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;
        var element = layui.element(),
            form = layui.form(),
            laytpl = layui.laytpl;

        student = {
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
                            student.list();
                        }
                    }
                });
            },

            list: function () {
                <shiro:hasPermission name="student:updateShowButtonByDataOutput">
                    $("#showButtonByDataOutput").show();
                </shiro:hasPermission>
                let department_search = $("#department_search").val();
                let level_search = $("#level_search").val();
                let direction_search = $("#direction_search").val();
                let classes_search = $("#classes_search").val();
                let area_search = $("#area_search").val();
                let floor_search = $("#floor_search").val();
                let profession_search = $("#profession_search").val();
                let roomNo_search = $("#roomNo_search").val();
                let studentNo_search = $("#studentNo_search").val();
                let teacher_id = $("#teacher_id").val();
                let community_teacher_id = $("#community_teacher_id").val();
                let name = $("#studentName_search").val();
                let sex = $("input[name='sexQuery']:checked").val();
                let TypeOfAccommodation = $("input[name='TypeOfAccommodation']:checked").val();
                let studentStatusSearch = $("#student_status_search").val();
                //搜索条件
                searchInfo = {
                    currentIndex: currentIndex,
                    pageSize: pageSize,
                    departmentId: department_search,
                    level: level_search,
                    directionId: direction_search,
                    professionId: profession_search,
                    classesId: classes_search,
                    teacherId: teacher_id,
                    communityTeacherId: community_teacher_id,
                    areaId: area_search,
                    floorId: floor_search,
                    roomId: roomNo_search,
                    studentNo: studentNo_search,
                    name: name,
                    sex: sex,
                    TypeOfAccommodation: TypeOfAccommodation,
                    studentStatusSearch: studentStatusSearch
                }

                //搜索条件导出报表时，有字段重名
                dataSearchInfo = {
                    currentIndex: currentIndex,
                    pageSize: pageSize,
                    departmentId: department_search,
                    dataLevel: level_search,
                    directionId: direction_search,
                    professionId: profession_search,
                    classesId: classes_search,
                    teacherId: teacher_id,
                    communityTeacherId: community_teacher_id,
                    areaId: area_search,
                    floorId: floor_search,
                    roomId: roomNo_search,
                    studentNo: studentNo_search,
                    dataName: name,
                    sex: sex,
                    TypeOfAccommodation: TypeOfAccommodation,
                    studentStatusSearch: studentStatusSearch
                }


                $.ajax({
                    url: baseUrl + "student/list",
                    type: "post",
                    data: searchInfo,
                    success: function (data) {
                        if (data.result) {
                            currentIndex = data.page.currentIndex;
                            allProfessionInfo = data.allProfessionList;
                            totalSize = data.page.totalSize;
                            student.page();
                            showTotalCount(data.page.totalCount);
                            laytpl($("#list-tpl").text()).render(data, function (html) {
                                $("#list").html(html);
                            });
                            form.render();
                        }
                    }
                });
            },
            showDormAndHideDorm: function () {
                if ($("input[name='TypeOfAccommodation']:checked").val() === "1") {
                    $("#dorm").show();
                } else {
                    $("#dorm").hide();
                }
            },
            loadDirectionsByDepartmentId: function (id) {
                $.post(baseUrl + "/communication/queryDirectionByDepartmentId", {departmentId: id}, function (data) {
                    if (data.result) {
                        $("#direction_search").html(`<option value=''>方向</option>`).append(loadOptionsHtml(data.data, "-"));

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
            loadDepartmentOrDirectionArea: function (data, selectId) {
                let _html = "<option value=\"\">区</option>";
                for (let i = 0; i < data.length; ++i) {
                    if (selectId == data[i].id) {
                        _html += `<option  selected value="` + data[i].id + `">` + data[i].name + `</option>`;
                    } else {
                        _html += `<option value="` + data[i].id + `">` + data[i].name + `</option>`;
                    }
                }

                return _html;
            },
            loadDepartmentOrDirectionFloor: function (data, selectId) {
                let _html = "<option value=\"\">楼层</option>";
                for (let i = 0; i < data.length; ++i) {
                    if (selectId == data[i].id) {
                        _html += `<option  selected value="` + data[i].id + `">` + data[i].name + `</option>`;
                    } else {
                        _html += `<option value="` + data[i].id + `">` + data[i].name + `</option>`;
                    }
                }

                return _html;
            },
            pdfMake: function (studentNo) {
                $.post(baseUrl + "/student/update", {studentNo: studentNo}, function (data) {
                    printPDF(data);
                });
            },
            preview: function (studentNo) {
                $.post(baseUrl + "/student/update", {studentNo: studentNo}, function (data) {
                    console.log(data);
                    $("#pdfmake").html("").append(`<button class='layui-btn ' style='float: right' onclick='student.pdfMake(` + data.student[0].no + `)'>
                            <i class='layui-icon'>&#xe60a;</i>导出 PDF
                            </button>`);
                    $("#phone").html(data.student[0].student_contact_method);
                    $("#qq").html(data.student[0].qq);
                    $("#email").html(data.student[0].email);
                    $("#images").text("").attr("src", HEAD_IMAGE_PREFIX + data.student[0].head_image);
                    $("#studentNo").html(data.student[0].no);
                    $("#studentName").html(data.student[0].name);
                    $("#studentName1").html(data.student[0].name);
                    if (data.student[0].gender == 'F') {
                        $("#studentSex").html("女");
                    } else if (data.student[0].gender == 'M') {
                        $("#studentSex").html("男");
                    }
                    $("#famous_family").html(data.student[0].famousFamily);
                    $("#studentClassify").html(data.student[0].student_classify);
                    $("#preSchoolName").html(data.student[0].pre_school_name);

                    if (data.student[0].Pre_admissionOrReward === "无") {
                        $("#PreAdmissionOrReward").html("无");
                    } else {
                        $("#PreAdmissionOrReward").html(data.student[0].Pre_admissionOrRewardText);
                    }
                    if (data.student[0].partyOrGroupOrganization === "无") {
                        $("#party_OrGroupOrganization").html("无");
                    } else {
                        $("#party_OrGroupOrganization").html(data.student[0].partyOrGroupOrganizationText);
                    }
                    $("#preSchoolName").html(data.student[0].pre_school_name);
                    $("#account_in").html(data.student[0].account_in);
                    $("#idcard_address").html(data.student[0].idcard_address);
                    $("#studentClassify").html(data.student[0].student_classify);
                    $("#actual_address").html(data.student[0].actual_address);
                    $("#area_origin_name").html(data.student[0].area_origin_name);
                    $("#origin_address").html(data.student[0].origin_address);
                    $("#preSchoolEducation").html(data.student[0].pre_school_education);
                    $("#pre_school_file_where_location").html(data.student[0].pre_school_file_where_location);
                    $("#pre_school_account_where_station").html(data.student[0].pre_school_account_where_station);
                    $("#file_in").html(data.student[0].file_in);
                    $("#idcard").html(data.student[0].idcard);
                    $("#native_place").html(data.student[0].native_place);
                    $("#born").html(getBirthday(data.student[0].idcard));
                    if (data.student[0].political_status === "请选择") {
                        $("#political_status").text("");

                    } else {
                        $("#political_status").text("").append(data.student[0].political_status);
                    }
                    $("#blood").text("").append(data.student[0].blood);
                    $("#height").text("").append(data.student[0].height);
                    $("#weight").text("").append(data.student[0].weight);
                    $("#health_status").text("").append(data.student[0].health_status);

                    if (data.student[0].first_time_medical_insurance == undefined) {
                        $("#first_time_medical_insurance_preview").html("");
                    } else {
                        $("#first_time_medical_insurance_preview").text("").append(data.student[0].first_time_medical_insurance + "年");
                    }
                    if (data.student[0].second_time_medical_insurance == undefined) {
                        $("#second_time_medical_insurance_preview").html("");
                    } else {
                        $("#second_time_medical_insurance_preview").text("").append(data.student[0].second_time_medical_insurance + "年");
                    }
                    if (data.student[0].third_time_medical_insurance == undefined) {
                        $("#third_time_medical_insurance_preview").html("");
                    } else {
                        $("#third_time_medical_insurance_preview").text("").append(data.student[0].third_time_medical_insurance + "年");
                    }
                    if (data.student[0].first_medical_insurance == undefined) {
                        $("#first_medical_insurance_preview").html("");
                    } else {
                        $("#first_medical_insurance_preview").text("").append("（" + data.student[0].first_medical_insurance + "）");
                    }
                    if (data.student[0].second_medical_insurance == undefined) {
                        $("#second_medical_insurance_preview").html("");
                    } else {
                        $("#second_medical_insurance_preview").text("").append("（" + data.student[0].second_medical_insurance + "）");
                    }
                    if (data.student[0].third_medical_insurance == undefined) {
                        $("#third_medical_insurance_preview").html("");
                    } else {
                        $("#third_medical_insurance_preview").text("").append("（" + data.student[0].third_medical_insurance + "）");
                    }

                    $("#scholarship").html("<tr><th>年份</th><th>奖学金</th><th>助学金</th></tr>");
                    if (data.student[0].first_year !== undefined && data.student[0].first_year !== "") {
                        $("#scholarship").append("<tr><th>" + data.student[0].first_year + "</th><th>" + data.student[0].first_scholarship + "</th><th>" + data.student[0].first_stipend + "</th></tr>");
                    }
                    if (data.student[0].second_year !== undefined && data.student[0].second_year !== "") {
                        $("#scholarship").append("<tr><th>" + data.student[0].second_year + "</th><th>" + data.student[0].second_scholarship + "</th><th>" + data.student[0].second_stipend + "</th></tr>");
                    }
                    if (data.student[0].third_year !== undefined && data.student[0].third_year !== "") {
                        $("#scholarship").append("<tr><th>" + data.student[0].third_year + "</th><th>" + data.student[0].third_scholarship + "</th><th>" + data.student[0].third_stipend + "</th></tr>");
                    }
                    $("#is_marry").text("").append(data.student[0].is_marry);
                    $("#family_zip_code").text("").append(data.student[0].family_zip_code);
                    $("#student_contact_method").text("").append(data.student[0].student_contact_method);
                    $("#actual_address").text("").append(data.student[0].actual_address);
                    $("#family").html("")

                    for (var i = 0; i < data.family.length; i++) {
                        if (data.family[i].political_status === "请选择") {
                            data.family[i].political_status = "";
                        }
                        $("#family").append("<tr> <th colspan='5' >" + data.family[i].relationship + "：" + data.family[i].name + "</th>" +
                            "<th colspan='4' style='width: 70px'>职务：" + data.family[i].staff + "</th>" +
                            "<th colspan='4'>联系电话：" + data.family[i].phone + "</th></tr>" +
                            "<tr><th colspan='5' style='width: 130px'>政治面貌：" + data.family[i].political_status + "</th>" +
                            "<th colspan='8'>工作单位：" + data.family[i].work_place + "</th> </tr>");
                    }
                    $("#emergency_contact_name").html(data.student[0].emergency_contact_name);
                    $("#emergency_contact_method").html(data.student[0].emergency_contact_method);
                    $("#experience_div").html("");
                    for (var i = 0; i < data.experience.length; i++) {
                        $("#experience_div").append("<tr class='experience_divToEveryOne'> <th>时间：" + data.experience[i].start_time + "——" + data.experience[i].end_time + "</th>" +
                            "<th> 学校名称：" + data.experience[i].work_place + "</th>" +
                            "<th >担任职位：" + data.experience[i].staff + "</th></tr>");
                    }
                    $("#student_type").html(data.student[0].student_type);
                    $("#sat_score").html(data.student[0].sat_score);
                    $("#originProfession").html(data.student[0].originProfession);
                    $("#profession").html(data.student[0].profession);
                    $("#department").html(data.student[0].department);
                    $("#direction").html(data.student[0].direction);
                    $("#classes").html(data.student[0].classes);
                    $("#teacherName").html(data.student[0].teacherName);
                    $("#teacherName").html(data.student[0].teacherName);
                    $("#teacherCommunity").html(data.student[0].teacherCommunity);
                    $("#student_status").html(data.student[0].student_status);
                    $("#practice_learning_type").html(data.student[0].practice_learning_type);
                    $("#units_or_projects_practical_type_preview").html(data.student[0].units_or_projects_practical_type);
                    $("#units_or_projects_practical_type_contact_preview").html(data.student[0].units_or_projects_practical_type_contact);
                    $("#units_or_projects_practical_type_contact_phone_preview").html(data.student[0].units_or_projects_practical_type_contact_phone);
                    $("#group").html(data.student[0].group);
                    $("#payment_status_first_year").html(data.student[0].payment_status_first_year);
                    $("#payment_status_second_year").html(data.student[0].payment_status_second_year);
                    $("#payment_status_third_year").html(data.student[0].payment_status_third_year);
                    $("#payment_status_forth_year").html(data.student[0].payment_status_forth_year);
                    $("#payment_status_fifth_year").html(data.student[0].payment_status_fifth_year);
                    $("#payment_status_sixth_year").html(data.student[0].payment_status_sixth_year);
                    $("#arrears_first_year").html("：" + data.student[0].arrears_first_year + "元");
                    $("#arrears_second_year").html("：" + data.student[0].arrears_second_year + "元");
                    $("#arrears_third_year").html("：" + data.student[0].arrears_third_year + "元");
                    $("#arrears_forth_year").html("：" + data.student[0].arrears_forth_year + "元");
                    $("#arrears_fifth_year").html("：" + data.student[0].arrears_fifth_year + "元");
                    $("#arrears_sixth_year").html("：" + data.student[0].arrears_sixth_year + "元");
                    if (data.student[0].payment_status_first_year === "欠费") {
                        $("#arrears_first_year").css("display", "inline");
                    } else {
                        $("#arrears_first_year").css("display", "none");
                    }
                    if (data.student[0].payment_status_second_year === "欠费") {
                        $("#arrears_second_year").css("display", "inline");
                    } else {
                        $("#arrears_second_year").css("display", "none");
                    }

                    if (data.student[0].payment_status_third_year === "欠费") {
                        $("#arrears_third_year").css("display", "inline");
                    } else {
                        $("#arrears_third_year").css("display", "none");
                    }
                    if (data.student[0].payment_status_forth_year === "欠费") {
                        $("#arrears_forth_year").css("display", "inline");
                    } else {
                        $("#arrears_forth_year").css("display", "none");
                    }
                    if (data.student[0].payment_status_fifth_year === "欠费") {
                        $("#arrears_fifth_year").css("display", "inline");
                    } else {
                        $("#arrears_fifth_year").css("display", "none");
                    }
                    if (data.student[0].payment_status_sixth_year === "欠费") {
                        $("#arrears_sixth_year").css("display", "inline");
                    } else {
                        $("#arrears_sixth_year").css("display", "none");
                    }

//                    $("#area").html(data.student[0].area);
//                    $("#floor").html(data.student[0].floor);
//                    $("#room").html(data.student[0].room);
                    $("#hard_type").html(data.student[0].hard_type);
                    if (data.student[0].stay_type === "1") {
                        $("#stay_type").html("校内");
                        $("#DormitoryInformation").html("宿舍位置：" + data.student[0].area + "&nbsp;-&nbsp;" + data.student[0].floor + "&nbsp;-&nbsp;" + data.student[0].room + "房间");
                    } else if (data.student[0].stay_type === "2") {
                        $("#stay_type").html("校外");
                        $("#DormitoryInformation").html("校外住址信息：" + data.student[0].off_school_stay_address + "&nbsp;&nbsp;&nbsp;&nbsp;联系人：" + data.student[0].updateOffCampusContactName + "&nbsp;&nbsp;&nbsp;&nbsp;联系人电话：" + data.student[0].updateOffCampusContactPhone);
                    } else {
                        $("#stay_type").html("暂无");
                        $("#DormitoryInformation").html("住址信息：暂无");
                    }

                    $("#is_out").html(data.student[0].is_out);
                    if (data.student[0].religion === "无") {
                        $("#religion").html("无");
                    } else {
                        $("#religion").html(data.student[0].religionText);
                    }
                    if (data.student[0].political_status === "请选择") {
                        $("#political_status").text("暂无");

                    } else {
                        $("#political_status").html(data.student[0].political_status);
                    }

                    //获奖与荣誉
                    $("#own_punishment").text("");
                    for (var i = 0; i < data.ownPunishment.length; i++) {
                        $("#own_punishment").append("<tr><th>" + data.ownPunishment[i].date + " &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; " + data.ownPunishment[i].centent + "</th><th>证明人：" + data.ownPunishment[i].witness + "</th></tr>");
                    }
                    $("#t_discipline_and_punishment").html("<tr><th>时间</th><th> 类别</th><th> 行为</th><th> 级别</th><th> 证明人</th><th> 是否撤销</th></tr>");
                    for (var i = 0; i < data.disciplineAndPunishment.length; i++) {
                        let revokeDiscipline = "";
                        if (data.disciplineAndPunishment[i].revokeDiscipline === "none") {
                            revokeDiscipline = "已撤销";
                        } else {
                            revokeDiscipline = "未撤销";
                        }
                        $("#t_discipline_and_punishment").append("<tr><th>" + data.disciplineAndPunishment[i].date + " </th><th>" + data.disciplineAndPunishment[i].category + "</th><th>" + data.disciplineAndPunishment[i].behavior + "</th><th>" + data.disciplineAndPunishment[i].rank + "</th><th>" + data.disciplineAndPunishment[i].witness + "</th><th>" + revokeDiscipline + "</th></tr>");
                    }
                    $("#t_group_activities").html("<tr><th>时间</th><th> 类别</th><th> 学时</th><th> 名称</th><th> 证明人</th></tr>");
                    for (var i = 0; i < data.groupActivities.length; i++) {
                        $("#t_group_activities").append("<tr><th>" + data.groupActivities[i].date + " </th><th>" + data.groupActivities[i].types + "</th><th>" + data.groupActivities[i].hours + "</th><th>" + data.groupActivities[i].heading + "</th><th>" + data.groupActivities[i].witness + "</th></tr>");
                    }
                });
                layer.open({
                    type: 1,
                    title: "学生信息",
                    area: ["100%", "100%"],
                    content: $("#update")
                });

            },
            studentUpdate: function (studentName, studentNo, level) {
                //当前搜索条件下的年级
                searchLevel = level;
                $("input[type='radio']").removeAttr("checked");
                $.ajax({
                    url: "${baseurl}/student/studentUpdate",
                    data: {studentNo: studentNo, searchLevel: searchLevel},
                    success: function (data) {
                        if (data.result) {

                            studentInfo = data.students;
                            teacherInfo = data.teacherList;
                            experienceInfo = data.experienceList;
                            familyInfo = data.students_family;
                            famousFamily = data.famousFamily;
                            departmentList = data.departmentList;
                            AwardOrPunishmentInfo = data.AwardOrPunishmentList;
                            disciplineAndPunishmentListInfo = data.disciplineAndPunishmentList;
                            groupActivitiesListInfo = data.groupActivitiesList;
                            let studentList = data.students;
                            let AwardOrPunishmentList = data.AwardOrPunishmentList;
                            let familyList = data.students_family;
                            let professionList = data.professionList;
                            let allProfessionList = data.allProfessionList;
                            let directionList = data.directionList;
                            let classesList = data.classesList;
                            let experienceList = data.experienceList;
                            let scholarshipsList = data.scholarshipsList;
                            let teacherList = data.teacherList;
                            let famousFamilyList = data.famousFamilyList;
                            let disciplineAndPunishmentList = data.disciplineAndPunishmentList;
                            let groupActivitiesList = data.groupActivitiesList;

                            $("#studentPhone").val(studentList.student_contact_method);
                            $("#studentQQ").val(studentList.qq);
                            $("#studentEmail").val(studentList.email);

                            $("#imagesToUpdate").text("").attr("src", HEAD_IMAGE_PREFIX + studentList.head_image);
                            $("#updateStudentNo").val(studentList.no)
                            $("#updateStudentName").val(studentList.name);
                            $("input:radio[value='" + studentList.gender + "'][name='sexOfUpdate']").prop('checked', 'true');
                            if (famousFamily != null) {
                                $("#updateStudentNationalities").html("").append(loadOptionsHtmlOfFamousFamilyList(famousFamilyList, studentList.famous_family));
                            } else {
                                $("#updateStudentNationalities").html("").append(loadOptionsHtmlOfFamousFamilyList(famousFamilyList, "-"));
                            }
                            $("#updateStudentIdCard").val(studentList.idcard);
                            $("#updateStudentNativePlace").val(studentList.native_place);
                            let born = studentList.idcard.substr(6, 8);
                            $("#updateStudentBirthday").val(born.substr(0, 4) + "-" + born.substr(4, 2) + "-" + born.substr(6, 2));
                            $("input[type='radio'][name='isMarry'][value='" + studentList.is_marry + "']").attr("checked", 'true');
                            $("input[type='radio'][name='accommodation_type'][value='" + studentList.stay_type + "']").attr("checked", 'true');
                            $("#updateStudentHeight").val(studentList.height);
                            $("#updateStudentWight").val(studentList.weight);
                            if (studentList.religion == "有") {
                                $("#religiousBelief_has").prop({checked: true});
                                $("#religiousBeliefText").val(studentList.religionText);
                                $("#showReligiousBeliefText").show();
                            } else {
                                $("#religiousBelief_none").prop({checked: true});
                            }


                            $("input:radio[value='" + studentList.health_status + "']").prop('checked', 'true');
                            $("#updateOtherHealthStatus").val(studentList.otherHealthStatus);
                            $("input:radio[value=" + studentList.student_type + "]").prop('checked', 'true');

                            var count = $("#updateStudentBloodType option").length;
                            for (var i = 0; i < count; i++) {
                                if ($("#updateStudentBloodType").get(0).options[i].text == studentList.blood) {
                                    $("#updateStudentBloodType").get(0).options[i].selected = true;
                                }
                            }

                            var count1 = $("#updateStudentPoliticalOutlook option").length;
                            for (var i = 0; i < count1; i++) {
                                if ($("#updateStudentPoliticalOutlook").get(0).options[i].text === studentList.political_status) {
                                    $("#updateStudentPoliticalOutlook").get(0).options[i].selected = true;
                                }
                                if (studentList.political_status != "中共党员" && studentList.political_status != "预备党员" && studentList.political_status != "共青团员" && studentList.political_status != "积极分子" && studentList.political_status != "群众" && studentList.political_status != "请选择" && studentList.political_status != "") {
                                    $("#updateStudentPoliticalOutlook").get(0).options[count1 - 1].selected = true;
                                    $("#otherParty").show();
                                    $("#otherUpdateStudentPoliticalOutlook").val(studentList.political_status);
                                }
                            }

                            var count2 = $("#updateStudent_pre_school_education option").length;
                            for (var i = 0; i < count2; i++) {
                                if ($("#updateStudent_pre_school_education").get(0).options[i].text === studentList.pre_school_education) {
                                    $("#updateStudent_pre_school_education").get(0).options[i].selected = true;
                                }
                                if (studentList.pre_school_education != "高中" && studentList.pre_school_education != "中专" && studentList.pre_school_education != "技校" && studentList.pre_school_education != "职高" && studentList.pre_school_education != "请选择" && studentList.political_status != "") {
                                    $("#updateStudent_pre_school_education").get(0).options[count2 - 1].selected = true;
                                    $("#pre_school_education").show();
                                    $("#other_updateStudent_pre_school_education").val(studentList.pre_school_education);
                                }
                            }

                            $("input:radio[value='" + studentList.student_classify + "']").prop('checked', 'true');
                            $("input:radio[value='" + studentList.is_out + "']").prop('checked', 'true');
                            $("#Identity_card_address").val(studentList.idcard_address);

                            //党派或团体组织
                            $("#partyOrGroupOrganization").find("input[value='" + studentList.partyOrGroupOrganization + "']").prop({checked: true});
                            $("#partyOrGroupOrganizationText").val(studentList.partyOrGroupOrganizationText);
                            //入学前受过何奖励或处分
                            $("#Pre_admissionOrReward").find("input[value='" + studentList.Pre_admissionOrReward + "']").prop({checked: true});
                            $("#Pre_admissionOrRewardText").val(studentList.Pre_admissionOrRewardText);

                            $("#detailedAddresses").val(studentList.actual_address);
                            $("#update_name_of_the_source").val(studentList.origin_address);
                            $("#updateOffCampusAddress").val(studentList.off_school_stay_address);
                            $("#updateOffCampusContactPhone").val(studentList.updateOffCampusContactPhone);
                            $("#updateOffCampusContactName").val(studentList.updateOffCampusContactName);

                            $("#updateStudentZip_code").val(studentList.family_zip_code);
                            $("#updateStudentHome_phone").val(studentList.family_phone);

                            $("#update_pre_school_staff").val(studentList.pre_school_staff);

                            student.familyFnformation(familyList);
                            showDisabled();

                            $("input[type='radio'][name='whetherToTransfer'][value='" + studentList.account_in + "']").attr("checked", "checked");
                            $("input[type='radio'][name='is_the_file_transferred'][value='" + studentList.file_in + "']").attr("checked", "checked");
                            $("input[type='radio'][name='birthplaceName'][value='" + studentList.area_origin_name + "']").attr("checked", "checked");
                            $("#Pre_school_name").val(studentList.pre_school_name);

                            $("#updateStudent_emergency_contact").val(studentList.emergency_contact_name);
                            $("#updateStudent_emergency_contact_phone").val(studentList.emergency_contact_method);

                            $("#Pre_enrollment_file_unit").val(studentList.pre_school_file_where_location);
                            let school_account_where_the_police_station_detailed = []
                            if (studentList.pre_school_account_where_station != null) {
                                school_account_where_the_police_station_detailed = studentList.pre_school_account_where_station.replace("-", "");
                            }
                            $("#school_account_where_the_police_station_detailed").val(studentList.pre_school_account_where_station);

                            $("#studentsProfessionList").html("").append(`<option value=""></option>` + loadOptionsHtml(allProfessionList, studentList.profession_id));
                            $("#studentsNowProfessional").html("").append(`<option value=""></option>` + loadOptionsHtml(allProfessionList, studentList.origin_profession_id));
                            $("#employment_direction").html("").append(`<option value=""></option>` + loadOptionsHtml(directionList, studentList.direction_id));
                            $("#student_department").html("").append(`<option value=""></option>` + loadOptionsHtml(departmentList, studentList.department_id));
                            let oneDepartmentId = studentList.department_id;
                            var oneShowClasses = [];
                            classesList.forEach(item => {
                                if (oneDepartmentId == item.department_id) {
                                    oneShowClasses.push(item);
                                }
                            })
                            $("#student_class").html("").append(`<option value=""></option>` + loadOptionsHtml(oneShowClasses, studentList.classes_id));
                            form.render();
                            student.educationalExperience(experienceList);
                            showExperience();
                            form.render();

                            $("input[type='radio'][name='student_type1'][value='" + studentList.student_type + "']").attr("checked", "checked");
                            if (studentList.student_type == "高考录取") {
                                $("#upadte_SAT_score").val(studentList.sat_score);
                            } else {
                                $("#show_SAT_score").hide();
                            }
                            $("#pre_school_work").val(studentList.pre_school_work);


                            var count3 = $("#update_student_status option").length;
                            for (var i = 0; i < count3; i++) {
                                if ($("#update_student_status").get(0).options[i].value == studentList.student_status) {
                                    $("#update_student_status").get(0).options[i].selected = true;
                                }
                            }
                            var count4 = $("#update_payment_status option").length;
                            for (var i = 0; i < count4; i++) {
                                if ($("#update_payment_status").get(0).options[i].text == studentList.payment_status_first_year) {
                                    $("#update_payment_status").get(0).options[i].selected = true;
                                }
                            }
                            var count5 = $("#update_payment_status2 option").length;
                            for (var i = 0; i < count5; i++) {
                                if ($("#update_payment_status2").get(0).options[i].text == studentList.payment_status_second_year) {
                                    $("#update_payment_status2").get(0).options[i].selected = true;
                                }
                            }
                            var count6 = $("#update_payment_status3 option").length;
                            for (var i = 0; i < count6; i++) {
                                if ($("#update_payment_status3").get(0).options[i].text == studentList.payment_status_third_year) {
                                    $("#update_payment_status3").get(0).options[i].selected = true;
                                }
                            }
                            var count4Bypay = $("#update_payment_status4 option").length;
                            for (var i = 0; i < count4Bypay; i++) {
                                if ($("#update_payment_status4").get(0).options[i].text == studentList.payment_status_forth_year) {
                                    $("#update_payment_status4").get(0).options[i].selected = true;
                                }
                            }
                            var count5Bypay = $("#update_payment_status5 option").length;
                            for (var i = 0; i < count5Bypay; i++) {
                                if ($("#update_payment_status5").get(0).options[i].text == studentList.payment_status_fifth_year) {
                                    $("#update_payment_status5").get(0).options[i].selected = true;
                                }
                            }
                            var count6Bypay = $("#update_payment_status6 option").length;
                            for (var i = 0; i < count6Bypay; i++) {
                                if ($("#update_payment_status6").get(0).options[i].text == studentList.payment_status_sixth_year) {
                                    $("#update_payment_status6").get(0).options[i].selected = true;
                                }
                            }
                            var count7 = $("#update_practical_type option").length;
                            for (var i = 0; i < count7; i++) {
                                if ($("#update_practical_type").get(0).options[i].text == studentList.practice_learning_type) {
                                    $("#update_practical_type").get(0).options[i].selected = true;
                                    $("#units_or_projects_practical_type").val(studentList.units_or_projects_practical_type);
                                    $("#units_or_projects_practical_type_contact").val(studentList.units_or_projects_practical_type_contact);
                                    $("#units_or_projects_practical_type_contact_phone").val(studentList.units_or_projects_practical_type_contact_phone);
                                    $("#show_units_or_projects_practical_type").show();
                                    $("#show_units_or_projects_practical_type_contact").show();
                                    $("#show_units_or_projects_practical_type_contact_phone").show();

                                }
                                if (studentList.practice_learning_type != "合作企业" && studentList.practice_learning_type != "自主实习" && studentList.practice_learning_type != "创新创业" && studentList.practice_learning_type != "专升本" && studentList.practice_learning_type != null) {
                                    $("#update_practical_type").get(0).options[count7 - 1].selected = true;
                                    $("#show_other_practical_type").show();
                                    $("#other_practical_type").val(studentList.practice_learning_type);
                                    $("#units_or_projects_practical_type").val(studentList.practice_learning_type);
                                    $("#units_or_projects_practical_type_contact").val(studentList.units_or_projects_practical_type_contact);
                                    $("#units_or_projects_practical_type_contact_phone").val(studentList.units_or_projects_practical_type_contact_phone);
                                    $("#show_units_or_projects_practical_type").show();
                                    $("#show_units_or_projects_practical_type_contact").show();
                                    $("#show_units_or_projects_practical_type_contact_phone").show();
                                }
                            }

                            var count10 = $("#student_group option").length;
                            for (var i = 0; i < count10; i++) {
                                if ($("#student_group").get(0).options[i].text == studentList.group) {
                                    $("#student_group").get(0).options[i].selected = true;
                                }
                            }

                            var count11 = $("#first_scholarship option").length;
                            for (var i = 0; i < count11; i++) {
                                if ($("#first_scholarship").get(0).options[i].text === studentList.first_scholarship) {
                                    $("#first_scholarship").get(0).options[i].selected = true;
                                }
                            }
                            var count12 = $("#first_stipend option").length;
                            for (var i = 0; i < count12; i++) {
                                if ($("#first_stipend").get(0).options[i].text === studentList.first_stipend) {
                                    $("#first_stipend").get(0).options[i].selected = true;
                                }
                            }
                            var count13 = $("#second_scholarship option").length;
                            for (var i = 0; i < count13; i++) {
                                if ($("#second_scholarship").get(0).options[i].text === studentList.second_scholarship) {
                                    $("#second_scholarship").get(0).options[i].selected = true;
                                }
                            }
                            var count14 = $("#second_stipend option").length;
                            for (var i = 0; i < count14; i++) {
                                if ($("#second_stipend").get(0).options[i].text === studentList.second_stipend) {
                                    $("#second_stipend").get(0).options[i].selected = true;
                                }
                            }
                            var count15 = $("#third_stipend option").length;
                            for (var i = 0; i < count15; i++) {
                                if ($("#third_stipend").get(0).options[i].text === studentList.third_stipend) {
                                    $("#third_stipend").get(0).options[i].selected = true;
                                }
                            }
                            var count16 = $("#third_scholarship option").length;
                            for (var i = 0; i < count16; i++) {
                                if ($("#third_scholarship").get(0).options[i].text === studentList.third_scholarship) {
                                    $("#third_scholarship").get(0).options[i].selected = true;
                                }
                            }
                            //奖助学金年份
                            $("#first_scholarship_particularYear").html(`<option value=""></option>` + loadOptionsHtmlToYear(studentList.level, studentList.first_year));
                            $("#second_scholarship_particularYear").html(`<option value=""></option>` + loadOptionsHtmlToYear(studentList.level, studentList.second_year));
                            $("#third_scholarship_particularYear").html(`<option value=""></option>` + loadOptionsHtmlToYear(studentList.level, studentList.third_year));
                            //医保年份
                            $("#first_time_medical_insurance").html(`<option value=""></option>` + loadOptionsHtmlTomedicalInsurance(studentList.level, studentList.first_time_medical_insurance));
                            $("#second_time_medical_insurance").html(`<option value=""></option>` + loadOptionsHtmlTomedicalInsurance(studentList.level, studentList.second_time_medical_insurance));
                            $("#third_time_medical_insurance").html(`<option value=""></option>` + loadOptionsHtmlTomedicalInsurance(studentList.level, studentList.third_time_medical_insurance));
                            $("#first_medical_insurance").find("input[value=" + studentList.first_medical_insurance + "]").prop('checked', 'true');
                            $("#second_medical_insurance").find("input[value=" + studentList.second_medical_insurance + "]").prop('checked', 'true');
                            $("#third_medical_insurance").find("input[value=" + studentList.third_medical_insurance + "]").prop('checked', 'true');
                            //职业导师
                            let update_career_mentor1 = teacherList.filter(item => item.classify === "职业导师");
                            $("#update_career_mentor").html("").append(`<option value=""></option>` + loadOptionsHtmlToTeacher(update_career_mentor1, studentList.teacher_id));

                            let update_community_counselor1 = teacherList.filter(item => item.classify === "社区辅导员");
                            //社区辅导员
                            $("#update_community_counselor").html("").append(`<option value=""></option>` + loadOptionsHtmlToTeacher(update_community_counselor1, studentList.community_teacher_id));

                            $("#Amount_of_arrears").val(studentList.arrears_first_year);
                            $("#Amount_of_arrears2").val(studentList.arrears_second_year);
                            $("#Amount_of_arrears3").val(studentList.arrears_third_year);
                            $("#Amount_of_arrears4").val(studentList.arrears_forth_year);
                            $("#Amount_of_arrears5").val(studentList.arrears_fifth_year);
                            $("#Amount_of_arrears6").val(studentList.arrears_sixth_year);

                            if (studentList.arrears_first_year != null && studentList.arrears_first_year != '0') {
                                $("#showAmount_of_arrears").show();
                            } else {
                                $("#showAmount_of_arrears").hide();
                            }

                            if (studentList.arrears_second_year != null && studentList.arrears_second_year != '0') {
                                $("#showAmount_of_arrears2").show();
                            } else {
                                $("#showAmount_of_arrears2").hide();
                            }

                            if (studentList.arrears_third_year != null && studentList.arrears_third_year != '0') {
                                $("#showAmount_of_arrears3").show();
                            } else {
                                $("#showAmount_of_arrears3").hide();
                            }
                            if (studentList.arrears_forth_year != null && studentList.arrears_forth_year != '0') {
                                $("#showAmount_of_arrears4").show();
                            } else {
                                $("#showAmount_of_arrears4").hide();
                            }
                            if (studentList.arrears_fifth_year != null && studentList.arrears_fifth_year != '0') {
                                $("#showAmount_of_arrears5").show();
                            } else {
                                $("#showAmount_of_arrears5").hide();
                            }
                            if (studentList.arrears_sixth_year != null && studentList.arrears_sixth_year != '0') {
                                $("#showAmount_of_arrears6").show();
                            } else {
                                $("#showAmount_of_arrears6").hide();
                            }

                            $("input[type='radio'][name='update_hard_type'][value='" + studentList.hard_type + "']").attr("checked", "checked");
                            form.render();

//                            $("#update_award_or_honor").val(studentList.own_punishment);
                            student.updateStudentAwardOrPunishment(AwardOrPunishmentList);
                            awardOrPunishment();
                            form.render();
                            student.queryAreaAndFloorAndRoomByRoomIdOfUpdate(studentList.room_id)

                            student.updateStudentDisciplineAndPunishment(disciplineAndPunishmentList);
                            disciplineAndPunishment();
                            form.render();

                            student.updateStudentGroupActivities(groupActivitiesList);
                            groupActivities();
                            form.render();
                            student.showLoad_updateOtherHealthStatus();
                            student.showPartyOrGroupOrganization();
                            student.showPre_admissionOrReward();
                            //如果住宿类型为校外,则隐藏宿舍信息,否则显示
                            //1表示校内,2表示校外
                            if (studentList.stay_type == "2") {
                                $("#dorms").hide();
                                $("#OffCampusAddress").show();
                            } else if (studentList.stay_type == "1") {
                                $("#OffCampusAddress").hide();
                                $("#dorms").show();
                            } else {
                                $("#OffCampusAddress").hide();
                                $("#dorms").hide();
                            }


                        }
                    }

                })
                layer.open({
                    type: 1,
                    title: "学生信息修改",
                    area: ["100%", "100%"],
                    closeBtn: 1,
                    content: $("#updateStudent"),
                    cancel: function () {
                        //点击关闭按钮刷新列表
//                        location.reload();
                    }
                })
                form.render();
            },
            familyFnformation: function (familyList) {
                $("#family_member_information").html("");
                for (var j = 0; j < familyList.length; j++) {
                    let politicalStatus = familyList[j].political_status;
                    let isOther = student.isOther(politicalStatus);
                    let isShow = isOther ? "display" : "none";
                    $("#family_member_information").append(
                        `<tr id="family_information1" class="family_information1">
                                        <th colspan="1" style="width: 20%"><span class = "family_relationship"></span><span>
                               ：<div class="layui-input-inline" style="width: 70%">
                                   <input type="text" name="text"
                                          placeholder="请输入成员姓名" autocomplete="off" class="layui-input updateStudentParentsName"
                                          id="updateStudentParentsName">
                                </div>
                           </span></th>
                            <th colspan="1" style="width: 30%">联系方式：<span>
                               <div class="layui-input-inline" style="width: 70%">
                                   <input type="text" name="text"
                                          placeholder="请输入内容" autocomplete="off" class="layui-input updateStudentParent_phone"
                                          id="updateStudentParent_phone">
                                </div>
                           </span></th>
                            <th colspan="4">工作单位：<span>
                               <div class="layui-input-inline">
                                   <input type="text" name="text" style="width: 200%"
                                          placeholder="请输入内容" autocomplete="off" class="layui-input updateStudentParent_employer"
                                          id="updateStudentParent_employer">
                                </div>
                           </span></th>
                                    </tr>
                                    <tr>

                        </tr>
                               `)

                    $("#family_member_information").append(`
                           <tr id="family_information2" style="margin-bottom: 20px">
                           <th colspan="4"><span>
                            <div class="political">
                               政治面貌： <div class="layui-input-inline" style="width: 30%;" >
                                 <select name="politicalOutlook1" lay-filter="politicalOutlookParent"  class="updateStudentParent_political_status">
                                   <option value="">请选择</option>  <option value="">请选择</option>
                                   <option value="1" ` + (politicalStatus === "中共党员" ? "selected" : "") + `>中共党员</option>
                                   <option value="2" ` + (politicalStatus === "预备党员" ? "selected" : "") + `>预备党员</option>
                                   <option value="3" ` + (politicalStatus === "共青团员" ? "selected" : "") + `>共青团员</option>
                                   <option value="4" ` + (politicalStatus === "积极分子" ? "selected" : "") + `>积极分子</option>
                                   <option value="5" ` + (politicalStatus === "群众" ? "selected" : "") + `>群众</option>
                                   <option value="6" ` + (isOther ? "selected" : "") + `>其它党派</option>
                                 </select>
                               </div>
                                <span  class="otherParty1" style="display: ` + isShow + `">其它党派:
                                       <div class="layui-input-inline">
                                         <input type="text" name="otherPartyName"  value="` + politicalStatus + `"
                                                placeholder="请输入党派名称"
                                                autocomplete="off" class="layui-input other_updateStudentParent_political_status"
                                                id="other_updateStudentParent_political_status">
                                       </div>
                               </span>
                           </div>
                               </span></th>

                           <th colspan="1">职务：<span>
                                 <div class="layui-input-inline">
                                   <input type="text" name="text"
                                          placeholder="请输入内容" autocomplete="off" class="layui-input updateStudentParent_duties"
                                          id="updateStudentParent_duties">
                                </div>
                           </th>
                           <th colspan="1">
                           <button  class="layui-btn layui-btn-danger delStudentFamily" onclick="student.delStudentFamily(` + (familyList[j].id) + `)"　 style="margin-bottom: 10px;float: right;" value="` + familyList[j].id + `"><i class="layui-icon">&#xe640;</i>删除</button>
                            </th>
                                    </tr>`)

//                    $("#family_member_information").append(` `)

                }

                let family_relationship = $(".family_relationship");//称谓
                let updateStudentParentsName = $(".updateStudentParentsName");//家庭成员姓名


                let updateStudentParent_employer = $(".updateStudentParent_employer");//工作单位
                let updateStudentParent_duties = $(".updateStudentParent_duties");//职务
                let updateStudentParent_phone = $(".updateStudentParent_phone");//联系电话
                for (var i = 0; i < familyList.length; i++) {
                    $(family_relationship[i].append(familyList[i].relationship))
                    $(updateStudentParentsName[i]).val(familyList[i].name)

                    $(updateStudentParent_employer[i]).val(familyList[i].work_place);
                    $(updateStudentParent_duties[i]).val(familyList[i].staff);
                    $(updateStudentParent_phone[i]).val(familyList[i].phone);


                }

                $(updateStudentParent_phone[i]).formatInput({
                    formatArr: [3, 4, 4],
                    delimiter: '-'
                });
            },

            //教育经历显示列表
            educationalExperience: function (experienceList) {
                $("#educational_experience").html("")
                for (let i = 0; i < experienceList.length; i++) {

                    $("#educational_experience").append(`<tr style="margin-bottom: 20px">
                                        <th colspan="1" width="40%"><span>
                                            <div class="layui-input-inline" style="width: 40%;float: left">
                                                <input name="date" lay-verify="date" placeholder="yyyy-mm-dd"
                                                       autocomplete="off" class="layui-input educational_experience_start"
                                                       onclick="layui.laydate({elem: this})" type="text"
                                                       id="educational_experience_start">
                                            </div>
                                            <span style="float: left;margin-top: 8px"><p class="layui-input-inline" style="align-content:center;">&nbsp;&nbsp;至&nbsp;&nbsp;</p></span>
                                             <div class="layui-input-inline" style="width: 40%;float: left">
                                                <input name="date" lay-verify="date" placeholder="yyyy-mm-dd"
                                                       autocomplete="off" class="layui-input educational_experience_end"
                                                       onclick="layui.laydate({elem: this})" type="text"
                                                       id="educational_experience_end">
                                            </div>
                                        </span></th>
                                        <th colspan="4" width="40%"><span>学校：
                                            <div class="layui-input-inline" style="width: 80%">
                                                <input type="text" name="text"
                                                       placeholder="请输入学校名称" autocomplete="off" class="layui-input update_schoolName" id="update_schoolName">
                                             </div>
                                        </span></th>
                                        <th colspan="1" width="25%"><span>证明人：
                                            <div class="layui-input-inline" style="width: 60%">
                                                <input type="text" name="text"
                                                       placeholder="请输入证明人" autocomplete="off" class="layui-input update_duties" id="update_duties">
                                             </div>
                                        </span></th>
                                        <th>
                                            <button class="layui-btn  layui-btn-danger" onclick="student.delExperience(this,` + experienceList[i].id + `)" style="margin-bottom: 10px;float: right;"><i class="layui-icon">&#xe640;</i> 删除</button>
                                        </th>
                                    </tr>`)

                }

                let updateSchoolName = $(".update_schoolName");
                let educational_experience_start = $(".educational_experience_start");
                let educational_experience_end = $(".educational_experience_end");
                let update_duties = $(".update_duties");
                for (let i = 0; i < experienceList.length; i++) {
                    $(updateSchoolName[i]).val(experienceList[i].work_place);
                    $(educational_experience_start[i]).val(experienceList[i].start_time);
                    $(educational_experience_end[i]).val(experienceList[i].end_time);
                    $(update_duties[i]).val(experienceList[i].staff);
                }

            },
            //获奖与荣誉显示列表
            updateStudentAwardOrPunishment: function (AwardOrPunishmentList) {
                $("#updateStudent_Award_or_punishment").html("")
                for (let i = 0; i < AwardOrPunishmentList.length; i++) {
                    $("#updateStudent_Award_or_punishment").append(`<tr style="margin-bottom: 20px;">
                                        <th colspan="1" width="25%"><span>时间：
                                            <div class="layui-input-inline">
                                                <input name="date" lay-verify="date" placeholder="yyyy-mm-dd"
                                                       autocomplete="off" class="layui-input updateStudent_Award_or_punishment_date"
                                                       onclick="layui.laydate({elem: this})"
                                                        type="text" id="updateStudent_Award_or_punishment_date">
                                            </div>
                                           </th>

                                        <th colspan="3" width="50%"><span>内容：
                                            <div class="layui-input-inline" style="width: 90%">
                                                <input type="text" name="text"
                                                       placeholder="内容" autocomplete="off" class="layui-input updateStudent_Award_or_punishment_content" id="updateStudent_Award_or_punishment_content">
                                             </div>
                                        </span></th>
                                        <th colspan="1" width="15%">证明人：<span  class="updateStudent_witness"id = "updateStudent_witness"></span></th>
                                        <th colspan="1" width="10%">
                                            <button class="layui-btn  layui-btn-danger" onclick="student.delAward(this,` + AwardOrPunishmentList[i].id + `)" style="margin-bottom: 10px;float: right;"><i class="layui-icon">&#xe640;</i> 删除</button>
</th>
                                    </tr>`)
                }

                let updateStudent_Award_or_punishment_date = $(".updateStudent_Award_or_punishment_date");
                let updateStudent_Award_or_punishment_content = $(".updateStudent_Award_or_punishment_content");
                let updateStudent_witness = $(".updateStudent_witness");
                for (let i = 0; i < AwardOrPunishmentList.length; i++) {
                    $(updateStudent_Award_or_punishment_date[i]).val(AwardOrPunishmentList[i].date);
                    $(updateStudent_Award_or_punishment_content[i]).val(AwardOrPunishmentList[i].centent);
                    $(updateStudent_witness[i]).html(AwardOrPunishmentList[i].witness);
                }
            },

            //违纪与处分显示列表
            updateStudentDisciplineAndPunishment: function (disciplineAndPunishmentList) {
                $("#updateStudent_disciplineAndPunishment").html("")
                for (let i = 0; i < disciplineAndPunishmentList.length; i++) {
                    $("#updateStudent_disciplineAndPunishment").append(`<tr style="margin-bottom: 20px;" class="this_updateStudent_disciplineAndPunishment">
                                        <th colspan="1"><span>时间：
                                            <div class="layui-input-inline" style="width: 60%">
                                                        <input name="date" lay-verify="date" placeholder="yyyy-MM-dd"
                                                       autocomplete="off" class="layui-input updateStudent_disciplineAndPunishment_date"
                                                       onclick="layui.laydate({elem: this})"
                                                        type="text" id="updateStudent_disciplineAndPunishment_date" disabled="disabled">
                                            </div>
                                           </th>
                                           <th colspan="1">
                                            <label class="layui-form-label" style="width: auto;margin-right: 0px">类别</label>
                <div class="layui-input-inline" style="width: 60%">
                     <div class="layui-form-item" style="margin-bottom: 0px";>
                    <div class="layui-input-inline" style="width: 85%">
                        <input type="text" name="witness" id="show_dateDisciplineAndPunishmentCategory"
                               autocomplete="off" class="layui-input show_dateDisciplineAndPunishmentCategory" disabled="disabled">
                    </div>
                </div>
                </div>
</th>
                                           <th colspan="1">
                                           <label class="layui-form-label" style="width: auto;margin-right: 0px">行为</label>
                <div class="layui-input-inline" style="width: 60%">
                         <div class="layui-form-item" style="margin-bottom: 0px";>
                    <div class="layui-input-inline" style="width: 85%">
                        <input type="text" name="witness" id="show_dateDisciplineAndPunishmentBehavior"
                               autocomplete="off" class="layui-input show_dateDisciplineAndPunishmentBehavior" disabled="disabled">
                    </div>
                </div>
</th>
                                           <th colspan="1">
                                           <label class="layui-form-label" style="width: auto;margin-right: 0px">级别</label>
                <div class="layui-input-inline" style="width: 60%">
                        <div class="layui-form-item" style="margin-bottom: 0px";>
                    <div class="layui-input-inline" style="width: 85%">
                        <input type="text" name="witness" id="show_dateDisciplineAndPunishmentRank"
                               autocomplete="off" class="layui-input show_dateDisciplineAndPunishmentRank" disabled="disabled">
                    </div>
                </div>
</th>
                                           <th colspan="1">
                                           <div class="layui-form-item" style="margin-bottom: 0px";>
                    <label class="layui-form-label" style="width: auto;margin-right: 0px">证明人</label>
                    <div class="layui-input-inline" style="width: 50%">
                        <input type="text" name="witness" id="show_witnessByDiscipline"
                               autocomplete="off" class="layui-input show_witnessByDiscipline" disabled="disabled">
                    </div>
                </div>
</th>

                                        <th colspan="1" width="100px">
                                         <button class="layui-btn  layui-btn-danger" onclick="student.delDisciplineAndPunishment(this,` + disciplineAndPunishmentList[i].id + `)" style="margin-bottom: 10px;float: right;"><i class="layui-icon">&#xe640;</i> 删除</button>
                                            <button class="layui-btn " onclick="student.revokeDisciplineAndPunishment(this,` + disciplineAndPunishmentList[i].id + `)" style="margin-bottom: 10px;float: right;"><i class="layui-icon">&#xe65c;</i> 撤销</button>
</th>
                                    </tr>`)
                }
                form.render();
//
                let updateStudent_disciplineAndPunishment_date = $(".updateStudent_disciplineAndPunishment_date");
                let updateStudent_disciplineAndPunishment_content = $(".updateStudent_disciplineAndPunishment_content");
                let show_witnessByDiscipline = $(".show_witnessByDiscipline");
                let show_dateDisciplineAndPunishmentCategory = $(".show_dateDisciplineAndPunishmentCategory")
                let show_dateDisciplineAndPunishmentBehavior = $(".show_dateDisciplineAndPunishmentBehavior")
                let show_dateDisciplineAndPunishmentRank = $(".show_dateDisciplineAndPunishmentRank");

                for (let i = 0; i < disciplineAndPunishmentList.length; i++) {
                    $(updateStudent_disciplineAndPunishment_date[i]).val(disciplineAndPunishmentList[i].date);
                    $(updateStudent_disciplineAndPunishment_content[i]).val(disciplineAndPunishmentList[i].content);
                    $(show_witnessByDiscipline[i]).val(disciplineAndPunishmentList[i].witness);
                    $(show_dateDisciplineAndPunishmentCategory[i]).val(disciplineAndPunishmentList[i].category);
                    $(show_dateDisciplineAndPunishmentBehavior[i]).val(disciplineAndPunishmentList[i].behavior);
                    $(show_dateDisciplineAndPunishmentRank[i]).val(disciplineAndPunishmentList[i].rank);
                }

                let this_updateStudent_disciplineAndPunishment = $(".this_updateStudent_disciplineAndPunishment");
                for (let i = 0; i < disciplineAndPunishmentList.length; i++) {
                    if (disciplineAndPunishmentList[i].revokeDiscipline == "none") {
                        $(this_updateStudent_disciplineAndPunishment[i]).css({background: "#A9A9A9"});
                        $(this_updateStudent_disciplineAndPunishment[i]).find("button:last").css({display: "none"});
                    }
                }

            },

            //团学活动显示列表
            updateStudentGroupActivities: function (groupActivitiesList) {
                $("#updateStudent_GroupActivities").html("")
                for (let i = 0; i < groupActivitiesList.length; i++) {
                    $("#updateStudent_GroupActivities").append(`<tr style="margin-bottom: 20px;">
                                        <th colspan="1"><span>时间：
                                            <div class="layui-input-inline" style="width: 60%;">
                                                <input name="date" lay-verify="date" placeholder="yyyy-mm-dd"
                                                       autocomplete="off" class="layui-input updateStudent_GroupActivities_date"
                                                       onclick="layui.laydate({elem: this})"
                                                        type="text" id="updateStudent_GroupActivities_date" disabled="disabled">
                                            </div>
                                           </th>

                                                                                 <th colspan="1">
                                            <label class="layui-form-label" style="width: auto;margin-right: 0px">类型</label>
                <div class="layui-input-inline" style="width: 60%">
                     <div class="layui-form-item" style="margin-bottom: 0px";>
                    <div class="layui-input-inline" style="width: 85%">
                        <input type="text" name="witness" id="show_updateStudent_GroupActivities_types"
                               autocomplete="off" class="layui-input show_updateStudent_GroupActivities_types" disabled="disabled">
                    </div>
                </div>
                </div>
</th>
                                           <th colspan="1" style="width: 10%">
                                           <label class="layui-form-label" style="width: auto;margin-right: 0px;padding-left: 0px;padding-right: 0px;">学时</label>
                <div class="layui-input-inline" style="width: 65%">
                         <div class="layui-form-item" style="margin-bottom: 0px";>
                    <div class="layui-input-inline" style="width: 85%">
                        <input type="text" name="witness" id="show_updateStudent_GroupActivities_hours"
                               autocomplete="off" class="layui-input show_updateStudent_GroupActivities_hours" disabled="disabled">
                    </div>
                </div>
</th>
                                           <th colspan="1" style="width: 30%">
                                           <label class="layui-form-label" style="width: auto;margin-right: 0px">名称</label>
                <div class="layui-input-inline" style="width: 80%">
                        <div class="layui-form-item" style="margin-bottom: 0px";>
                    <div class="layui-input-inline" style="width: 85%">
                        <input type="text" name="witness" id="show_updateStudent_GroupActivities_heading"
                               autocomplete="off" class="layui-input show_updateStudent_GroupActivities_heading" disabled="disabled">
                    </div>
                </div>
</th>
                                           <th colspan="1">
                                           <div class="layui-form-item" style="margin-bottom: 0px";>
                    <label class="layui-form-label" style="width: auto;margin-right: 0px">证明人</label>
                    <div class="layui-input-inline" style="width: 50%">
                        <input type="text" name="witness" id="show_updateStudent_GroupActivities_witness"
                               autocomplete="off" class="layui-input show_updateStudent_GroupActivities_witness" disabled="disabled">
                    </div>
                </div>
</th>
  <th colspan="1">
                                            <button class="layui-btn  layui-btn-danger" onclick="student.delGroupActivities(this,` + groupActivitiesList[i].id + `)" style="margin-bottom: 10px;float: right;"><i class="layui-icon">&#xe640;</i> 删除</button>
</th>
                                    </tr>`)

                }

                let updateStudent_GroupActivities_date = $(".updateStudent_GroupActivities_date");
                let updateStudent_GroupActivities_content = $(".updateStudent_GroupActivities_content");
                let show_updateStudent_GroupActivities_types = $(".show_updateStudent_GroupActivities_types");
                let show_updateStudent_GroupActivities_hours = $(".show_updateStudent_GroupActivities_hours");
                let show_updateStudent_GroupActivities_heading = $(".show_updateStudent_GroupActivities_heading");
                let show_updateStudent_GroupActivities_witness = $(".show_updateStudent_GroupActivities_witness");
                for (let i = 0; i < groupActivitiesList.length; i++) {
                    $(updateStudent_GroupActivities_date[i]).val(groupActivitiesList[i].date);
                    $(show_updateStudent_GroupActivities_types[i]).val(groupActivitiesList[i].types);
                    $(show_updateStudent_GroupActivities_hours[i]).val(groupActivitiesList[i].hours);
                    $(show_updateStudent_GroupActivities_heading[i]).val(groupActivitiesList[i].heading);
                    $(show_updateStudent_GroupActivities_witness[i]).val(groupActivitiesList[i].witness);
                }
            },

            addAwardOrPunishmentInfo: function () {
                addAwardOrPunishmentInfoIndex = layer.open({
                    type: 1,
                    title: "添加荣誉或获奖",
                    area: ["40%", "60%"],
                    content: $("#addAwardOrPunishment")

                });
            },

            addDisciplineAndPunishmentInfo: function () {
                addDisciplineAndPunishmentInfoIndex = layer.open({
                    type: 1,
                    title: "添加违纪与处分",
                    area: ["40%", "70%"],
                    content: $("#addDisciplineAndPunishment")

                });
            },

            addGroupActivitiesInfo: function () {
                addGroupActivitiesIndex = layer.open({
                    type: 1,
                    title: "添加团学活动",
                    area: ["40%", "65%"],
                    content: $("#addGroupActivities")

                });
            },

            delStudentFamily: function (familyId) {
                layer.confirm('该操作将直接删除，无需更新！是否删除？', {icon: 3, title: '提示'}, function (index) {
                    layer.close(index);
                    let studentNo = studentInfo.no;
                    $.post(baseUrl + "/student/delStudentFamily",
                        {familyId: familyId, studentNo: studentNo},
                        function (data) {
                            if (data.result) {
                                layer.msg("删除成功!");
                                student.familyFnformation(data.data);
                                form.render();
                            }
                        })
                })
            },
            addStudentFamilyInfo: function () {
//                document.getElementById("add_family_member_information_list").reset();
                addStudentFamilyInfoIndex = layer.open({
                    type: 1,
                    title: "添加学生家庭信息",
                    area: ["40%", "80%"],
                    content: $("#addStudentFamily")

                });

            },
            //添加荣誉与获奖的弹框
            addAwardOrPunishmentByUpdate: function () {
                let dateAwardOrPunishment = $("#dateAwardOrPunishment").val();
                let contentAwardOrPunishment = $("#contentAwardOrPunishment").val();
                let witness = $("#witness").val();
                layer.confirm('该操作将直接添加，无需更新！是否添加？', {icon: 3, title: '提示'}, function (index) {
                    let studentNo = studentInfo.no;
                    $.post(baseUrl + "/student/addAwardOrPunishmentByUpdate",
                        {
                            studentNo: studentNo,
                            date: dateAwardOrPunishment,
                            centent: contentAwardOrPunishment,
                            witness: witness
                        },
                        function (data) {
                            if (data.result) {
                                layer.msg(data.msg, {icon: 1});
                                layer.close(addAwardOrPunishmentInfoIndex);
                                student.updateStudentAwardOrPunishment(data.data);

                            }
                        }
                    )
                })

            },
            //添加违纪与处分的弹框
            addDisciplineAndPunishmentByUpdate: function () {
                let dateDisciplineAndPunishment = $("#dateDisciplineAndPunishment").val();
                let category = $("#dateDisciplineAndPunishmentCategory").find("option:selected").text();
                let behavior = $("#dateDisciplineAndPunishmentBehavior").find("option:selected").text();
                let rank = $("#dateDisciplineAndPunishmentRank").find("option:selected").text();
                let witness = $("#witnessByDiscipline").val();

                layer.confirm('该操作将直接添加，无需更新！是否添加？', {icon: 3, title: '提示'}, function (index) {
                    let studentNo = studentInfo.no;
                    $.post(baseUrl + "/student/addDisciplineAndPunishmentByUpdate",
                        {
                            studentNo: studentNo,
                            date: dateDisciplineAndPunishment,
                            category: category,
                            behavior: behavior,
                            rank: rank,
                            witness: witness,
                        },
                        function (data) {
                            if (data.result) {
                                layer.msg(data.msg, {icon: 1});
                                layer.close(addDisciplineAndPunishmentInfoIndex);
                                student.updateStudentDisciplineAndPunishment(data.data);
                            }
                        }
                    )
                })

            },
            //添加团学活动的弹框
            addGroupActivitiesIndexByUpdate: function () {
                let dateGroupActivities = $("#dateGroupActivities").val();
                let typesOfGroupActivities = $("#typesOfGroupActivities").find("option:selected").text();
                let hoursOfSchoolGroupActivities = $("#hoursOfSchoolGroupActivities").val();
                let headingGroupActivities = $("#headingGroupActivities").val();
                let witnessGroupActivities = $("#witnessGroupActivities").val();

                layer.confirm('该操作将直接添加，无需更新！是否添加？', {icon: 3, title: '提示'}, function (index) {
                    let studentNo = studentInfo.no;
                    $.post(baseUrl + "/student/addGroupActivitiesByUpdate",
                        {
                            studentNo: studentNo,
                            date: dateGroupActivities,
                            types: typesOfGroupActivities,
                            hours: hoursOfSchoolGroupActivities,
                            heading: headingGroupActivities,
                            witness: witnessGroupActivities,
                        },
                        function (data) {
                            if (data.result) {
                                layer.msg(data.msg, {icon: 1});
                                layer.close(addGroupActivitiesIndex);
                                student.updateStudentGroupActivities(data.data);
                            }
                        }
                    )
                })

            },
            addFamilyByUpdate: function () {
                let family_relationship = $("#family_relationship").val();
                let family_name = $("#family_name").val();
                let family_work_place = $("#family_work_place").val();
                let family_staff = $("#family_staff").val();
                let family_phone_add = $("#family_phone_add").val();
                if ($("#family_political_status").find("option:selected").text() == "其它党派") {
                    var family_political_status = $("#other_family_political_status").val();
                } else {
                    var family_political_status = $("#family_political_status").find("option:selected").text();
                }
                layer.confirm('该操作将直接添加，无需更新！是否添加？', {icon: 3, title: '提示'}, function (index) {
                    let studentNo = studentInfo.no;
                    $.post(baseUrl + "/student/addFamilyByUpdate",
                        {
                            no: studentNo,
                            relationship: family_relationship,
                            name: family_name,
                            work_place: family_work_place,
                            staff: family_staff,
                            phone: family_phone_add,
                            political_status: family_political_status,
                            studentNo: studentNo
                        },
                        function (data) {
                            if (data.result) {
                                layer.msg(data.msg, {icon: 1});
                                layer.close(addStudentFamilyInfoIndex);
                                student.familyFnformation(data.data);
                                form.render();
                            }
                        }
                    )
                })
            },
            addExperienceInfo: function () {
                addExperienceByUpdateOffOpen = layer.open({
                    type: 1,
                    title: "添加学生教育经历",
                    area: ["40%", "60%"],
                    content: $("#addExperienceInfo")
                })
            },
            delExperience: function (t, experienceId) {
                layer.confirm('该操作直接删除，无需更新。确定删除？', {icon: 3, title: '提示'}, function (index) {
                    let studentNo = studentInfo.no;
                    $.post(baseUrl + "/student/delExperience",
                        {experienceId: experienceId, studentNo: studentNo},
                        function (data) {
                            if (data.result) {
                                layer.msg("删除成功!");
                                student.educationalExperience(data.data);
                                $(t).parents("tr").remove();
                            }
                        })
                })
            },
            delAward: function (t, id) {
                layer.confirm('该操作直接删除，无需更新。确定删除？', {icon: 3, title: '提示'}, function (index) {
                    let studentNo = studentInfo.no;
                    $.post(baseUrl + "/student/delAward",
                        {id: id, studentNo: studentNo},
                        function (data) {
                            if (data.result) {
                                layer.msg("删除成功!");
                                $(t).parents("tr").remove();
                            }
                        })
                })
            },

            //删除违纪与处分按钮
            delDisciplineAndPunishment: function (t, id) {
                layer.confirm('该操作直接删除，无需更新。确定删除？', {icon: 3, title: '提示'}, function (index) {
                    let studentNo = studentInfo.no;
                    $.post(baseUrl + "/student/delDisciplineAndPunishment",
                        {id: id, studentNo: studentNo},
                        function (data) {
                            if (data.result) {
                                layer.msg("删除成功!");
                                $(t).parents("tr").remove();
                            }
                        })
                })
            },
            //撤销违纪与处分按钮
            revokeDisciplineAndPunishment: function (t, id) {
                layer.confirm('该操作直接撤销，无需更新。确定撤销？', {icon: 3, title: '提示'}, function (index) {
                    let studentNo = studentInfo.no;
                    let revokeDiscipline = "none";
                    $.post(baseUrl + "/student/revokeDisciplineAndPunishment",
                        {id: id, studentNo: studentNo, revokeDiscipline: revokeDiscipline},
                        function (data) {
                            if (data.result) {
                                layer.msg("撤销成功!");
                                $(t).parents("tr").css({background: "#A9A9A9"});
                                $(t).parents("tr").find("button:last").css({display: "none"});
                            }
                        })
                })
            },

            //删除团学活动记录按钮
            delGroupActivities: function (t, id) {
                layer.confirm('该操作直接删除，无需更新。确定删除？', {icon: 3, title: '提示'}, function (index) {
                    let studentNo = studentInfo.no;
                    $.post(baseUrl + "/student/delGroupActivities",
                        {id: id, studentNo: studentNo},
                        function (data) {
                            if (data.result) {
                                layer.msg("删除成功!");
                                $(t).parents("tr").remove();
                            }
                        })
                })
            },
            //当健康状况为其它时，显示输入框
            show_updateOtherHealthStatus: function () {
                if ($("#health").find("input:checked").val() == "其它") {
                    $("#show_updateOtherHealthStatus").show();
                } else {
                    $("#show_updateOtherHealthStatus").hide();
                }
            },
            //当页面加载时，根据单选按钮判断是否显示健康状况的输入框
            showLoad_updateOtherHealthStatus: function () {
                if ($("#health").find("input:checked").val() == "其它") {
                    $("#show_updateOtherHealthStatus").show();
                } else {
                    $("#show_updateOtherHealthStatus").hide();
                }
            },
            addExperienceByUpdate: function () {
                let startDateExperience = $("#startDateExperience").val();
                let endDateExperience = $("#endDateExperience").val();
                let placeExperience = $("#placeExperience").val();
                let staffExperience = $("#staffExperience").val();
                let studentNo = studentInfo.no;

                layer.confirm('确定添加？', {icon: 3, title: '提示'}, function (index) {
                    $.post(baseUrl + "/student/addExperienceByUpdate",
                        {
                            start_time: startDateExperience,
                            end_time: endDateExperience,
                            work_place: placeExperience,
                            staff: staffExperience,
                            no: studentNo
                        },
                        function (data) {
                            layer.msg(data.msg);
                            student.educationalExperience(data.data);
                            layer.close(addExperienceByUpdateOffOpen);
                        }
                    )
                })
            },

            isOther: function (political) {
                if (political != "中共党员" && political != "预备党员" && political != "共青团员" && political != "积极分子" && political != "群众" && political != "请选择")
                    return true;

                return false;
            },
            showAreaInfo() {
                let stay_type = $('#update_accommodation_type input[name="accommodation_type"]:checked ').val();
                if (stay_type === '2') {
                    $("#dorms").hide();
                    $("#OffCampusAddress").show();
                } else {
                    $("#dorms").show();
                    $("#OffCampusAddress").hide();
                }
            },

            showSAT_score() {
                let student_type = $("#updateStudentType input[name='student_type']:checked").val();
                if (student_type === "高考录取") {
                    $("#show_SAT_score").show();
                } else {
                    $("#upadte_SAT_score").val("");
                    $("#show_SAT_score").hide();
                }
            },

            queryAreaAndFloorAndRoomByRoomIdOfUpdate: function (roomId) {
                $.post(baseUrl + "dorm/room/queryAreaAndFloorAndRoomByRoomId",
                    {
                        roomId: roomId
                    },
                    function (data) {
                        if (data.result) {
                            if (data.data.dorms != null) {
                                let dormsHtml = "";
                                dormsHtml += data.data.dorms.areaName + " # ";
                                dormsHtml += data.data.dorms.floorName + " # ";
                                dormsHtml += data.data.dorms.roomName + "宿舍";

                                $("#updateDorms").val(dormsHtml);
                            }

                        }
                    })
            },

            queryAreaAndFloorOfUpdate: function () {
                $.post(baseUrl + "dorm/room/showAreaAndFloorsToQuery", function (data) {
                    if (data.result) {
                        $("#queryAreas").html(student.loadDepartmentOrDirection(data.data.queryAreaOfRoom, "-"))
                        $("#queryFloors").html(student.loadDepartmentOrDirection(data.data.queryFloorOfRoom, "-"))
                    }
                    form.render();
                })
            },

            loadDepartmentOrDirection: function (data, selectId) {
                let _html = "<option value=\"\">请选择</option>";
                for (let i = 0; i < data.length; ++i) {
                    if (selectId == data[i].id) {
                        _html += `<option  selected value="` + data[i].id + `">` + data[i].name + `</option>`;
                    } else {
                        _html += `<option value="` + data[i].id + `">` + data[i].name + `</option>`;
                    }
                }

                return _html;
            },
            //显示党派或团体组织文本输入框
            showPartyOrGroupOrganization: function () {
                if ($("#partyOrGroupOrganization").find("input:checked").val() == "有") {
                    $("#showPartyOrGroupOrganizationText").show();
                } else {
                    $("#showPartyOrGroupOrganizationText").hide();
                    $("#partyOrGroupOrganizationText").val("");
                }
            },
            //显示入学前受过何奖励或处分输入框
            showPre_admissionOrReward: function () {
                if ($("#Pre_admissionOrReward").find("input:checked").val() == "有") {
                    $("#showPre_admissionOrRewardText").show();
                } else {
                    $("#showPre_admissionOrRewardText").hide();
                    $("#Pre_admissionOrRewardText").val("");
                }
            },

            updateStudentList: function () {

                let phone = $("#studentPhone").val();
                let qq = $("#studentQQ").val();
                let email = $("#studentEmail").val();

                var no = $("#updateStudentNo").val()
                var name = $("#updateStudentName").val();
                var is_marry = $('#isMarry input[name="isMarry"]:checked ').val()
                var height = $("#updateStudentHeight").val();
                var born = $("#updateStudentBirthday").val();
                var weight = $("#updateStudentWight").val();
                var famous_family = $("#updateStudentNationalities").val();
                var health_status = $('#health input[name="health"]:checked ').val();
                var otherHealthStatus = $('#updateOtherHealthStatus').val();
                var student_type = $('#updateStudentType input[name="student_type"]:checked').val();
                var stay_type = $('#update_accommodation_type input[name="accommodation_type"]:checked ').val();
                var is_out = $('#update_isOut input[name="isOut"]:checked ').val();
                var blood = $("#updateStudentBloodType").find("option:selected").text()
                var religionText = $("#religiousBeliefText").val();
                var religion = $("#religiousBelief").find("input:checked").val();
                if ($("#updateStudentPoliticalOutlook").find("option:selected").text() == "其它党派") {
                    var political_status = $("#otherUpdateStudentPoliticalOutlook").val()
                } else {
                    var political_status = $("#updateStudentPoliticalOutlook").find("option:selected").text()
                }

                if ($("#updateStudent_pre_school_education").find("option:selected").text() == "其它") {
                    var pre_school_education = $("#other_updateStudent_pre_school_education").val()
                } else {
                    var pre_school_education = $("#updateStudent_pre_school_education").find("option:selected").text()
                }

                var student_classify = $("#student_classify input[name='student_classify']:checked").val()
                //校外住址
                if ($("#province12").find("option:selected").text() == "—— 省 ——" || $("#city12").find("option:selected").text() == "—— 市 ——" || $("#district12").find("option:selected").text() == "—— 区/县 ——") {
                    var off_school_stay_address = $("#updateOffCampusAddress").val();
                } else {
                    let detailedAddresses = "";
                    detailedAddresses += $("#province12").find("option:selected").text() + "-";
                    detailedAddresses += $("#city12").find("option:selected").text() + "-";
                    detailedAddresses += $("#district12").find("option:selected").text() + "-";
                    detailedAddresses += $("#detailedOffCampusAddress").val();
                    var off_school_stay_address = detailedAddresses;
                }
                var updateOffCampusContactPhone = $("#updateOffCampusContactPhone").val();
                var updateOffCampusContactName = $("#updateOffCampusContactName").val();
                //籍贯
                if ($("#province9").find("option:selected").text() == "—— 省 ——" || $("#city9").find("option:selected").text() == "—— 市 ——" || $("#district9").find("option:selected").text() == "—— 区/县 ——" || $("#detailedOffCampusAddress").val() != null) {
                    var native_place = $("#updateStudentNativePlace").val();
                } else {
                    let detailedAddresses = "";
                    detailedAddresses += $("#province9").find("option:selected").text() + "-";
                    detailedAddresses += $("#city9").find("option:selected").text() + "-";
                    detailedAddresses += $("#district9").find("option:selected").text();
                    var native_place = detailedAddresses;
                }
                //身份证住址
                if ($("#province0").find("option:selected").text() == "—— 省 ——" || $("#city0").find("option:selected").text() == "—— 市 ——" || $("#district0").find("option:selected").text() == "—— 区/县 ——") {
                    var idcard_address = $("#Identity_card_address").val();
                } else {
                    let detailedAddresses = "";
                    detailedAddresses += $("#province0").find("option:selected").text() + "-";
                    detailedAddresses += $("#city0").find("option:selected").text() + "-";
                    detailedAddresses += $("#district0").find("option:selected").text() + "-";
                    detailedAddresses += $("#detailedUpdateCardAddress").val();
                    var idcard_address = detailedAddresses;
                }
                //家庭实际住址
                $("#province3").find("option:selected").text()
                $("#city3").find("option:selected").text()
                $("#district3").find("option:selected").text()
                if ($("#province3").find("option:selected").text() == "—— 省 ——" || $("#city3").find("option:selected").text() == "—— 市 ——" || $("#district3").find("option:selected").text() == "—— 区/县 ——" || $("#detailedAddress").val() == "") {
                    var actual_address = $("#detailedAddresses").val()
                } else {
                    var detailedAddresses = "";
                    detailedAddresses += $("#province3").find("option:selected").text() + "-";
                    detailedAddresses += $("#city3").find("option:selected").text() + "-";
                    detailedAddresses += $("#district3").find("option:selected").text() + "-";
                    detailedAddresses += $("#detailedAddress").val();
                    var actual_address = detailedAddresses;
                }

                if ($("#province1").find("option:selected").text() == "—— 省 ——" || $("#city1").find("option:selected").text() == "—— 市 ——" || $("#district1").find("option:selected").text() == "—— 区/县 ——") {
                    var origin_address = $("#update_name_of_the_source").val()
                } else {
                    var detailedAddresses = "";
                    detailedAddresses += $("#province1").find("option:selected").text() + "-";
                    detailedAddresses += $("#city1").find("option:selected").text() + "-";
                    detailedAddresses += $("#district1").find("option:selected").text();
                    var origin_address = detailedAddresses;
                }

                var family_zip_code = $("#updateStudentZip_code").val();
                var family_phone = $("#updateStudentHome_phone").val();
                var emergency_contact_name = $("#updateStudent_emergency_contact").val();
                var emergency_contact_method = $("#updateStudent_emergency_contact_phone").val();
                var account_in = $("#whetherToTransfer input[name='whetherToTransfer']:checked").val()
                var area_origin_name = $("#birthplaceName input[name='birthplaceName']:checked").val()

                //党派或团体组织
                var partyOrGroupOrganization = $("#partyOrGroupOrganization").find("input:checked").val();
                var partyOrGroupOrganizationText = $("#partyOrGroupOrganizationText").val();
                //入学前受过何奖励或处分
                var Pre_admissionOrReward = $("#Pre_admissionOrReward").find("input:checked").val();
                var Pre_admissionOrRewardText = $("#Pre_admissionOrRewardText").val();

                //入学前档案所在单位
                if ($("#province2").find("option:selected").text() == "—— 省 ——" || $("#city2").find("option:selected").text() == "—— 市 ——" || $("#district2").find("option:selected").text() == "—— 区/县 ——" || $("#updateStudent_Pre_enrollment_file_unit_detailed").val() == "") {
                    var pre_school_file_where_location = $("#Pre_enrollment_file_unit").val()
                } else {
                    var detailedAddresses = "";
                    detailedAddresses += $("#province2").find("option:selected").text() + "-";
                    detailedAddresses += $("#city2").find("option:selected").text() + "-";
                    detailedAddresses += $("#district2").find("option:selected").text() + "-";
                    detailedAddresses += $("#updateStudent_Pre_enrollment_file_unit_detailed").val();
                    var pre_school_file_where_location = detailedAddresses;
                }

                var file_in = $("#is_the_file_transferred input[name='is_the_file_transferred']:checked").val();
                var pre_school_name = $("#Pre_school_name").val();

                //入学前户口所在派出所
                if ($("#province5").find("option:selected").text() == "—— 省 ——" || $("#city5").find("option:selected").text() == "—— 市 ——" || $("#district5").find("option:selected").text() == "—— 区/县 ——" || $("#Pre_school_account_where_the_police_station_detailed").val() == "") {
                    var pre_school_account_where_station = $("#Pre_enrollment_file_unit").val()
                } else {
                    var detailedAddresses = "";
                    detailedAddresses += $("#province5").find("option:selected").text() + "-";
                    detailedAddresses += $("#city5").find("option:selected").text() + "-";
                    detailedAddresses += $("#district5").find("option:selected").text() + "-";
                    detailedAddresses += $("#Pre_school_account_where_the_police_station_detailed").val();
                    var pre_school_account_where_station = detailedAddresses;
                }

                //来校前毕业学校或工作单位
                if ($("#province13").find("option:selected").text() == "—— 省 ——" || $("#city13").find("option:selected").text() == "—— 市 ——" || $("#district13").find("option:selected").text() == "—— 区/县 ——" || $("#Pre_school_account_where_the_police_station_detailed").val() == "") {
                    var pre_school_work = $("#pre_school_work").val()
                } else {
                    var detailedAddresses = "";
                    detailedAddresses += $("#province13").find("option:selected").text() + "-";
                    detailedAddresses += $("#city13").find("option:selected").text() + "-";
                    detailedAddresses += $("#district13").find("option:selected").text() + "-";
                    detailedAddresses += $("#detail_pre_school_work").val();
                    var pre_school_work = detailedAddresses;
                }

                //家庭成员信息
                var updateStudentParentsName = $(".updateStudentParentsName");
                var updateStudentParent_political_status = $(".updateStudentParent_political_status");
                var other_updateStudentParent_political_status = $(".other_updateStudentParent_political_status");
                var updateStudentParent_employer = $(".updateStudentParent_employer");
                var updateStudentParent_duties = $(".updateStudentParent_duties");
                var updateStudentParent_phone = $(".updateStudentParent_phone");

                var updateStudentParentsNameList = [];
                var updateStudentParent_political_statusList = [];
                var updateStudentParent_employerList = [];
                var updateStudentParent_dutiesList = [];
                var updateStudentParent_phoneList = [];
                var updateStudentParentIds = [];

                for (let i = 0; i < familyInfo.length; i++) {
                    updateStudentParentsNameList.push($(updateStudentParentsName [i]).val())
                    if ($(updateStudentParent_political_status [i]).find("option:selected").text() == "其它党派") {
                        updateStudentParent_political_statusList.push($(other_updateStudentParent_political_status [i]).val())
                    } else {
                        updateStudentParent_political_statusList.push($(updateStudentParent_political_status [i]).find("option:selected").text())
                    }
                    updateStudentParent_employerList.push($(updateStudentParent_employer [i]).val())
                    updateStudentParent_dutiesList.push($(updateStudentParent_duties [i]).val())
                    updateStudentParent_phoneList.push($(updateStudentParent_phone [i]).val())
                    updateStudentParentIds.push(familyInfo[i].id);
                }

                var familyInfoCount = familyInfo.length;

                //教育经历
                //开始时间
                var educational_experience_start = $(".educational_experience_start");
                //结束时间
                var educational_experience_end = $(".educational_experience_end");
                //学校名称
                var update_schoolName = $(".update_schoolName");
                //职务
                var update_duties = $(".update_duties");
                var educational_experience_start_list = [];
                var educational_experience_end_list = [];
                var update_schoolName_list = [];
                var update_duties_start_list = [];
                var experienceIds = [];
                for (let i = 0; i < experienceInfo.length; i++) {
                    educational_experience_start_list.push($(educational_experience_start[i]).val())
                    educational_experience_end_list.push($(educational_experience_end[i]).val())
                    update_schoolName_list.push($(update_schoolName[i]).val())
                    update_duties_start_list.push($(update_duties[i]).val())
                    experienceIds.push(experienceInfo[i].id)
                }
                //获奖与荣誉
                let updateStudent_Award_or_punishment_date = $(".updateStudent_Award_or_punishment_date");
                let updateStudent_Award_or_punishment_content = $(".updateStudent_Award_or_punishment_content");

                var updateStudent_Award_or_punishment_date_list = [];
                var updateStudent_Award_or_punishment_content_list = [];
                var updateStudent_Award_or_punishment_id_list = [];
                for (let i = 0; i < AwardOrPunishmentInfo.length; i++) {
                    updateStudent_Award_or_punishment_date_list.push($(updateStudent_Award_or_punishment_date[i]).val());
                    updateStudent_Award_or_punishment_content_list.push($(updateStudent_Award_or_punishment_content[i]).val());
                    updateStudent_Award_or_punishment_id_list.push(AwardOrPunishmentInfo[i].id);
                }
                //违纪与处分
                let updateStudent_disciplineAndPunishment_dates = $(".updateStudent_disciplineAndPunishment_date");
                let updateStudent_disciplineAndPunishment_contents = $(".updateStudent_disciplineAndPunishment_content");

                var updateStudent_disciplineAndPunishment_date_list = [];
                var updateStudent_disciplineAndPunishment_content_list = [];
                var updateStudent_disciplineAndPunishment_id_list = [];
                for (let i = 0; i < disciplineAndPunishmentListInfo.length; i++) {
                    updateStudent_disciplineAndPunishment_date_list.push($(updateStudent_disciplineAndPunishment_dates[i]).val());
                    updateStudent_disciplineAndPunishment_content_list.push($(updateStudent_disciplineAndPunishment_contents[i]).val());
                    updateStudent_disciplineAndPunishment_id_list.push(disciplineAndPunishmentListInfo[i].id);
                }
                //团学活动
                let updateStudent_GroupActivities_date = $(".updateStudent_GroupActivities_date");
                let updateStudent_GroupActivities_content = $(".updateStudent_GroupActivities_content");

                var updateStudent_groupActivities_date_list = [];
                var updateStudent_groupActivities_content_list = [];
                var updateStudent_groupActivities_id_list = [];
                for (let i = 0; i < groupActivitiesListInfo.length; i++) {
                    updateStudent_groupActivities_date_list.push($(updateStudent_GroupActivities_date[i]).val());
                    updateStudent_groupActivities_content_list.push($(updateStudent_GroupActivities_content[i]).val());
                    updateStudent_groupActivities_id_list.push(groupActivitiesListInfo[i].id);
                }

                $("#educational_experience").val();

                //学业信息
                $("#updateStudentType1 input[name='student_type1']:checked").val();
                //现专业
                var origin_profession_id = $("#studentsNowProfessional").val();
                //录取专业
                var profession_id = $("#studentsProfessionList").val();
                //就业方向
                var direction_id = $("#employment_direction").val();
                //系
                var department_id = $("#student_department").val();
                //班级
                var classes_id = $("#student_class").val();
                //职业导师
                var teacher_id = $("#update_career_mentor").val()
                var community_teacher_id = $("#update_community_counselor").val()

                var student_status = $("#update_student_status").val();

                var hard_type = $("#update_hard_type input[name='update_hard_type']:checked").val();

                var group = $("#student_group").val();

                //缴费状态
                if ($("#update_payment_status").find('option:selected').text() == "欠费") {
                    var payment_status_first_year = $("#update_payment_status").find('option:selected').text()
                    var arrears_first_year = $("#Amount_of_arrears").val()
                } else {
                    var payment_status_first_year = $("#update_payment_status").find('option:selected').text()
                    var arrears_first_year = '0'
                }

                if ($("#update_payment_status2").find('option:selected').text() == "欠费") {
                    var payment_status_second_year = $("#update_payment_status2").find('option:selected').text()
                    var arrears_second_year = $("#Amount_of_arrears2").val()
                } else {
                    var payment_status_second_year = $("#update_payment_status2").find('option:selected').text()
                    var arrears_second_year = '0'
                }

                if ($("#update_payment_status3").find('option:selected').text() == "欠费") {
                    var payment_status_third_year = $("#update_payment_status3").find('option:selected').text()
                    var arrears_third_year = $("#Amount_of_arrears3").val()
                } else {
                    var payment_status_third_year = $("#update_payment_status3").find('option:selected').text()
                    var arrears_third_year = '0'
                }
                if ($("#update_payment_status4").find('option:selected').text() == "欠费") {
                    var payment_status_forth_year = $("#update_payment_status4").find('option:selected').text()
                    var arrears_forth_year = $("#Amount_of_arrears4").val()
                } else {
                    var payment_status_forth_year = $("#update_payment_status4").find('option:selected').text()
                    var arrears_forth_year = '0'
                }
                if ($("#update_payment_status5").find('option:selected').text() == "欠费") {
                    var payment_status_fifth_year = $("#update_payment_status5").find('option:selected').text()
                    var arrears_fifth_year = $("#Amount_of_arrears5").val()
                } else {
                    var payment_status_fifth_year = $("#update_payment_status5").find('option:selected').text()
                    var arrears_fifth_year = '0'
                }
                if ($("#update_payment_status6").find('option:selected').text() == "欠费") {
                    var payment_status_sixth_year = $("#update_payment_status6").find('option:selected').text()
                    var arrears_sixth_year = $("#Amount_of_arrears6").val()
                } else {
                    var payment_status_sixth_year = $("#update_payment_status6").find('option:selected').text()
                    var arrears_sixth_year = '0'
                }

                //实践类型
                if ($("#update_practical_type").find('option:selected').text() == "其它") {
                    var practice_learning_type = $("#other_practical_type").val()
                } else {
                    var practice_learning_type = $("#update_practical_type").find('option:selected').text()
                }
                //单位或项目
                var units_or_projects_practical_type = $("#units_or_projects_practical_type").val();
                var units_or_projects_practical_type_contact = $("#units_or_projects_practical_type_contact").val();
                var units_or_projects_practical_type_contact_phone = $("#units_or_projects_practical_type_contact_phone").val();

                //宿舍信息
                if ($("#queryAreas").val() != "" || $("#queryFloors").val() != "" || $("#queryRooms").val() != "") {
                    var area_id = $("#queryAreas").val()
                    var floor_id = $("#queryFloors").val()
                    var room_id = $("#queryRooms").val()
                } else {
                    var area_id = studentInfo.area_id;
                    var floor_id = studentInfo.floor_id;
                    var room_id = studentInfo.room_id;
                }
                var sat_score = $("#upadte_SAT_score").val();
//                var native_place = $("#updateStudentNativePlace").val();

                var pre_school_staff = $("#update_pre_school_staff").val();

                //获奖或荣誉
                var own_punishment = $("#update_award_or_honor").val();

                //奖助学金
                var first_year = $("#first_scholarship_particularYear").val();
                var first_scholarship = $("#first_scholarship").val();
                var first_stipend = $("#first_stipend").val();
                var second_year = $("#second_scholarship_particularYear").val();
                var second_scholarship = $("#second_scholarship").val();
                var second_stipend = $("#second_stipend").val();
                var third_year = $("#third_scholarship_particularYear").val();
                var third_scholarship = $("#third_scholarship").val();
                var third_stipend = $("#third_stipend").val();

                //医保信息
                var first_time_medical_insurance = $("#first_time_medical_insurance").val()
                var second_time_medical_insurance = $("#second_time_medical_insurance").val()
                var third_time_medical_insurance = $("#third_time_medical_insurance").val()
                var first_medical_insurance = $('input[name="first_medical_insurance"]:checked').val();
                var second_medical_insurance = $('input[name="second_medical_insurance"]:checked').val();
                var third_medical_insurance = $('input[name="third_medical_insurance"]:checked').val();


                layer.confirm('确定修改？', {icon: 3, title: '提示'}, function (index) {
                    layer.close(index);
                    $.post(baseUrl + "/student/updateStudentAjax",
                        {
                            qq: qq,
                            student_contact_method: phone,
                            email: email,
                            no: no,
                            is_marry: is_marry,
                            height: height,
                            weight: weight,
                            head_image: imgName,
                            health_status: health_status,
                            otherHealthStatus: otherHealthStatus,
                            student_type: student_type,
                            born: born,
                            name: name,
                            blood: blood,
                            religion: religion,
                            religionText: religionText,
                            stay_type: stay_type,
                            famous_family: famous_family,
                            department_id: department_id,
                            off_school_stay_address: off_school_stay_address,
                            updateOffCampusContactPhone: updateOffCampusContactPhone,
                            updateOffCampusContactName: updateOffCampusContactName,
                            native_place: native_place,
                            political_status: political_status,
                            pre_school_education: pre_school_education,
                            student_classify: student_classify,
                            idcard_address: idcard_address,
                            is_out: is_out,
                            actual_address: actual_address,
                            origin_address: origin_address,
                            family_zip_code: family_zip_code,
                            family_phone: family_phone,
                            sat_score: sat_score,
                            group: group,
                            emergency_contact_name: emergency_contact_name,
                            emergency_contact_method: emergency_contact_method,
                            account_in: account_in,
                            area_origin_name: area_origin_name,
                            pre_school_file_where_location: pre_school_file_where_location,
                            file_in: file_in,
                            pre_school_name: pre_school_name,
                            pre_school_staff: pre_school_staff,
                            pre_school_work: pre_school_work,
                            pre_school_account_where_station: pre_school_account_where_station,
                            student_status: student_status,//学籍状态
                            hard_type: hard_type,//困难生类别
                            //缴费状态
                            payment_status_first_year: payment_status_first_year,
                            arrears_first_year: arrears_first_year,
                            payment_status_second_year: payment_status_second_year,
                            arrears_second_year: arrears_second_year,
                            payment_status_third_year: payment_status_third_year,
                            arrears_third_year: arrears_third_year,
                            payment_status_forth_year: payment_status_forth_year,
                            arrears_forth_year: arrears_forth_year,
                            payment_status_fifth_year: payment_status_fifth_year,
                            arrears_fifth_year: arrears_fifth_year,
                            payment_status_sixth_year: payment_status_sixth_year,
                            arrears_sixth_year: arrears_sixth_year,

                            practice_learning_type: practice_learning_type,
                            units_or_projects_practical_type: units_or_projects_practical_type,
                            units_or_projects_practical_type_contact: units_or_projects_practical_type_contact,
                            units_or_projects_practical_type_contact_phone: units_or_projects_practical_type_contact_phone,
                            area_id: area_id,
                            floor_id: floor_id,
                            room_id: room_id,

                            //获奖或荣誉
                            own_punishment: own_punishment,
                            //家庭信息
                            familyInfoCount: familyInfoCount,
                            updateStudentParentsNameList: updateStudentParentsNameList,
                            updateStudentParent_political_statusList: updateStudentParent_political_statusList,
                            updateStudentParent_employerList: updateStudentParent_employerList,
                            updateStudentParent_dutiesList: updateStudentParent_dutiesList,
                            updateStudentParent_phoneList: updateStudentParent_phoneList,
                            updateStudentParentIds: updateStudentParentIds,
                            //教育经历
                            educational_experience_start_list: educational_experience_start_list,
                            educational_experience_end_list: educational_experience_end_list,
                            update_schoolName_list: update_schoolName_list,
                            update_duties_start_list: update_duties_start_list,
                            experienceIds: experienceIds,

                            // 录取专业  现专业  就业方向  班级
                            origin_profession_id: origin_profession_id,
                            profession_id: profession_id,
                            direction_id: direction_id,
                            classes_id: classes_id,

                            //教师信息
                            teacher_id: teacher_id,
                            community_teacher_id: community_teacher_id,

                            //奖助学金
                            first_year: first_year,
                            first_scholarship: first_scholarship,
                            first_stipend: first_stipend,
                            second_year: second_year,
                            second_scholarship: second_scholarship,
                            second_stipend: second_stipend,
                            third_scholarship: third_scholarship,
                            third_year: third_year,
                            third_stipend: third_stipend,

                            //荣誉与获奖
                            updateStudent_Award_or_punishment_date_list: updateStudent_Award_or_punishment_date_list,
                            updateStudent_Award_or_punishment_content_list: updateStudent_Award_or_punishment_content_list,
                            updateStudent_Award_or_punishment_id_list: updateStudent_Award_or_punishment_id_list,

                            //违纪与处分
                            updateStudent_disciplineAndPunishment_date_list: updateStudent_disciplineAndPunishment_date_list,
                            updateStudent_disciplineAndPunishment_content_list: updateStudent_disciplineAndPunishment_content_list,
                            updateStudent_disciplineAndPunishment_id_list: updateStudent_disciplineAndPunishment_id_list,
                            //党派或团体组织
                            partyOrGroupOrganization: partyOrGroupOrganization,
                            partyOrGroupOrganizationText: partyOrGroupOrganizationText,
                            //入学前受过何奖励或处分
                            Pre_admissionOrReward: Pre_admissionOrReward,
                            Pre_admissionOrRewardText: Pre_admissionOrRewardText,

                            //团学活动
                            updateStudent_groupActivities_date_list: updateStudent_groupActivities_date_list,
                            updateStudent_groupActivities_content_list: updateStudent_groupActivities_content_list,
                            updateStudent_groupActivities_id_list: updateStudent_groupActivities_id_list,
                            //医保
                            first_time_medical_insurance: first_time_medical_insurance,
                            second_time_medical_insurance: second_time_medical_insurance,
                            third_time_medical_insurance: third_time_medical_insurance,
                            first_medical_insurance: first_medical_insurance,
                            second_medical_insurance: second_medical_insurance,
                            third_medical_insurance: third_medical_insurance
                        },

                        function (data) {
                            if (data.result) {
                                layer.msg(data.msg);
                                $("#showUpdateDorms").hide();
                                $("#updateDetailedAddress").hide();
                                $("#showUpdate_name_of_the_source").hide();
                                $("#update_Pre_enrollment_file_unit").hide();
                                $("#show_Pre_school_account_where_the_police_station_detailed").hide();
                                $("#updateCardAddress").hide();
                                $("#updateNativeAddress").hide();
                                $("#showUpdateOffCampusAddress").hide();
                                $("#show_pre_school_work").hide();
                            }
                        }
                    )
                })
            },

            updateSameToIdcard_address: function () {
                $("#detailedAddresses").val($("#Identity_card_address").val());
            },


            showUpdateDorms: function () {
                $("#showUpdateDorms").show();
                $("#province12").val("");
                $("#city12").val("");
                $("#district12").val("");

            },
            showUpdateOffCampusAddress: function () {
                $("#showUpdateOffCampusAddress").show();
            },

            updateDetailedAddress: function () {
                $("#updateDetailedAddress").show()
            },
            showUpdate_name_of_the_source: function () {
                $("#showUpdate_name_of_the_source").show();
            },
            update_Pre_enrollment_file_unit: function () {
                $("#update_Pre_enrollment_file_unit").show();
            },
            school_account_where_the_police_station_detailed: function () {
                $("#show_Pre_school_account_where_the_police_station_detailed").show();
            },

            updateCardAddress: function () {
                $("#updateCardAddress").show();
            },

            updateNativeAddress: function () {
                $("#updateNativeAddress").show();
            },

            show_pre_school_work: function () {
                $("#show_pre_school_work").show();
            }
        };

        function loadALlDepartments() {
            $.post(baseUrl + "/department/allDepartments", function (data) {
                if (data.result) {
                    $("#department_search").html(`<option value="" selected>系</option>`).append(loadOptionsHtml(data.data, "-"));
                }
            });
        }

        function loadAllLevels() {
            $("#level_search").html(`<option value="" selected>年级</option><option value="">请选择</option>`);
            let levels = getSearchLevels().reverse();
            levels.forEach(level => {
                $("#level_search").append(`<option value="` + level + `" >` + level + `</option>`);
            });
        }

        function Closepage() {
            if (window.opener && !window.opener.closed) {
                window.parent.opener.location.reload();
            }
            window.close();
            return false;
        }

        function loadAllDirections() {
            $.post(baseUrl + "/communication/queryDirectionByDepartment", function (data) {
                if (data.result) {
                    $("#direction_search").html(`<option value="">方向</option>`).append(loadOptionsHtml(data.data, "-"))
                }
            })
        }

        function showDateDisciplineAndPunishmentBehavior(num) {
            if (num == 1) {
                $("#dateDisciplineAndPunishmentBehavior").html(`
                       <option value=""></option>
                       <option value="">请选择</option>
                       <option value="1">考试违规</option>
                       <option value="2">妨碍公共管理</option>
                       <option value="3">侵犯他人权利</option>
                       <option value="4">危害公共安全</option>
                       <option value="5">扰乱公共秩序</option>
                       <option value="6">违法犯罪</option>
                       <option value="7">其他</option>
                    `);
                $("#dateDisciplineAndPunishmentRank").html(`
                       <option value=""></option>
                       <option value="">请选择</option>
                       <option value="1">警告</option>
                       <option value="2">严重警告</option>
                       <option value="3">记过</option>
                       <option value="4">留校查看</option>
                       <option value="5">开出学籍</option>
                    `);
                form.render();
            }
            if (num == 2) {
                $("#dateDisciplineAndPunishmentBehavior").html(`
                    <option value=""></option>
                    <option value="">请选择</option>
                       <option value="1">身体疾病</option>
                       <option value="2">情绪失控</option>
                       <option value="3">行为失常</option>
                       <option value="4">家庭突变</option>
                       <option value="5">性格偏执</option>
                       <option value="6">校园贷款</option>
                       <option value="7">经济纠纷</option>
                       <option value="8">其他</option>
                    `);
                $("#dateDisciplineAndPunishmentRank").html(`
                       <option value=""></option>
                       <option value="">请选择</option>
                       <option value="1">一般预警</option>
                       <option value="2">特殊预警</option>
                    `);
                form.render();
            }
        }


        function loadAllProfession() {
            $.post(baseUrl + "/student/queryProfessionByDepartment", function (data) {
                $("#profession_search").html(`<option value="">专业</option>`).append(loadOptionsHtml(data.allProfessionList, "-"));
            })

        }

        function loadAllClassess() {
            $.post(baseUrl + "/communication/queryClass", function (data) {
                if (data.result) {
                    $("#classes_search").html(`<option value="">班级</option>`).append(loadOptionsHtml(data.data, "-"));
                }
            });
        }

        function loadTeacher() {
            $.post(baseUrl + "/student/showTeacherOfSearch", function (data) {
                //职业导师
                let teacher_id1 = data.teacherList.filter(item => item.classify === "职业导师");
                $("#teacher_id").html("").append(`<option value="">职业导师</option>` + loadOptionsHtmlToTeacher(teacher_id1, "-"));
                //社区辅导员
                let community_teacher_id1 = data.teacherList.filter(item => item.classify === "社区辅导员");
                $("#community_teacher_id").html("").append(`<option value="">社区辅导员</option>` + loadOptionsHtmlToTeacher(community_teacher_id1, "-"));
            })

        }

        function loadOptionsHtml(data, selectId) {
            let _html = "<option value=''>请选择</option>";
            for (let i = 0; i < data.length; ++i) {
                if (selectId == data[i].id) {
                    _html += `<option  selected value="` + data[i].id + `">` + data[i].name + `</option>`;
                } else {
                    _html += `<option value="` + data[i].id + `">` + data[i].name + `</option>`;
                }
            }

            return _html;
        }

        function loadOptionsHtmlOfFamousFamilyList(data, selectId) {
            let _html = "<option value=''>请选择</option><option value=''>请选择</option>";
            for (let i = 0; i < data.length; ++i) {
                if (selectId == data[i].para_no) {
                    _html += `<option  selected value="` + data[i].para_no + `">` + data[i].para_dispname + `</option>`;
                } else {
                    _html += `<option value="` + data[i].para_no + `">` + data[i].para_dispname + `</option>`;
                }
            }

            return _html;
        }

        function loadOptionsHtmlOfClass(data) {
            let _html = "<option value=''></option><option value=''>请选择</option>";
            for (let i = 0; i < data.length; ++i) {
                _html += `<option value="` + data[i].id + `">` + data[i].name + `</option>`;
            }

            return _html;
        }

        function loadOptionsHtmlToTeacher(data, selectId) {
            let _html = "<option value=''>请选择</option>";
            for (let i = 0; i < data.length; ++i) {
                if (selectId == data[i].no) {
                    _html += `<option  selected value="` + data[i].no + `">` + data[i].name + `</option>`;
                } else {
                    _html += `<option value="` + data[i].no + `">` + data[i].name + `</option>`;
                }
            }

            return _html;
        }

        function loadOptionsHtmlToYear(year, selectId) {
            let years = parseInt(year);
            let _html = "<option value=''>请选择</option>";
            for (let i = 0; i < 5; ++i) {
                if (selectId == years) {
                    _html += `<option  selected value="` + years + `">` + years + `</option>`;
                } else {
                    _html += `<option value="` + years + `">` + years + `</option>`;
                }
                years++;
            }

            return _html;
        }

        function loadOptionsHtmlTomedicalInsurance(year, selectId) {
            let years = parseInt(year);
            let _html = "<option value=''>请选择</option>";
            for (let i = 0; i < 5; ++i) {
                if (selectId == years) {
                    _html += `<option  selected value="` + years + `">` + years + `</option>`;
                } else {
                    _html += `<option value="` + years + `">` + years + `</option>`;
                }
                years++;
            }

            return _html;
        }

        function queryAreaAndFloor() {
            $.post(baseUrl + "dorm/room/showAreaAndFloorsToQuery", function (data) {
                if (data.result) {
                    $("#area_search").html(`<option value=''>区</option>` + student.loadDepartmentOrDirectionArea(data.data.queryAreaOfRoom, "-"))
//                    $("#floor_search").html(student.loadDepartmentOrDirectionFloor(data.data.queryFloorOfRoom, "-"))
                }
                form.render();
            })
        }

        function queryClassByDirectionIdAndLevel(directionId, level) {
            $.post(baseUrl + "/studentClass/queryClassByDirectionIdAndLevel",
                {
                    directionId: directionId,
                    level: level
                },
                function (data) {
                    console.log(data)
                    if (data.result) {
                        $("#student_class").html("<option value=''>请选择</option>" + loadOptionsHtml(data.data, "-"));
                    }
                    form.render();
                })
        }

        //实时监听qq输入动态生成qq邮箱
        function monitorQQOfEmail() {
            $("#studentQQ").bind('input propertychange', function () {
                $("#studentEmail").val($(this).val() + "@qq.com");
            })
        }

        //监听违纪处分中的类别
        /* function monitorDiscipByCategory() {
             form.on('select(show_dateDisciplineAndPunishmentCategory)', function (data) {
                 showDateDisciplineAndPunishmentBehaviorByUpdate(data.value);
             });
         }*/

        $(function () {
//            student.list();
            student.showDormAndHideDorm();
            loadALlDepartments();
            loadAllDirections();
            loadAllLevels();
            loadAllProfession();
            loadAllClassess();
            loadTeacher();
            monitorQQOfEmail();
            student.queryAreaAndFloorOfUpdate()
            queryAreaAndFloor();
            form.render();

            $("#studentPhone").formatInput({
                formatArr: [3, 4, 4],
                delimiter: '-'
            });
            $("#updateStudentHome_phone").formatInput({
                formatArr: [3, 4, 4],
                delimiter: '-'
            });
            $("#updateStudent_emergency_contact_phone").formatInput({
                formatArr: [3, 4, 4],
                delimiter: '-'
            });
            $("#units_or_projects_practical_type_contact_phone").formatInput({
                formatArr: [3, 4, 4],
                delimiter: '-'
            });
            $("#updateOffCampusContactPhone").formatInput({
                formatArr: [3, 4, 4],
                delimiter: '-'
            });

            //搜索条件中显示全部的专业信息
//            $("#profession_search").html(`<option value="">专业</option>` + loadOptionsHtmlOfClass(allProfessionInfo));

            form.on('select(department)', function (data) {
                let department_id = data.value;
//                根据系动态选择专业
                $.post(baseUrl + "/student/showAutoClassAndProAndDirByDepartment", {departmentId: department_id}, function (resultData) {
                    $("#profession_search").html(`<option value="">专业</option>` + loadOptionsHtmlOfClass(resultData.data.professionList));
//                    $("#profession_search").html(`<option value="">专业</option>` + loadOptionsHtmlOfClass(resultData.data.professionList));
                    form.render();
                })

                $("#department_search").html(student.loadClassByDepartmentId(data.value));
                $("#direction_search").html(student.loadDirectionsByDepartmentId(data.value));
            });

            form.on('select(dorm)', function (data) {
                var id = data.value;

                $.post(baseUrl + "dorm/room/showAreaAndFloors", {areaId: data.value}, function (data) {
                    if (data.result) {
                        var queryAreaOfRoom = data.data.queryAreaOfRoom
                        var queryFloorOfRoom = data.data.queryFloorOfRoom

                        $("#area_search").html(`<option value="">区</option>` + student.loadDepartmentOrDirectionArea(queryAreaOfRoom, id))
                        $("#floor_search").html(`<option value="">楼层</option>` + student.loadDepartmentOrDirectionFloor(queryFloorOfRoom), "-")
                        form.render();
                    }
                })
            })

            //监听指定开关
            form.on('switch(switchTest)', function (data) {
                layer.msg('开关checked：' + (this.checked ? 'true' : 'false'), {
                    offset: '6px'
                });
                layer.tips('温馨提示：请注意开关状态的文字可以随意定义，而不仅仅是ON|OFF', data.othis)
            });

            //监听提交
            form.on('submit(demo1)', function (data) {
                layer.alert(JSON.stringify(data.field), {
                    title: '最终的提交信息'
                })
                return false;
            });


            //监听select选择
            form.on('select(pre_school_education)', function (data) {
                if (data.value === '5') {

                    $("#pre_school_education").show();
                } else {
                    $("#pre_school_education").hide();
                }
            })

            //监听缴费状态
            form.on('select(update_payment_status)', function (data) {
                if (data.value == 5) {
                    $("#showAmount_of_arrears").show();
                } else {
                    $("#showAmount_of_arrears").hide();
                }
            })
            form.on('select(update_payment_status2)', function (data) {
                if (data.value == 5) {
                    $("#showAmount_of_arrears2").show();
                } else {
                    $("#showAmount_of_arrears2").hide();
                }
            })
            form.on('select(update_payment_status3)', function (data) {
                if (data.value == 5) {
                    $("#showAmount_of_arrears3").show();
                } else {
                    $("#showAmount_of_arrears3").hide();
                }
            })
            form.on('select(update_payment_status4)', function (data) {
                if (data.value == 5) {
                    $("#showAmount_of_arrears4").show();
                } else {
                    $("#showAmount_of_arrears4").hide();
                }
            })
            form.on('select(update_payment_status5)', function (data) {
                if (data.value == 5) {
                    $("#showAmount_of_arrears5").show();
                } else {
                    $("#showAmount_of_arrears5").hide();
                }
            })
            form.on('select(update_payment_status6)', function (data) {
                if (data.value == 5) {
                    $("#showAmount_of_arrears6").show();
                } else {
                    $("#showAmount_of_arrears6").hide();
                }
            })
            //监听实践类型
            form.on('select(update_practical_type)', function (data) {
                if (data.value == 5) {
                    $("#show_other_practical_type").show();
                } else {
                    $("#show_other_practical_type").hide();
                }
                if (data.value !== '') {
                    $("#show_units_or_projects_practical_type").show();
                    $("#show_units_or_projects_practical_type_contact").show();
                    $("#show_units_or_projects_practical_type_contact_phone").show();
                } else {
                    $("#show_units_or_projects_practical_type").hide();
                    $("#show_units_or_projects_practical_type_contact").hide();
                    $("#show_units_or_projects_practical_type_contact_phone").hide();
                }
            });

            //监听根据区id显示楼层
            form.on('select(modules_3)', function (data) {
                var id = data.value;
                showDormInfo();

                $.post(baseUrl + "dorm/room/showAreaAndFloors", {areaId: data.value}, function (data) {
                    if (data.result) {
                        var queryAreaOfRoom = data.data.queryAreaOfRoom
                        var queryFloorOfRoom = data.data.queryFloorOfRoom

                        $("#queryAreas").html(`` + student.loadDepartmentOrDirection(queryAreaOfRoom, id))
                        $("#queryFloors").html(student.loadDepartmentOrDirection(queryFloorOfRoom, "-"))
                        form.render();
                    }
                })
            })

            //监听根据楼层id显示宿舍
            form.on('select(modules_2)', function (data) {
                var id = data.value;
                showDormInfo();
                $.post(baseUrl + "dorm/room/showFloorsAndRooms", {floorId: data.value}, function (data) {
                    if (data.result) {
                        var queryRoomList = data.data.queryRoomList
                        $("#queryRooms").html(student.loadDepartmentOrDirection(queryRoomList, "-"))
                        form.render();
                    }
                })
            })
            form.on('select(modules_1)', function (data) {
                showDormInfo();

            })

            //监听宗教信仰
            form.on('radio(religiousBelief)', function (data) {

                if (data.value === "有") {
                    $("#showReligiousBeliefText").show();
                } else {
                    $("#religiousBeliefText").val("");
                    $("#showReligiousBeliefText").hide();
                }
            });
            //监听学生政治面貌
            form.on('select(politicalOutlook)', function (data) {
                if (data.value === '6') {
                    $("#otherParty").show();
                } else {
                    $("#otherParty").hide();
                }
            });
            //监听学生家人政治面貌
            form.on('select(politicalOutlookParent)', function (data) {
                let political = $(data.elem).parents(".political").find(".otherParty1");
                if (data.value === '6') {
                    $(political).show();
                } else {
                    $(political).hide();
                }

                form.render();
            });
            //监听学生家人政治面貌在进行添加时
            form.on('select(family_political_status)', function (data) {
                if (data.value === '6') {
                    $("#show_other_family_political_status").show();
                } else {
                    $("#show_other_family_political_status").hide();
                }
            });
            //监听系,从而动态获取相应的班级、现专业、就业方向
            form.on('select(student_departments)', function (data) {
                let department_id = data.value;
                $.post(baseUrl + "/student/showAutoClassAndProAndDirByDepartment", {
                    departmentId: department_id,
                    searchLevel: searchLevel
                }, function (resultData) {
                    $("#student_class").html(loadOptionsHtmlOfClass(resultData.data.classesList));
                    $("#studentsNowProfessional").html(loadOptionsHtmlOfClass(resultData.data.professionList));
                    $("#employment_direction").html(loadOptionsHtmlOfClass(resultData.data.directionList));
                    form.render();
                })
            });

            form.on('select(employment_direction)', function (data) {
                let directionId = data.value;
                queryClassByDirectionIdAndLevel(directionId, searchLevel);
            });

            //根据方向动态选择班级
            form.on('select(modules_direction)', function (data) {
                $.post(baseUrl + "student/directionSelectionClass", {directionId: data.value}, function (dataResult) {
                    $("#classes_search").html(`<option value="">班级</option>` + loadOptionsHtml(dataResult.classList));
                    form.render();
                })
            });


            //监听年级动态获得相应班级
            form.on('select(modules_level)', function (data) {
                $.post(baseUrl + "student/levelSelectionClass", {levelName: data.value}, function (dataResult) {
                    $("#classes_search").html(`<option value="">班级</option>` + loadOptionsHtml(dataResult.classList));
                    form.render();
                })
            });
            //违纪处分：根据类别确定行为
            form.on('select(dateDisciplineAndPunishmentCategory)', function (data) {
                showDateDisciplineAndPunishmentBehavior(data.value);
            });


            //图片上传
            layui.use('upload', function () {
                layui.upload({
                    url: '${baseurl}/student/updateImage' //上传接口
                    , success: function (res) { //上传成功后的回调
                        if (res.result) {
                            $("#imagesToUpdate").text("").attr("src", HEAD_IMAGE_PREFIX + res.data);
                            imgName = res.data;
                        }
                    }
                });
            });
        });
    });

</script>

<script>
    layui.use(['form', 'layedit', 'laydate'], function () {
        var form = layui.form()
            , layer = layui.layer
            , layedit = layui.layedit
            , laydate = layui.laydate;

        //创建一个编辑器
        var editIndex = layedit.build('LAY_demo_editor');

        //自定义验证规则
        form.verify({
            title: function (value) {
                if (value.length < 5) {
                    return '标题至少得5个字符啊';
                }
            }
            , pass: [/(.+){6,12}$/, '密码必须6到12位']
            , content: function (value) {
                layedit.sync(editIndex);
            }
        });

    });
</script>

</html>
