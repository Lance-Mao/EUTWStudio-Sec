<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../../public/tag.jsp" %>
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
<style>
    .layui-table td, .layui-table th{
        font-size: 12px;
    }
</style>
</head>
<body>

<section class=" layui-form">
    <div class="larry-personal">
        <div class="layui-tab">
            <shiro:hasPermission name="studentInfoReport:exportExcel">
                <button class="layui-btn " style="float: right" onclick="studentInfo.exportExcel()"><i
                        class="layui-icon">&#xe61e;</i>导出
                    EXCEl
                </button>
            </shiro:hasPermission>
            <div id="container" class="layui-tab-content larry-personal-body clearfix mylog-info-box"
                 style="background: #fff;width: 100%;height: 100%;margin: 5px 0px">
                <div style="text-align: center;font-size: 20px;font-weight: bold;color: #21a1a1">
                    西安欧亚学院高职学院学籍管理班级人数统计报表
                    <%--(<span style="font-size: 13px;" id="time">2017-6-3 12:12:21</span>)--%>
                </div>
                <table class="layui-table" >
                    <colgroup>
                        <col width="180">
                        <col width="70">
                        <col width="160">
                        <col width="160">
                        <col width="100">
                        <col width="70">
                        <col width="70">
                        <col width="70">
                        <col width="70">
                        <col width="70">
                        <col width="70">
                        <col width="70">
                        <col width="70">
                        <col width="70">
                        <col width="70">
                        <col width="70">
                        <col width="70">
                        <col width="70">
                        <col width="70">
                    </colgroup>
                    <thead>
                    <tr id="head">
                        <td>系别名称</td>
                        <td>年级</td>
                        <td>就业方向</td>
                        <td>班级名称</td>
                        <td>职业导师</td>
                        <td>班级人数</td>
                        <td>休学</td>
                        <td>退学</td>
                        <td>留级</td>
                        <td>流失</td>
                        <td>复学</td>
                        <td>入伍</td>
                        <td>欠费</td>
                        <td>合作企业</td>
                        <td>自主实习</td>
                        <td>创新创业</td>
                        <td>专升本</td>
                        <td>其它</td>
                        <td>在读</td>
                    </tr>
                    </thead>
                    <tbody id="report" >

                    </tbody>
                </table>
            </div>
        </div>
    </div>
</section>
</body>
<script type="text/javascript" src="${baseurl}/public/common/layui/layui.js"></script>
<script type="text/javascript" src="${baseurl}/js/searchJs.js"></script>
<script type="text/javascript">
    let studentInfo;
    layui.use(['jquery', 'layer'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;


        studentInfo = {
            list: function () {
                $.post(baseUrl + "/studentInfoReport/list", function (data) {
                    if (data.result) {
                        let date = new Date();
                        $("#time").text(date.getFullYear() + " 年 " + (date.getMonth() + 1) + " 月 " + date.getDate() + " 日");
                        studentInfo.showPages(data.data);
//                        studentInfo.showPage(data.data);
                    } else {
                        layer.msg(data.msg);
                    }
                })
            },
            exportExcel: function () {
                location.href = baseUrl + "/studentInfoReport/exportExcel";
            },
            showPage: function (departments) {
                let _html = "";
                for (let i = 0; i < departments.length; ++i) {
                    department = departments[i];
                    let levels = department["levels"];
                    if (levels === undefined || levels.length === 0) continue;
                    let directions = levels[0]["directions"];
                    if (directions === undefined || directions.length === 0) continue;
                    let classess = directions[0]["classess"];
                    let reportCount = (classess[0])["reportCount"]["statisticCount"];
                    if (classess === undefined || classess.length === 0) continue;

                    _html += `<tr>`;
                    _html += `<th rowspan="` + studentInfo.getDepartmentRows(department) + `">` + department["departmentName"] + `</th>`;
                    _html += `<th rowspan="` + studentInfo.getLevelRows(levels[0]) + `">` + levels[0]["level"] + `</th>`;
                    _html += `<th rowspan="` + studentInfo.getDirectionRows(directions[0]) + `">` + directions[0]["directionName"] + `</th>
                    _html +=  <th>` + classess[0]["classesName"] + `</th>`;
                    _html += studentInfo.getReportCount(reportCount);
                    _html += `</tr>`;
                    _html += studentInfo.loadClassess(classess);

                    _html += studentInfo.loadDirections(directions);

                    _html += studentInfo.loadLevels(levels);

                }
                $("#report").html(_html);
            },
            getDepartmentRows: function (department) {
                let rows = 0;
                let levels = department["levels"];
                levels.forEach(level => {
                    rows += studentInfo.getLevelRows(level);
                });
                return rows;
            },
            getLevelRows: function (level) {
                let rows = 0;
                let directions = level["directions"];
                directions.forEach(direction => {
                    rows += studentInfo.getDirectionRows(direction);
                });
                return rows;
            },
            getDirectionRows: function (direction) {
                return direction["classess"].length;
            },
            loadClassess: function (classess) {
                if (classess.length <= 1) return "";
                let _html = "<tr>";
                for (let classesIndex = 1; classesIndex < classess.length; ++classesIndex) {
                    _html += `<th >` + classess[classesIndex]["classesName"] + `</th>`;
                    _html += studentInfo.getReportCount((classess[classesIndex])["reportCount"]["statisticCount"]);
                }
                return _html + "</tr>";
            }
            ,
            loadDirections: function (directions) {
                if (directions.length <= 1) return "";
                let _html = "";
                for (let directionIndex = 1; directionIndex < directions.length; ++directionIndex) {
                    let classess = directions[directionIndex]["classess"];
                    if (classess === undefined || classess.length === 0) continue;
                    let reportCount = (classess[0])["reportCount"]["statisticCount"];
                    _html += "<tr>";

                    _html += ` <th rowspan = "` + studentInfo.getDirectionRows(directions[directionIndex]) + `" > `
                        + directions[directionIndex]["directionName"] + ` </th>`;
                    _html += ` <th >` + classess[0]["classesName"] + `</th>`;
                    _html += studentInfo.getReportCount(reportCount);
                    _html += `</tr>`;

                    _html += studentInfo.loadClassess(classess);
                }

                return _html;
            },
            loadLevels: function (levels) {
                if (levels.length <= 1) return "";
                let _html = "";

                for (let levelIndex = 1; levelIndex < levels.length; ++levelIndex) {
                    let directions = levels[levelIndex]["directions"];
                    if (directions === undefined || directions.length === 0) continue;
                    let classess = (directions[0])["classess"];
                    let reportCount = (classess[0])["reportCount"]["statisticCount"];
                    _html += `<tr>
                        <th rowspan="` + studentInfo.getLevelRows(levels[levelIndex]) + `">` + levels[levelIndex]["level"] + `</th>
                        <th rowspan="` + studentInfo.getDirectionRows(directions[0]) + `">` + directions[0]["directionName"] + `</th>
                        <th >` + classess[0]["classesName"] + `</th>`
                    _html += studentInfo.getReportCount(reportCount);
                    _html += `</tr>`;

                    _html += studentInfo.loadDirections(directions);
                }

                return _html;
            },
            getReportCount: function (reportCount) {

                return `
                    <td> ` + (reportCount["班级人数"] == 0?'':reportCount["班级人数"]) + ` </td>
                    <td> ` + (reportCount["休学"] == 0?'':reportCount["休学"])+ ` </td>
                    <td> ` + (reportCount["退学"] == 0?'':reportCount["退学"])+ ` </td>
                    <td> ` + (reportCount["留级"] == 0?'':reportCount["留级"])+ ` </td>
                    <td> ` + (reportCount["流失"] == 0?'':reportCount["流失"])+ ` </td>
                    <td> ` + (reportCount["复学"] == 0?'':reportCount["复学"])+ ` </td>
                    <td> ` + (reportCount["入伍"] == 0?'':reportCount["入伍"])+ ` </td>
                    <td> ` + (reportCount["欠费"] == 0?'':reportCount["欠费"])+ ` </td>
                    <td> ` + (reportCount["合作企业"] == 0?'':reportCount["合作企业"])+ ` </td>
                    <td> ` + (reportCount["自主实习"] == 0?'':reportCount["自主实习"])+ ` </td>
                    <td> ` + (reportCount["创新创业"] == 0?'':reportCount["创新创业"])+ ` </td>
                    <td> ` + (reportCount["专升本"] == 0?'':reportCount["专升本"])+ ` </td>
                    <td> ` + (reportCount["其它"] == 0?'':reportCount["其它"])+ ` </td>
                    <td> ` + (reportCount["在读"] == 0?'':reportCount["在读"])+ ` </td>
                    `
            },


            showPages: function (departments) {
                let _htmlPage = '';
                let reportCount;
                let countClasses,countXiuXue,countTuiXue,counLiuJi,countLiuShi,countFuWei,countRuWu,countQianFei,countHeQi,countZiShi,countChuang,countZhuanBen,countQiTa,countZaiDu;
                let countClassesSum = 0,countXiuXueSum = 0,countTuiXueSum = 0,counLiuJiSum = 0,countLiuShiSum = 0,countFuWeiSum = 0,countRuWuSum = 0,countQianFeiSum = 0,countHeQiSum = 0,countZiShiSum = 0,countChuangSum = 0,countZhuanBenSum = 0,countQiTaSum = 0,countZaiDuSum = 0;
                for(let countDepartments = 0;countDepartments<departments.length;countDepartments++){
                    countClasses = 0,countXiuXue=0, countTuiXue = 0, counLiuJi = 0, countLiuShi = 0, countFuWei = 0, countRuWu = 0, countQianFei = 0, countHeQi = 0, countZiShi = 0, countChuang = 0, countZhuanBen = 0, countQiTa = 0,countZaiDu=0;
                    for(let countLevels = 0;countLevels<departments[countDepartments].levels.length;countLevels++){
                        for (let countDirections = 0;countDirections<departments[countDepartments].levels[countLevels].directions.length;countDirections++){

                            for(let countClass = 0;countClass<departments[countDepartments].levels[countLevels].directions[countDirections].classess.length;countClass++){
                                let teacherName = departments[countDepartments].levels[countLevels].directions[countDirections].classess[countClass].teacherName;
                                _htmlPage += `<tr>
                                                 <td>` + departments[countDepartments].departmentName + `</td>
                                                 <td>` + departments[countDepartments].levels[countLevels].level + `</td>
                                                 <td>` + departments[countDepartments].levels[countLevels].directions[countDirections].directionName + `</td>
                                                 <td>` + departments[countDepartments].levels[countLevels].directions[countDirections].classess[countClass].classesName + `</td>
                                                 <td>` + (teacherName == null?'无':teacherName ) + `</td>`;
                                _htmlPage += studentInfo.getReportCount(departments[countDepartments].levels[countLevels].directions[countDirections].classess[countClass]["reportCount"]["statisticCount"]) + `</tr>`
                                reportCount = departments[countDepartments].levels[countLevels].directions[countDirections].classess[countClass]["reportCount"]["statisticCount"];
                                countClasses +=reportCount["班级人数"];
                                countXiuXue +=reportCount["休学"];
                                countTuiXue +=reportCount["退学"];
                                counLiuJi +=reportCount["留级"];
                                countLiuShi +=reportCount["流失"];
                                countFuWei +=reportCount["复学"];
                                countRuWu +=reportCount["入伍"];
                                countQianFei +=reportCount["欠费"];
                                countHeQi +=reportCount["合作企业"];
                                countZiShi +=reportCount["自主实习"];
                                countChuang +=reportCount["创新创业"];
                                countZhuanBen +=reportCount["专升本"];
                                countQiTa +=reportCount["其它"];
                                countZaiDu +=reportCount["在读"];
                            }
                        }
                    }
                    _htmlPage += `<tr style="background-color:  #009688;"><td colspan="5"  align="center" >小计</td><td>`+countClasses+`</td><td>`+countXiuXue+`</td><td>`+countTuiXue+`</td><td>`+counLiuJi+`</td>
                                    <td>`+countLiuShi+`</td><td>`+countFuWei+`</td><td>`+countRuWu+`</td><td>`+countQianFei+`</td><td>`+countHeQi+`</td>
                                    <td>`+countZiShi+`</td><td>`+countChuang+`</td><td>`+countZhuanBen+`</td><td>`+countQiTa+`</td><td>`+countZaiDu+`</td>
                                    </tr>`;
                    countClassesSum  +=countClasses;
                    countXiuXueSum +=countXiuXue;
                    countTuiXueSum +=countTuiXue;
                    counLiuJiSum +=counLiuJi;
                    countLiuShiSum +=countLiuShi;
                    countFuWeiSum +=countFuWei;
                    countRuWuSum +=countRuWu;
                    countQianFeiSum +=countQianFei;
                    countHeQiSum +=countHeQi;
                    countZiShiSum +=countZiShi;
                    countChuangSum +=countChuang;
                    countZhuanBenSum +=countZhuanBen;
                    countQiTaSum +=countQiTa;
                    countZaiDuSum +=countZaiDu;
                }
                _htmlPage += `<tr style="background-color:  #009688;"><td colspan="5"  align="center" >总计</td><td>`+countClassesSum+`</td><td>`+countXiuXueSum+`</td><td>`+countTuiXueSum+`</td><td>`+counLiuJiSum+`</td>
                                    <td>`+countLiuShiSum+`</td><td>`+countFuWeiSum+`</td><td>`+countRuWuSum+`</td><td>`+countQianFeiSum+`</td><td>`+countHeQiSum+`</td>
                                    <td>`+countZiShiSum+`</td><td>`+countChuangSum+`</td><td>`+countZhuanBenSum+`</td><td>`+countQiTaSum+`</td><td>`+countZaiDuSum+`</td>
                                    </tr>`;
                $("#report").html(_htmlPage);
            }
        }
        $(function () {
            studentInfo.list();
        })
    })

</script>
</html>
