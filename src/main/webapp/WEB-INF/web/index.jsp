<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../public/tag.jsp" %>
<html lang="en">
<head>
    <title>高职学生信息管理系统</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8">
    <link rel="shortcut icon" href="${baseurl}/images/public/favicon.ico">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/layui/css/layui.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/css/global.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/css/font_bmgv5kod1961tt9.css">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/css/backstage.css" media="all">
</head>
<body>
<div class="layui-layout layui-layout-admin" id="layui_layout">
    <!-- 顶部区域 -->
    <div class="layui-header header-menu">
        <div class="logo posb" id="log" >
            <img src="${baseurl}/images/public/logo_.png" style="height: 45px" />
        </div>

        <div class="layui-main posb">
            <!-- 左侧导航收缩开关 -->
            <%--<div class="side-menu-switch posb" id="toggle"><span class="switch" ara-hidden="true"></span></div>--%>
            <!-- 顶级菜单 -->
            <div class="larry-top-menu posb">
                <ul class="layui-nav clearfix" id="menu">
                </ul>
            </div>
            <!-- 右侧常用菜单导航 -->
            <div class="larry-right-menu posb">

                <ul class="layui-nav clearfix">

                    <li class="layui-nav-item">
                        <a id="larryTheme"><i class="larry-icon larry-theme1"></i>设置主题</a>
                    </li>

                    <li class="layui-nav-item exit">
                        <a id="logout"><i class="larry-icon larry-exit"></i><cite>退出</cite></a>
                    </li>
                </ul>
            </div>
        </div>
    </div>
    <!-- 左侧导航 -->
    <div class="layui-side larrycms-left" id="larry-side">
        <div class="layui-side-scroll">
            <!-- 管理员信息      -->
            <div class="user-info" style="height: 5px">
                <%--<div class="photo">--%>
                    <%--<img src="${baseurl}/public/images/user/<shiro:principal property="headImage" />">--%>
                <%--</div>--%>
                <%--<p>hello <shiro:principal property="name"/></p>--%>
            </div>
            <!-- 系统菜单 -->
            <div class="sys-menu-box">
                <ul class="layui-nav layui-nav-tree" id="larrySideNav" lay-filter="side">

                </ul>
            </div>
        </div>
    </div>
    <!-- 右侧主题内容 -->
    <div class="layui-body" id="larry-body">
        <div class="layui-tab" id="larry-tab" lay-filter="larryTab">
            <div class="larry-title-box">
                <div class="go-left key-press pressKey" id="titleLeft" title="滚动至最右侧"><i
                        class="larry-icon larry-weibiaoti6-copy"></i></div>
                <ul class="layui-tab-title" lay-allowClose="true" id="layui-tab-title" lay-filter="subadd">
                    <li class="layui-this" id="admin-home" lay-id="0" fresh=1>
                        <i class="larry-icon larry-houtaishouye"></i><em>最新动态</em>
                    </li>
                </ul>
                <div class="title-right" id="titleRbox">
                    <div class="go-right key-press pressKey" id="titleRight" title="滚动至最左侧"><i
                            class="larry-icon larry-right"></i></div>
                    <div class="refresh key-press" id="refresh_iframe"><i
                            class="larry-icon larry-shuaxin2"></i><cite>刷新</cite></div>
                    <div class="often key-press" lay-filter='larryOperate' id="buttonRCtrl">
                        <ul class="layui-nav posr">
                            <li class="layui-nav-item posb">
                                <a class="top"><i class="larry-icon larry-caozuo"></i><cite>常用操作</cite></a>
                                <dl class="layui-nav-child">
                                    <dd>
                                        <a data-eName="closeCurrent"><i class="larry-icon larry-guanbidangqianye"></i>关闭当前选项卡</a>
                                    </dd>
                                    <dd>
                                        <a data-eName="closeOther"><i
                                                class="larry-icon larry-guanbiqita"></i>关闭其他选项卡</a>
                                    </dd>
                                    <dd>
                                        <a data-eName="closeAll"><i class="larry-icon larry-guanbiquanbufenzu"></i>关闭全部选项卡</a>
                                    </dd>
                                    <dd>
                                        <a data-eName="refreshAdmin"><i
                                                class="larry-icon larry-kuangjia_daohang_shuaxin"></i>刷新最外层框架</a>
                                    </dd>
                                </dl>
                            </li>
                        </ul>
                    </div>

                </div>
            </div>
            <div class="layui-tab-content">
                <div class="layui-tab-item layui-show">
                    <iframe class="larry-iframe" data-id='0' name="ifr_0" id='ifr0' src="${baseurl}/main"></iframe>
                </div>
            </div>
        </div>
    </div>
    <!-- footer -->
    <div class="layui-footer layui-larry-foot psob" id="larry-footer">
        <div class="layui-main">

            <p> 2017-2018 © Write by Eurasia ThoughtWorks Studio.</p>
        </div>
    </div>
    <!-- footer end -->
    <!-- layui-layout-admin end -->
</div>
<!-- 加载js文件-->

<script type="text/javascript" src="${baseurl}/public/js/larrycms.js"></script>
<!-- 主题配置 -->
<div class="larryThemeContent" id="LarryThemeSet" style="display:none;">
    <div class="larry-theme-form">
        <h3>系统主题预设</h3>
        <form action="" class="layui-form larry-theme-con">
            <div class="layui-form-item select-theme">
                <label class="layui-form-label">主题选择</label>
                <div class="layui-input-block">
                    <select lay-filter="larryTheme" lay-verify="" id="themeName">
                        <option value="larry">默认主题</option>
                        <option value="A">深蓝主题</option>
                        <option value="B">墨绿主题</option>
                    </select>
                </div>
            </div>

            <div class="layui-form-item submit-form">
                <button class="layui-btn larry-button" lay-submit="" lay-filter="submitlocal">立即设置主题</button>
                <button type="reset" class="layui-btn layui-btn-primary">重置当前设置</button>
            </div>
        </form>
    </div>
</div>
<!-- layui-body常用菜单定义 -->
<div class="rightMenu" id="rightMenu" style="display: none;">
    <ul>
        <li data-target="refreshCur">
            <i class="larry-icon "></i>刷新当前页面
        </li>
        <li data-target="refreshKj">
            <i class="larry-icon "></i>刷新外层框架
        </li>
        <li data-target="closeCurrent">
            <i class="larry-icon "></i>关闭当前选项卡
        </li>
        <li data-target="closeOther">
            <i class="larry-icon "></i>关闭其他选项卡
        </li>
        <li data-target="closeAll">
            <i class="larry-icon "></i>全部关闭选项卡
        </li>
    </ul>
</div>
</body>
</html>
