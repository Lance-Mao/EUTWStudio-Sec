<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../public/tag.jsp" %>

<html lang="en">
<head>
    <title>高职学生信息管理系统</title>
    <meta http-equiv="pragma" content="no-cache">
    <meta http-equiv="cache-control" content="no-cache">
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">

    <!-- load css -->
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/layui/css/layui.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/css/global.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/css/font_bmgv5kod1961tt9.css">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/bootstrap/css/bootstrap.min.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/css/common.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/css/main.css" media="all">
</head>
<style type="text/css">
    *{

    }
    .h1, .h2, .h3, h1, h2, h3{
        margin: 0px;
        font-size: 18px;

    }
    .layui-colla-title{
        background-color: #ffffff;
    }
</style>
<body>
    <div style="width: 95%;margin: 0 auto">
        <blockquote class="layui-elem-quote" id="admin">尊敬的<span><shiro:principal property="name"/></span>您好<i class="larry-icon larry-guanbi close" id="closeInfo"></i></blockquote>
    </div>
        <fieldset class="layui-elem-field layui-field-title"style="margin-top: 10px;width: 95%;margin: 10 auto;margin-bottom: 10px;">
            <legend>公告栏</legend>
        </fieldset>
    <div class="" style="width: 95%;margin: 0 auto;font-size: 16px; " >
        <div class="layui-collapse " id="notice" lay-filter="test">

            </div>
        </div>

    </div>
    <script>
        //注意：折叠面板 依赖 element 模块，否则无法进行功能性操作
        layui.use('element', function(){
            var element = layui.element;

            //…
        });
    </script>
</div>
.<script type="text/javascript" src="${baseurl}/public/common/layui/layui.js"></script>
<script type="text/javascript" src="${baseurl}/public/common/js/jquery-3.2.0.min.js"></script>
<script type="text/javascript" src="${baseurl}/public/common/bootstrap/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${baseurl}/public/common/jsplugin/jquery.leoweather.min.js"></script>
<script type="text/javascript" src="${baseurl}/public/common/jsplugin/echarts.min.js"></script>
<!-- 引入当前页面js文件 -->
<script type="text/javascript" src="${baseurl}/public/js/main.js"></script>
<script type="text/javascript">

    let notice;
    layui.use(['jquery', 'layer', 'element', 'laypage', 'form', 'laytpl', 'tree', 'layedit'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;

        var element = layui.element(),
            form = layui.form(),
            layedit = layui.layedit,
            laytpl = layui.laytpl;

        notice = {
            delete: function (id) {
                layer.confirm('确定删除？', {icon: 3, title: '提示'}, function (index) {
                    layer.close(index);
                    $.post(baseUrl + "/notice/delete", {id: id}, function (data) {
                        layer.msg(data.msg);
                            setTimeout("location.reload()", 500);
                    })
                });
            },
            list: function () {
                $.post(baseUrl + "/notice/list", function (data) {
//                    layer.msg(data.msg);
                    notice.showMassage(data.data);
                    element.init();
                });
            },
            showMassage:function (data) {
                $("#notice").html("");
                for(var i = 0;i<data.length;i++){
                    $("#notice").append(`
                <div class="layui-colla-item">
                <h2 class="layui-colla-title" style="height: 90px;">
                    公告：`+data[i].title+`<span style="font-size: 12px;color: darkgray;float: right"></span><br>
                    <p style="font-size: 12px;color: darkgray;text-indent: 2em;">发布人：`+data[i].name+`<span style="margin-left: 20px;"> 发时间： `+data[i].time+`</span>
                    <shiro:hasPermission name="notice:delete">

                    <button style="float: right" class="layui-btn layui-btn-mini  layui-btn-danger" onclick="notice.delete(`+data[i].id+`)">
                        <i class="layui-icon">&#xe60a;</i>删除
                    </button>
                    </shiro:hasPermission>
                    </p>
                    <i class="layui-icon layui-colla-icon"></i>

                </h2>
                <div class="layui-colla-content ">
                    <p style="font-size: 14px;">`+data[i].content+`</p>
                </div>
                </div>`);
                }
            }
        },
        $(function () {
            notice.list();
        });

    });

    $("#closeInfo").click(function () {
        $("#admin").hide();
    });

</script>

</body>
</html>