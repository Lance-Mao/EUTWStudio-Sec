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
        <div class="layui-tab">
            <blockquote class="layui-elem-quote mylog-info-tit" style="height: 70px">
                    <div class="layui-inline">
                        <div class="layui-input-inline"  style="width: 200px;margin-bottom: 10px;">
                            <select lay-filter="level" id="level_search">
                                <option value="">年级</option>
                            </select>
                        </div>
                    </div>
                <div class="layui-inline">
                    <div class="layui-input-inline" style="width: 200px;margin-bottom: 10px;">
                        <input type="text" name="courseCode" id="course_code_search" lay-verify="title"
                               autocomplete="off"
                               placeholder="课程代码" value="" class="layui-input">
                    </div>
                    <div class="layui-inline">
                        <div class="layui-input-inline" style="width: 200px ;margin-bottom: 10px;">
                            <input type="text" name="courseName" id="course_name_search" lay-verify="title"
                                   autocomplete="off"
                                   placeholder="课程名称" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">分数</label>
                        <div class="layui-input-inline" style="width: 100px;">
                            <input type="text" name="lessThanScore" id="less_than_score_score" placeholder="0"
                                   autocomplete="off" value="0" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label" style="margin-left: -28%"> - </label>
                        <div class="layui-input-inline" style="width: 100px;">
                            <input type="text" name="moreThanScore" value="100" id="more_than_score_score"
                                   placeholder="100"
                                   autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <a class="layui-btn" style="width: auto ;margin-bottom: 10px;"
                       onclick="currentIndex=1;search_.list()"><i
                            class="layui-icon">&#xe615;</i>搜索</a>
                    <a class="layui-btn" style="width: auto ;margin-bottom: 10px;" onclick="search_.exportExcel()"><i
                            class="layui-icon">&#xe61e;</i>导出 Excel</a>
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
                        <th>课程代码</th>
                        <th>课程名称</th>
                        <th>分数</th>
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
<script id="list-tpl" type="text/html">
    {{# layui.each(d.results, function(index, item){ }}
    <tr>
        <td>  {{# if(item.departmentName === undefined){ }}
            无
            {{# }else{ }}
            {{ item.departmentName}}{{#}}}
        </td>
        <td>{{ item.level}}</td>
        <td>
            {{# if(item.directionName === undefined){ }}
            无
            {{# }else{ }}
            {{ item.directionName}}{{#}}}

        </td>
        <td>
            {{# if(item.classesName === undefined){ }}
            无
            {{# }else{ }}
            {{ item.classesName}}{{#}}}
           </td>
        <td>{{ item.no}}</td>
        <td>{{ item.studentName}}</td>
        <td>{{ item.courseCode}}</td>
        <td>{{ item.courseName}}</td>
        <td>{{ item.score}}</td>
    </tr>
    {{# }); }}

</script>
<script src="${baseurl}/js/searchJs.js" />
<script type="text/javascript" src="${baseurl}/public/common/layui/layui.js"></script>
<script type="text/javascript">
    let search_;
    let totalSize = 10;
    let currentIndex = 1;
    let pageSize = 10;
    layui.use(['jquery', 'layer', 'element', 'laypage', 'form', 'laytpl'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;
        var element = layui.element(),
            form = layui.form(),
            laytpl = layui.laytpl;

        search_ = {
            page: function () {
                layui.laypage({
                    cont: 'demo1',
                    pages: totalSize, //总页数
                    curr: currentIndex,
                    last:totalSize,
                    groups: 5,//连续显示分页数
                    skin: '#1E9FFF',
                    jump: function (obj, first) {
                        currentIndex = obj.curr;
                        if (!first) {
                            search_.list();
                        }
                    }
                });
            },
            list: function () {
                layer.msg("查询中......");
                let data = {
                    courseCode: $("#course_code_search").val(),
                    courseName: $("#course_name_search").val(),
                    level: $("#level_search").val(),
                    lessThanScore: $("#less_than_score_score").val(),
                    moreThanScore: $("#more_than_score_score").val(),
                    currentIndex: currentIndex,
                    pageSize: pageSize
                };
                $.ajax({
                    url: baseUrl + "/result/searchList",
                    data: data,
                    type: "post",
                    success: function (data) {
                        if (data.result) {
                            currentIndex = data.page.currentIndex;
                            totalSize = data.page.totalSize;
                            search_.page();
                            showTotalCount(data.page.totalCount);
                            laytpl($("#list-tpl").text()).render(data, function (html) {
                                $("#list").html(html);
                            });
                            form.render();
                        } else {
                            layer.msg(data.msg);
                        }
                    }
                });
            },
            loadAllLevels: function () {
                $("#level_search").html(`<option value="">年级</option><option value="">请选择</option>`);
                let levels = getSearchLevels().reverse();

                levels.forEach(level => {
                    $("#level_search").append(`<option value="` + level + `">` + level + `</option>`);
                });
            },
            exportExcel: function () {
                let courseCode = $("#course_code_search").val()
                let courseName = $("#course_name_search").val()
                let level =$("#level_search").val()
                let lessThanScore = $("#less_than_score_score").val()
                let moreThanScore = $("#more_than_score_score").val()
                location.href = baseUrl + "/result/exportSearchReportExcel?" +
                    "courseCode=" + courseCode +
                    "&courseName=" + courseName +
                    "&level=" + level +
                    "&lessThanScore=" + lessThanScore +
                    "&moreThanScore=" + moreThanScore
            }
        };
        $(function () {
//            search_.list();
            search_.loadAllLevels();
            form.render();
        });
    })

</script>


</html>
