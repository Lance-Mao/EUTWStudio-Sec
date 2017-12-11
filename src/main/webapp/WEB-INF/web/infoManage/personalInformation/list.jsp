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

</head>
<style>
    .layui-table th {
        font-size: 11px;
        padding: 8px 5px;
        line-height: 31px;
        min-height: 30px;
    }

</style>
<body style=" background: #fff;">
<section class=" layui-form">
    <div class="larry-personal">
        <div class="layui-tab">
            <div id="update" style=" height: 100%;">
                <div class="container" id="container" style=" background: #fff;width: 800px; ">
                    <h1 style="text-align: center;margin-left: -30px;margin-top: 40px; ;color:#00ab9f ">西安欧亚学院<span id="studentName1"></span>学生档案</h1>

                    <div style="margin-top: 40px;">
                        <div style="width: 100%; height: 100%; float: left;padding-left: 25px">
                            <h4 style="color: #00ab9f;font-weight: bold">基本信息</h4>
                            <table class="layui-table lay-even " data-name="articleCatData"
                                   style="border: 0px solid red">
                                <tbody>
                                <tr>
                                    <th colspan="3" style="width: 230px;">学号：<span id="studentNo"></span></th>
                                    <th colspan="4" style="width:125px;">姓名：<span id="studentName"></span></th>
                                    <th colspan="1" >性别：<span id="studentSex"></span></th>
                                    <th colspan="3" style="width: 120px;">民族：<span id="famous_family"></span></th>
                                    <th>婚否：<span id="is_marry"></span></th>
                                    <th rowspan=" 3 " style="padding: 1px;">
                                        <div style="width:100px; height: 140px; border: 0px solid #00ab9f">
                                            <img id="images" class="head_image" style="width:100%;" height="100%"/>
                                        </div>
                                    </th>
                                </tr>
                                <tr>
                                    <th colspan="6" style="width:220px">身份证号：<span id="idcard"></span></th>
                                    <th colspan="4" style="width:162px;">出生日期：<span id="born"></span></th>
                                    <%--<th colspan="5" style="width:190px;">政治面貌：<span id="political_status"></span></th>--%>
                                    <th colspan="2" style="width:230px;">入学前文化程度：<span id="preSchoolEducation"></span></th>
                                </tr>
                                <tr>
                                    <th colspan="6">联系方式：<span id="phone"></span></th>
                                    <th colspan="4">邮箱：<span id="email"></span></th>
                                    <th colspan="2">QQ：<span id="qq"></span></th>
                                </tr>
                                <tr>
                                    <th colspan="8">籍贯：<span id="native_place"></span></th>
                                    <th colspan="5">入学前学校名称或工作单位：<span id="preSchoolName"></span></th>
                                </tr>
                                <tr>
                                    <th colspan="8">入学前党派或团体组织：<span id="party_OrGroupOrganization"></span></th>
                                    <th colspan="5">入学前受过何奖励或处分：<span id="PreAdmissionOrReward"></span></th>
                                </tr>
                                <tr>
                                    <th colspan="6">档案是否转入：<span id="file_in"></span></th>
                                    <th colspan="7">入学前档案所在单位：<span id="pre_school_file_where_location"></span></th>
                                </tr>
                                <tr>
                                    <th colspan="6">户口是否转入：<span id="account_in"></span></th>
                                    <th colspan="7">入学前户口所在派出所：<span id="pre_school_account_where_station"></span></th>
                                </tr>
                                <tr>
                                    <th colspan="6">邮编编码：<span id="family_zip_code"></span></th>
                                    <th colspan="7">身份证住址：<span id="idcard_address"></span></th>
                                </tr>
                                <tr>
                                    <th colspan="6">生源类别 ：<span id="studentClassify"></span></th>
                                    <th colspan="7">家庭实际住址：<span id="actual_address"></span></th>
                                </tr>
                                <tr>
                                    <th colspan="6">城乡生源名称：<span id="area_origin_name"></span></th>
                                    <th colspan="7">生源所在地名称：<span id="origin_address"></span></th>
                                </tr>

                                <tr>
                                    <th colspan="6">紧急联系人：<span id="emergency_contact_name"></span></th>
                                    <th colspan="7">联系方式：<span id="emergency_contact_method"></span></th>
                                </tr>
                                </tbody>
                            </table>
                            <h4 style="color: #00ab9f;font-weight: bold ;padding-top: 15px;">家庭成员</h4>
                            <table class="layui-table lay-even " data-name="articleCatData"
                                   style="border: 0px solid red">
                                <tbody id="family">
                                </tbody>
                            </table>

                            <h4 style="color: #00ab9f;font-weight: bold ;padding-top: 15px;">教育经历</h4>
                            <table class="layui-table lay-even " data-name="articleCatData"
                                   style="border: 0px solid red">
                                <tbody id="experience_div">

                                </tbody>
                            </table>
                            <h4 style="color: #00ab9f;font-weight: bold ;padding-top: 15px;">学业状态</h4>
                            <table class="layui-table lay-even " data-name="articleCatData"
                                   style="border: 0px solid red">
                                <tbody>
                                <tr>
                                    <th width="25%">学籍状态：<span id="student_status"></span></th>
                                    <th width="25%">职业导师：<span id="teacherName"></span></th>
                                    <th width="25%">学生类别：<span id="student_type"></span></th>
                                    <th width="25%">高考成绩：<span id="sat_score"></span></th>
                                </tr>
                                <tr>
                                    <th>录取专业：<span id="profession"></span></th>
                                    <th>系：<span id="department"></span></th>
                                    <th>现专业：<span id="originProfession"></span></th>
                                    <th>就业方向：<span id="direction"></span></th>
                                </tr>
                                <tr>
                                    <th >班级：<span id="classes"></span></th>
                                    <th >组别：<span id="group"></span></th>
                                    <th colspan="2">实践类型：<span id="practice_learning_type"></span></th>

                                </tr>
                                <tr>
                                    <th colspan="2">实践单位或项目：<span id="units_or_projects_practical_type_preview"></span></th>
                                    <th >联系人：<span id="units_or_projects_practical_type_contact_preview"></span></th>
                                    <th >联系人电话：<span id="units_or_projects_practical_type_contact_phone_preview"></span></th>
                                </tr>
                                <tr>
                                    <th colspan="4">缴费状态：
                                        第一年：(<span id="payment_status_first_year"></span><span id="arrears_first_year" style="display: none">：21441元</span>)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        第二年：(<span id="payment_status_second_year"></span><span id="arrears_second_year" style="display: none"></span>)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        第三年：(<span id="payment_status_third_year"></span><span id="arrears_third_year" style="display: none"></span>)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        第四年：(<span id="payment_status_forth_year"></span><span id="arrears_forth_year" style="display: none"></span>)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        第五年：(<span id="payment_status_fifth_year"></span><span id="arrears_fifth_year" style="display: none"></span>)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                        第六年：(<span id="payment_status_sixth_year"></span><span id="arrears_sixth_year" style="display: none"></span>)&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                    </th>
                                </tr>
                                </tbody>
                            </table>

                            <h4 style="color: #00ab9f;font-weight: bold ;padding-top: 15px;">社区管理</h4>
                            <table class="layui-table lay-even " data-name="articleCatData"
                                   style="border: 0px solid red">
                                <tbody>

                                <tr>
                                    <th >住宿类型：<span id="stay_type"></span></th>
                                    <th colspan="3" id ="DormitoryInformation">
                                    </th>
                                </tr>
                                <tr>
                                    <th>社区辅导员：<span id="teacherCommunity"></span></th>
                                    <th >华侨、港澳台：<span id="is_out"></span></th>
                                    <th >政治面貌：<span id="political_status"></span></th>
                                    <th  >宗教信仰：<span id="religion"></span></th>
                                </tr>
                                <tr>
                                    <th width="25%">血型：<span id="blood"></span></th>
                                    <th width="25%">身高：<span id="height"></span>cm</th>
                                    <th width="25%" >体重：<span id="weight"></span>kg</th>
                                    <th width="25%">健康状况：<span id="health_status"></span></th>
                                </tr>
                                <tr>
                                    <th >第一年医保：<span id="first_time_medical_insurance_preview"></span><span id="first_medical_insurance_preview"></span></th>
                                    <th >第二年医保：<span id="second_time_medical_insurance_preview"></span><span id="second_medical_insurance_preview"></span></th>
                                    <th  colspan="2">第三年医保：<span id="third_time_medical_insurance_preview"></span><span id="third_medical_insurance_preview"></span></th>
                                </tr>
                                </tbody>
                            </table>
                            <h4 style="color: #00ab9f;font-weight: bold ;padding-top: 15px;">奖学金或助学金</h4>
                            <table class="layui-table lay-even " data-name="articleCatData"
                                   style="border: 0px solid red">
                                <tbody id="scholarship">

                                </tbody>
                            </table>
                            <h4 style="color: #00ab9f;font-weight: bold ;padding-top: 15px;">获奖或荣誉</h4>
                            <table class="layui-table lay-even " data-name="articleCatData"
                                   style="border: 0px solid red">
                                <tbody id="own_punishment">

                                </tbody>
                            </table>

                            <h4 style="color: #00ab9f;font-weight: bold ;padding-top: 15px;">违纪或处分</h4>
                            <table class="layui-table lay-even " data-name="articleCatData"
                                   style="border: 0px solid red">
                                <tbody id="t_discipline_and_punishment">

                                </tbody>
                            </table>
                            <h4 style="color: #00ab9f;font-weight: bold ;padding-top: 15px;">团学活动</h4>
                            <table class="layui-table lay-even " data-name="articleCatData"
                                   style="border: 0px solid red">
                                <tbody id="t_group_activities">

                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

</body>

<script src="${baseurl}/js/searchJs.js"/>
<script type="text/javascript" src="${baseurl}/public/js/pdf/html2canvas.js"></script>
<script type="text/javascript">
    layui.use(['jquery', 'layer', 'element', 'laypage', 'form', 'laytpl', 'tree'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;
        var element = layui.element(),
            form = layui.form(),
            laytpl = layui.laytpl;

        student = {
            preview: function (studentNo) {
                $.post(baseUrl + "/personalInformation/update", {studentNo: "<shiro:principal property="userName"/>"}, function (data) {
                    $("#phone").text("").append(data.student[0].student_contact_method);
                    $("#qq").text("").append(data.student[0].qq);
                    $("#email").text("").append(data.student[0].email);
                    $("#images").text("").attr("src", HEAD_IMAGE_PREFIX + data.student[0].head_image);
                    $("#studentNo").text("").append(data.student[0].no);
                    $("#studentName").text("").append(data.student[0].name);
                    $("#studentName1").text("").append(data.student[0].name);
                    if (data.student[0].gender == 'F') {
                        $("#studentSex").text("").append("女");
                    } else if (data.student[0].gender == 'M') {
                        $("#studentSex").text("").append("男");
                    }
                    $("#famous_family").text("").append(data.student[0].famousFamily);
                    $("#idcard").text("").append(data.student[0].idcard);
                    $("#native_place").text("").append(data.student[0].native_place);
                    $("#born").html(getBirthday(data.student[0].idcard));
                    $("#political_status").text("").append(data.student[0].political_status);
                    $("#blood").text("").append(data.student[0].blood);
                    $("#height").text("").append(data.student[0].height);
                    $("#weight").text("").append(data.student[0].weight);
                    $("#health_status").text("").append(data.student[0].health_status);
                    $("#is_marry").text("").append(data.student[0].is_marry);
                    $("#family_zip_code").text("").append(data.student[0].family_zip_code);
                    $("#student_contact_method").text("").append(data.student[0].student_contact_method);
                    $("#actual_address").text("").append(data.student[0].actual_address);
                    $("#family").html("")
                    for (var i = 0; i < data.family.length; i++) {
                        $("#family").append("<tr> <th colspan='5' >" + data.family[i].relationship + "：" + data.family[i].name + "</th>" +
                            "<th colspan='4' style='width: 70px'>职务：" + data.family[i].staff + "</th>" +
                            "<th colspan='4'>联系电话：" + data.family[i].phone + "</th></tr>" +
                            "<tr><th colspan='5' style='width: 130px'>政治面貌：" + data.family[i].political_status + "</th>" +
                            "<th colspan='8'>工作单位：" + data.family[i].work_place + "</th> </tr>");
                    }
                    $("#emergency_contact_name").text("").append(data.student[0].emergency_contact_name);
                    $("#emergency_contact_method").text("").append(data.student[0].emergency_contact_method);
                    $("#experience_div").html("")
                    for (var i = 0; i < data.experience.length; i++) {
                        $("#experience_div").append("<tr class='experience_divToEveryOne'> <th>时间：" + data.experience[i].start_time + "——" + data.experience[i].end_time + "</th>" +
                            "<th> 学校名称：" + data.experience[i].work_place + "</th>" +
                            "<th >担任职位：" + data.experience[i].staff + "</th></tr>");
                    }
                    $("#student_type").text("").append(data.student[0].student_type);
                    $("#sat_score").text("").append(data.student[0].sat_score);
                    $("#originProfession").text("").append(data.student[0].originProfession);
                    $("#profession").text("").append(data.student[0].profession);
                    $("#direction").text("").append(data.student[0].direction);
                    $("#classes").text("").append(data.student[0].classes);
                    $("#teacherName").text("").append(data.student[0].teacherName);
                    $("#teacherName").text("").append(data.student[0].teacherName);
                    $("#teacherCommunity").text("").append(data.student[0].teacherCommunity);
                    $("#student_status").text("").append(data.student[0].student_status);
                    $("#practice_learning_type").text("").append(data.student[0].practice_learning_type);
                    $("#payment_status_first_year").text("").append(data.student[0].payment_status_first_year);
                    $("#payment_status_second_year").text("").append(data.student[0].payment_status_second_year);
                    $("#payment_status_third_year").text("").append(data.student[0].payment_status_third_year);
                    $("#area").text("").append(data.student[0].area);
                    $("#floor").text("").append(data.student[0].floor);
                    $("#room").text("").append(data.student[0].room);
                    $("#hard_type").text("").append(data.student[0].hard_type);
                    $("#own_punishment").text("")
                    for (var i = 0; i < data.ownPunishment.length; i++) {
                        $("#own_punishment").append("<tr><th>" + data.ownPunishment[i].date + " —— " + data.ownPunishment[i].centent + "</th></tr>");
                    }
                })
            }
        }
        $(function () {
            student.preview();
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
