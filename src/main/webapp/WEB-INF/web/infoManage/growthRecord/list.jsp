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
    <%--时间轴--%>
    <link rel="stylesheet" href="${baseurl}/public/css/timeAsix/css/screen.css" type="text/css" media="screen">
    <link rel="stylesheet" href="${baseurl}/public/css/timeAsix/css/responsive.css" type="text/css" media="screen">
    <link rel="stylesheet" href="${baseurl}/public/css/timeAsix/inc/colorbox.css" type="text/css" media="screen">

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

        .layui-table td,.layui-table th {
            font-size: 12px;
            padding: 4px 15px;

        }
    </style>
</head>
<body>
<section class="larry-grid">
    <div class="larry-personal">
        <div class="layui-tab">

            <div class="larry-separate"></div>
            <div id="update" style="background: #fff;">
                <div class="container" id="container" style="padding: 35px 15px 35px 60px;width: 55%">
                    <div style="border: 1px solid #DBDBDB;height: 1100px;">
                        <img style="width: 200px;height: 60px;margin: 30px 40px;" src="${baseurl}/images/public/logo_.png"/>
                        <div style="margin-top: 400px;text-align: right;margin-right: 50px;line-height: normal">
                            <span style="font-size: 22px;font-weight: bold">西安欧亚学院高职学院学生成长报告</span><br>
                            <span style="font-weight: bold;margin-top: 20px;">
                    姓名：<span style="font-size: 12px" id="name"></span><br/>
                    性别：<span style="font-size: 12px" id="gender"></span><br/>
                    籍贯：<span style="font-size: 12px" id="native_place"></span><br/>
                    身份证号：<span style="font-size: 12px" id="idcard"></span><br>
                    专业：<span style="font-size: 12px" id="profession"></span><br/>
                    就业方向：<span style="font-size: 12px" id="direction2"></span><br/>
                    班级：<span style="font-size: 12px" id="political_status"></span><br/>
                </span>
                        </div>
                        <div style="height: 200px;margin-top: 40px;">
                            <span style="float:left;display: block;width: 40%;height: 200px;background-color: #009688"></span>
                            <span style="float:left;display: block;width: 18%;height: 200px;background-color: #33B8AD"></span>
                            <span style="float:left;display: block;width: 18%;height: 200px;background-color: #2fd2c3"></span>
                            <span style="float:left;display: block;width: 18%;height: 200px;text-align: center;font-weight: lighter"><span
                                    style="font-size: 150px;color: grey;">></span></span>
                            <span style="float:left;display: block;width: 6%;height: 200px;background-color: #4ED9C6"></span>
                        </div>
                    </div>
                    <div id="communication_container" style="border: 1px solid #DBDBDB;margin: 30px 0;padding: 30px 30px;">
                        <blockquote class="layui-elem-quote layui-quote-nm">
            <span style="display:inline-block;line-height:25px;font-size: 14px;font-weight: bold;">时间：2017-3-28 &nbsp;&nbsp;&nbsp;沟通老师：付老师 &nbsp;&nbsp;&nbsp; 沟通对象：吕俊杰
                <br>沟通项目：学业指导  &nbsp;&nbsp;&nbsp;沟通方式：面谈  &nbsp;&nbsp;&nbsp;电话：15682145362</span></blockquote>
                        <div class="layui-form-item  content_node" style="margin-top: 10px;">
                            <label class="layui-form-label " style="font-size: 13px">Q</label>
                            <input class="layui-textarea add-contents textarea"
                                   style="width: 80%;min-height: 30px;height: 38px;font-size: 12px;margin-bottom: 5px"/>
                            <label class="layui-form-label " style="font-size: 13px">A</label>
                            <input class="layui-textarea add-contents textarea"
                                   style="width: 80%;min-height: 50px;height: 70px;font-size: 12px;margin-left: .9%"/>
                        </div>

                    </div>
                </div>

            </div>
        </div>
    </div>
</section>
</body>
<script type="text/javascript" src="${baseurl}/public/css/timeAsix/inc/colorbox.js"></script>
<script type="text/javascript" src="${baseurl}/public/css/timeAsix/js/timeliner.min.js"></script>
<script>
    $(document).ready(function () {
        $.timeliner({
            startOpen: ['#19550828EX', '#19630828EX']
        });
        $.timeliner({
            timelineContainer: '#timelineContainer_2'
        });
        // Colorbox Modal
        $(".CBmodal").colorbox({
            inline: true,
            initialWidth: 100,
            maxWidth: 682,
            initialHeight: 100,
            transition: "elastic",
            speed: 750
        });
    });
</script>
<script type="text/javascript" src="${baseurl}/public/js/pdf/html2canvas.js"></script>
<script type="text/javascript" src="${baseurl}/public/js/pdf/jspdf.debug.js"></script>
<script type="text/javascript" src="${baseurl}/public/js/pdf/renderPDF.js"></script>

<script type="text/javascript">
    let personalCommunicationFeedbackRecords;
    let totalSize = 10;
    let currentIndex = 1;
    let pageSize = 10;
    let communication;
    let student;
    let no;
    layui.use(['jquery', 'layer', 'element', 'laypage', 'form', 'laytpl'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;
        var element = layui.element(),
            form = layui.form(),
            laytpl = layui.laytpl;

        communication = {
            previewOrUpdate: function () {
                $.post(baseUrl + "/communication/communication", {studentNo: "<shiro:principal property="userName"/>"}, function (data) {
                    personalCommunicationFeedbackRecords = data;
                    if (data.result) {
                        alert(JSON.stringify(data));
                        showCommunicationContent(data.data);
                        $("#name").text(data.data[(data.data.length - 1)].name);
                        if (data.data[(data.data.length - 1)].gender === "M") {
                            $("#gender").text("男");
                        } else {
                            $("#gender").text("女");
                        }
                        $("#native_place").text(data.data[(data.data.length - 1)].native_place);
                        $("#idcard").text(data.data[(data.data.length - 1)].idcard);
                        $("#profession").text(data.data[(data.data.length - 1)].profession);
                        $("#direction2").text(data.data[(data.data.length - 1)].direction);
                        $("#political_status").text(data.data[(data.data.length - 1)].classesName);
                    } else {
                        layer.msg(data.msg);
                    }
                });
            }
        };
        $(function () {
            communication.previewOrUpdate();
        });
    });

</script>

<script>
    layui.use(['jquery', 'layer', 'form'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;
        form = layui.form()
    });

    const content_html = `
    <div class="layui-form-item content_node">
    <label class="layui-form-label " style="font-size: 13px">Q</label>
                    <textarea placeholder="请输入问题" class="layui-textarea add-contents"
                              style="width: 80%;min-height: 30px;height: 38px;font-size: 12px;margin-bottom: 5px"></textarea>
                              <br>
                    <label class="layui-form-label " style="font-size: 13px">A</label>
                    <textarea placeholder="请输入回答" class="layui-textarea add-contents"
                              style="width: 80%;min-height: 50px;height: 70px;font-size: 12px;margin-left: .9%"></textarea>

                    <div class="layui-btn-group" >
                        <a onclick="addTalkContent()" class="layui-btn layui-btn-small"><i class="layui-icon">&#xe608;</i>添加一条 Q&A</a>
                          <a onclick="deleteContent(this)" class="layui-btn layui-btn-small layui-btn-danger"><i
                                class="layui-icon">&#xe640;</i>删除本条
                            Q&A
                        </a>
                    </div>

            </div>`;


    function addTalkContent() {
        $("#content").append(content_html);
    }

    function deleteContent(t) {
        layer.confirm('确定删除？', {icon: 3, title: '提示'}, function (index) {
            layer.close(index);
            $(t).parents(".content_node").remove();
            layer.msg("删除成功");
        })
    };


    function showCommunicationContent(data, type) {
        let communication = ""
        for (let i = 0; i < data.length - 1; ++i) {
            let com = data[i];
            communication += `<blockquote class="layui-elem-quote layui-quote-nm">
            <span style="display:inline-block;line-height:25px;font-size: 14px;font-weight: bold;">时间：` + com.time + ` &nbsp;&nbsp;&nbsp;沟通老师：` + com.teacherName + ` &nbsp;&nbsp;&nbsp; 沟通对象：` + com.talkName + `
                <br>沟通项目：` + com.direction + `  &nbsp;&nbsp;&nbsp;沟通方式：` + com.communicationMode + `  &nbsp;&nbsp;&nbsp;电话：` + com.communicationPhone + `</span></blockquote>
`;

            communication += loadPreviewQA(com.contents);

        }

        $("#communication_container").html(communication);
    }

    function loadEditQA(contents, id) {
        let QA = "";
        for (let index = 0; index < contents.length; index += 2) {
            let qaId = "q" + id + "a" + index;
            QA += `
             <dl class="timelineMinor" id="` + qaId + `">
                <dt id="` + index + `"><a style="font-size: 12px;color: peru">Q&A</a></dt>
                <div class="layui-btn-group" style="margin-bottom: 10px">
                    <a onclick="communication.updateContent(` + id + `,'` + id + `')" class="layui-btn layui-btn-small"><i
                            class="layui-icon">&#xe642;</i>修改 Q&A</a>
                </div>

                <dd class="timelineEvent" id="` + index + `EX" style="display:none;">
                     <textarea style="min-height: 30px;height: 38px;font-size: 12px;width: 500px;margin-bottom: 5px"
                               class="layui-textarea update-contents">` + contents[index] + `</textarea>
                    <textarea style="min-height: 50px;height: 70px;font-size: 12px;width: 500px"
                              class="layui-textarea update-contents">` + contents[index + 1] + `</textarea>
                    <br class="clear">
                </dd>
            </dl>
            `;
        }
        return QA;
    }

    function loadPreviewQA(contents) {
        let QA = "";
        let count = 1;
        for (let index = 0; index < contents.length; index += 2) {
            QA += ` <div class="layui-form-item  " style="margin-top: 10px;">
            <div style="line-height: 25px;">
                <div  style="font-size: 13px;width: 8%;float: left;font-weight: bold;text-align: right">Q` + (count) + `：</div>
                <div style="width: 90%;min-height: 20px;float: left;font-size: 12px;margin-bottom: 5px;">` + contents[index] + `<br></div>
            </div>
            <div style="line-height: 25px;">
                <div style="font-size: 13px;width: 8%;float: left;font-weight: bold;text-align: right">A` + (count++) + `：</div>
                <div   style="width: 90%;float: left;min-height: 20px;font-size: 12px;"> ` + contents[index + 1] + `</div>
            </div>
            </div>`;

        }
        return QA;
    }


</script>

</html>
