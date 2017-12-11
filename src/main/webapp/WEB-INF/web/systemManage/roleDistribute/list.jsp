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
        <div class="layui-tab">
            <blockquote class="layui-elem-quote mylog-info-tit">
                <div class="layui-inline">
                    <div class="layui-input-inline">
                        <div class="layui-input-inline" style="width: 200px">
                            <input name="password" id="keyWork" lay-verify="pass" placeholder="请输入姓名" autocomplete="off"
                                   class="layui-input" type="text">
                        </div>
                    </div>
                    <button class="layui-btn" onclick="role.list()"><i class="layui-icon">&#xe615;</i>查找</button>
                </div>
            </blockquote>
            <div class="larry-separate"></div>

            <div class="layui-tab-content larry-personal-body clearfix mylog-info-box">
                <div class="layui-form ">
                    <table id="example" class="layui-table lay-even " data-name="articleCatData">
                        <thead>
                        <tr>
                            <th>序号</th>
                            <th>一卡通/工号</th>
                            <th>姓名</th>
                            <th>岗位</th>
                            <th>当前权限</th>
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
    {{# layui.each(d.users, function(index, item){ }}
    <tr>
        <td>{{ index+1}}</td>
        <td>{{ item.username}}</td>
        <td>{{ item.name}}</td>
        <td>{{ item.staff}}</td>
        <td>
            <shiro:hasPermission name="userRole:update">
                <select name="{{ item.username}}" lay-filter="role_select" >

                    <option value={{ item.roleId}}> {{# if(item.roleName === undefined){ }}
                        请分配
                        {{# }else{ }}
                        {{ item.roleName}}{{#}}}</option>

                    {{# layui.each(d.roles, function(index, role){ }}
                    {{#if (item.roleId!=role.id){ }}
                    <option value={{ role.id}}>{{ role.name}}</option>
                    {{# }}}
                    {{# }); }}
                </select>
            </shiro:hasPermission>
            <shiro:lacksPermission name="userRole:update">
                <select disabled>
                    <option value={{ item.roleId}}>
                        {{# if(item.roleName === undefined){ }}
                        请分配
                        {{# }else{ }}
                        {{ item.roleName}}{{#}}}
                       </option>
                </select>
            </shiro:lacksPermission>
        </td>
    </tr>
    {{# }); }}

</script>

<script type="text/javascript" src="${baseurl}/js/searchJs.js"></script>
<script type="text/javascript" src="${baseurl}/public/common/layui/layui.js"></script>
<script type="text/javascript">
    let totalSize = 10;
    let currentIndex = 1;
    let pageSize = 10;
    let role;
    layui.use(['jquery', 'layer', 'element', 'laypage', 'form', 'laytpl', 'tree'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;
        var element = layui.element(),
            form = layui.form(),
            laytpl = layui.laytpl;


        role = {
            page: function () {
                layui.laypage({
                    cont: 'demo1',
                    pages: totalSize, //总页数
                    last: totalSize,
                    curr: currentIndex,
                    groups: 5,//连续显示分页数
                    skin: '#1E9FFF',
                    jump: function (obj, first) {
                        currentIndex = obj.curr;
                        if (!first) {
                            role.list();
                        }
                    }
                });
            },
            list: function () {
                let keyWork = $("#keyWork").val();
                $.ajax({
                    url: baseUrl + "/roleDistribute/list",
                    type:"post",
                    data: {currentIndex: currentIndex, pageSize: pageSize, name: keyWork},
                    success: function (data) {
                        if (data.result) {
                            currentIndex = data.page.currentIndex;
                            totalSize = data.page.totalSize;
                            showTotalCount(data.page.totalCount);
                            role.page();
                            laytpl($("#list-tpl").text()).render(data, function (html) {
                                $("#list").html(html);
                            });
                            form.render();

                        }
                    }
                });

            },
        }
        $(function () {
            role.list();


            form.on('select(role_select)', function (data) {
                let userName = $(data.elem).prop("name");
                let roleId = data.value
                $.post(baseUrl + "/roleDistribute/updateUserRole", {userName: userName, roleId}, function (data) {
                    layer.msg(data.msg)
                });
            });

        });
    });


</script>

</html>
