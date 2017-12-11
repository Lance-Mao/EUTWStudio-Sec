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

        <div id="preview" style="margin: 10px;">
            <form id="preview-form" class="layui-form layui-form-pane" method="post">
                <fieldset class="layui-elem-field">
                    <legend id="title-preview" style="font-size: 24px;font-weight: 700;padding: 10px 10%">
                        西安欧亚学院高职学院课程学习计划
                    </legend>
                    <div class="layui-field-box">
                        <div id="modelCourses-preview" style="margin: 3% 0 0 6%">

                        </div>
                    </div>
                </fieldset>
                <blockquote class="layui-elem-quote layui-quote-nm">
                    必修：<span id="compulsoryScore">100</span>学分&nbsp;&nbsp;&nbsp;选修：<span id="electiveScore">8</span>学分&nbsp;&nbsp;&nbsp;总计：<span
                        id="totalScore">108</span>学分
                </blockquote>

            </form>
        </div>
    </div>
</section>
</body>
<script type="text/javascript" src="${baseurl}/public/common/layui/layui.js"></script>
<script type="text/javascript">

    $(function () {
        $.post(baseUrl + "/learnPlan/show", {studentNo: "<shiro:principal property="userName"/>"}, function (data) {
            if (data.result) {
                let program = data.data.program;
                let title = `西安欧亚学院高职学院` + program.departmentName + program.level + `级` + program.directionName + `方向课程学习计划`;
                $("#title-preview").text(title);

                $("#modelCourses-preview").html(loadHasModuleCourse(data.data.moduleCourses));
            } else {
                layer.msg(data.msg);
            }
        });
    })
    ;
    function loadHasModuleCourse(allModuleCourses) {
        let electiveSocre = 0, compulsorySocre = 0;
        let moduleCourses = [];
        for (let i = 0; i < allModuleCourses.length; ++i)
            if (allModuleCourses[i].isChecked == "checked") moduleCourses.push(allModuleCourses[i]);
        let totalHtml = "";
        let _html = "";
        let moduleId = moduleCourses.length === 0 ? 0 : moduleCourses[0].id;
        for (let i = 0; i < moduleCourses.length; ++i) {
            moduleCourses[i].nature === "选修" ? electiveSocre += moduleCourses[i].schoolScore : compulsorySocre += moduleCourses[i].schoolScore;
            if (moduleCourses[i].id !== moduleId) {
                totalHtml += `<div class="modules"  data='` + moduleId + `'> <div class="layui-form-item">
                                          <label class="" style="margin-left: 5%">` + moduleCourses[i - 1].moduleName + `</label>
                                             `
                    + _html + `

                                       </div></div>`;

                moduleId = moduleCourses[i].id;
                _html = ` <div class="layui-input-block" >
                                            <p style="color: black"  class="course" >
                                                <span style="margin-right: 0px"> ` + moduleCourses[i].courseName + `</span>
                                                <span style="margin-right: 0px">/` + moduleCourses[i].schoolScore + ` 学分</span>
                                                <span style="margin-right: 0px">/` + moduleCourses[i].schoolHours + ` 课时</span>
                                                <span style="margin-right: 0px">/` + moduleCourses[i].nature + `</span>
                                                <span style="margin-right: 0px">/` +(moduleCourses[i].testMethodName!==undefined ?moduleCourses[i].testMethodName:"暂无")+ `</span>
                                            </p>
                                   </div>`
            } else {
                _html += ` <div class="layui-input-block" >
                                        <p style="color: black"  class="course" >
                                            <span style="margin-right: 0px">` + moduleCourses[i].courseName + `</span>
                                            <span style="margin-right: 0px">/` + moduleCourses[i].schoolScore + ` 学分</span>
                                            <span style="margin-right: 0px">/` + moduleCourses[i].schoolHours + ` 课时</span>
                                            <span style="margin-right: 0px">/` + moduleCourses[i].nature + `</span>
                                            <span style="margin-right: 0px">/` + (moduleCourses[i].testMethodName!==undefined ?moduleCourses[i].testMethodName:"暂无") + `</span>
                                        </p>
                                  </div>`
            }
            if (i === moduleCourses.length - 1 && moduleCourses[i].id === moduleId) {
                totalHtml += ` <div class="modules"  data='` + moduleId + `'> <div class="layui-form-item">
                                          <label class=""  style="margin-left: 5%">` + moduleCourses[i - 1].moduleName + `</label>
                                            `
                    + _html + `
                                       </div></div>`;
            }
        }

        $("#electiveScore").text(electiveSocre);
        $("#compulsoryScore").text(compulsorySocre);
        $("#totalScore").text(compulsorySocre + electiveSocre);
        return totalHtml;
    }


</script>

</html>
