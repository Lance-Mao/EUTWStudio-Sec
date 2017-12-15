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


</head>
<body>
<section class=" layui-form">
    <div class="larry-personal">
        <div class="layui-tab">
<shiro:hasPermission name="communication:exportExcel">
            <button class="layui-btn " style="float: right" onclick="communication.exportExcel()"><i
                    class="layui-icon">&#xe61e;</i>导出
                EXCEl
            </button>
</shiro:hasPermission>
            <div id="container" class="layui-tab-content larry-personal-body clearfix mylog-info-box"
                 style="background: #fff;width: 100%;height: 100%;margin: 5px 0px">
                <div style="text-align: center;font-size: 20px;font-weight: bold;color: #21a1a1">
                    西安欧亚高职学院沟通次数统计表
                    <%--(<span style="font-size: 13px;" id="time">2017-6-3 12:12:21</span>)--%>
                </div>
                <table class="layui-table">
                    <thead>
                    <tr id="head">

                    </tr>
                    </thead>
                    <tbody id="report">

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
    let communication;
    layui.use(['jquery', 'layer'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;


        communication = {
            list: function () {
                $.post(baseUrl + "/communicationReport/list", function (data) {
                    console.log(data);
                    if (data.result) {
                        console.log(data);
                        let date = new Date();
                        $("#time").text(date.getFullYear() + " 年 " + (date.getMonth() + 1) + " 月 " + date.getDate() + " 日");
                        communication.loadTableHead();
                        communication.showPage(data.data);
                    } else {
                        layer.msg(data.msg);
                    }
                })
            },
            exportExcel: function () {
                location.href = baseUrl + "/communicationReport/exportExcel";
            },
            showPage: function (data) {
                let index = 0;
                let _html = "";
                let totalCount = [0, 0, 0,  0];
                data.forEach(teacher => {
                    let littleCount = [0, 0, 0,  0];
                    let types = teacher.type;
                    let levels = types[0].levels;
                    let rowSumCount = 0;
                    _html += `
                     <tr>
                        <th>` + (++index) + `</th>
                        <th rowspan="` + types.length + `">` + teacher.teacher + `</th>
                        <th>` + types[0].type + `</th>
                        `;

                    for (let j = 0; j < levels.length; ++j) {
                        _html += `<th>` + levels[j].count + `</th>`;

                        littleCount[j] += levels[j].count;
                        rowSumCount += levels[j].count;
                    }
                    _html += ` <th>` + rowSumCount + `</th>`;
                    _html += ` </tr>`;

                    littleCount[3] += rowSumCount;
                    rowSumCount = 0;

                    for (let i = 1; i < types.length; ++i) {
                        let type = types[i];
                        levels = type.levels;
                        _html += `
                             <tr>
                                <th>` + (++index) + `</th>
                                <th>` + type.type + `</th>
                          `;
                        for (let j = 0; j < levels.length; ++j) {
                            _html += `<th>` + levels[j].count + `</th>`;
                            littleCount[j] += levels[j].count;
                            rowSumCount += levels[j].count
                        }
                        _html += ` <th>` + rowSumCount + `</th>`;
                        _html += ` </tr>`;
                        littleCount[3] += rowSumCount;
                        rowSumCount = 0;
                    }

                    _html += `<tr style="background: #e8e8e8">
                         <th>` + (++index) + `</th>
                          <th style='font-weight: bold'>小计</th>
                          <th></th>
                          <th>`+littleCount[0]+`</th>
                          <th>`+littleCount[1]+`</th>
                          <th>`+littleCount[2]+`</th>
                          <th>`+littleCount[3]+`</th>
                    </tr>`;
                    for(let i in totalCount)
                        totalCount[i] += littleCount[i];
                });
                _html += `<tr>
                         <th>` + (++index) + `</th>
                          <th style='font-weight: bold'>总计</th>
                          <th></th>
                          <th>` + totalCount[0] + `</th>
                          <th>` + totalCount[1] + `</th>
                          <th>` + totalCount[2] + `</th>
                          <th>` + totalCount[3] + `</th>
                    </tr>`;
                $("#report").html(_html);
            },
            loadTableHead: function () {
                $("#head").html("");
                $("#head").append(`
                        <td>序号</td>
                        <td>职业导师</td>
                        <td>沟通类型</td>
                `);
                getSearchLevels().forEach(level => $("#head").append(`<td>` + level + `</td>`));
                $("#head").append(`<td>小计</td>`);
            }
        }
        $(function () {
            communication.list();
        })
    })

</script>
</html>
