<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../public/tag.jsp" %>

<html lang="en">
<head>
    <title>高职学院信息管理系统</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="shortcut icon" href="${baseurl}/images/public/favicon.ico">

    <link rel="stylesheet" type="text/css" href="${baseurl}/public/loginStyle/assets/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/loginStyle/assets/css/form-elements.css">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/loginStyle/assets/css/style.css">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/loginStyle/assets/css/csshake.min.css">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/loginStyle/assets/css/font.css">
</head>
<style type="text/css">
    * {
        margin: 0;
        padding: 0;
        list-style-type: none;
    }

    a, img {
        border: 0;
    }

    .clock div {
        position: relative;
        float: left;
        background: white;
        border-radius: 6px;
        width: 96px;
        height: 80px;
        line-height: 80px;
        text-align: center;
        font-size: 30px;
        margin: 0px 5px;
    }
</style>
<body>

<div style="height: 20%;width:100%;z-index: 10000;;text-align: left;">
    <div style="padding: 6.0% 0 0 5%;display: inline-block;">
        <img src="${baseurl}/public/loginStyle/assets/img/backgrounds/eurasia__.jpg" height="55px">
    </div>
    <span style="color: #21a1a1;font-size: 30px;font-weight: bold;margin: 20px 0 0 20px;display: inline-block">高职学院欢迎您！</span>

</div>

<div class="top-content" style="z-index: 1000;height: 450px;background: #666">
    <div class="container">
        <div class="row" style="">
            <div class="col-sm-6  form-box" style="position: absolute;margin: 5% 0 0 -4%;">
                <div class="htmleaf-content">
                    <div class="wrapper">
                        <div style="color: white;font-size: 38px;font-weight: bold;display: inline-block">
                            快乐工作 快乐学习
                        </div>
                    </div>
                    <div class="wrapper">
                        <div class='clock' style="font-size: 16px;">
                            <div><span id="year"> </span></div>
                            <div><span id="month"></span></div>
                            <div><span id="date"></span></div>
                        </div>
                    </div>

                </div>

            </div>
            <div class="col-sm-6 col-sm-offset-5 form-box" style="width: 500px;margin-top: 5%;float: right;">
                <div style="box-shadow: 0 0 3px 3px  seashell">
                    <div class="form-top">
                        <div class="form-top-left">
                            <span style="font-size: 23px;font-weight: bold;color: #21a1a1;margin-left: 25%">高职学院信息管理系统</span>
                        </div>
                    </div>
                    <div class="form-bottom">
                        <form role="form" action="" method="post" class="login-form">
                            <div class="form-group">
                                <label class="sr-only" for="userName">帐号</label>
                                <input type="text" name="form-username" placeholder="请输入帐号"
                                       class="form-username form-control" id="userName">
                            </div>
                            <div class="form-group">
                                <label class="sr-only" for="password">密码</label>
                                <input type="password" name="form-password" placeholder="请输入密码"
                                       class="form-password form-control" id="password">
                            </div>
                            <button type="submit" class="btn " style="  background: #21a1a1">登录</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>

<div style="height: 15%;width:100%;padding-top: 1%;bottom: 0;z-index: 10000;position: fixed;">
    <span style="font-size: 12px;"> 2017-2018 © Write by Eurasia ThoughtWorks Studio.</span><br>
    <span style="font-size: 12px;display: inline-block;margin-top: -5px"> 推荐使用 Google 、 Firefox 浏览器进行访问</span>

</div>


<script src="${baseurl}/public/loginStyle/assets/js/jquery-1.11.1.min.js"></script>
<script src="${baseurl}/public/loginStyle/assets/bootstrap/js/bootstrap.min.js"></script>
<script src="${baseurl}/public/loginStyle/assets/js/jquery.backstretch.min.js"></script>
<script src="${baseurl}/public/loginStyle/assets/js/clock.js"></script>
<script src="${baseurl}/public/loginStyle/assets/js/font.js"></script>

<script type="text/javascript">
    layui.use(['jquery', 'layer'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;
        $(function () {
            $('.login-form input[type="text"], .login-form input[type="password"], .login-form textarea').on('focus', function () {
                $(this).removeClass('input-error');
            });

            $('.login-form').on('submit', function (e) {
                e.preventDefault();
                $(this).find('input[type="text"], input[type="password"], textarea').each(function () {
                    if ($(this).val() == "") {

                        $(this).addClass('input-error');
                    }
                    else {
                        $(this).removeClass('input-error');
                    }
                });
                login();
            });
        });
        function login() {
            let userName = $("#userName").val();
            let password = $("#password").val();
            $.ajax({
                url: "${baseurl}/login",
                data: {userName: userName, password: password},
                success: function (data) {
                    if (data.result) {
                        location.href = "${baseurl}/index";
                    } else {
                        layer.msg(data.msg);
                    }
                }
            });
        }
    });
    var myDate = new Date();
    let year = myDate.getFullYear();
    let month = myDate.getMonth() + 1;
    let date = myDate.getDate();
    $("#year").html(year );
    $("#month").html(month < 10 ? "0"+month : month);
    $("#date").html(date  < 10 ? "0"+date : date);
</script>
</body>
</html>