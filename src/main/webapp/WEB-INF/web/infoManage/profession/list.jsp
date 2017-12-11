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
            <blockquote class="layui-elem-quote mylog-info-tit" style="height: 70px";>
                <shiro:hasPermission name="profession:add">
                    <ul class="layui-tab-title">
                        <li class="layui-btn " onclick="profession.add()"><i class="layui-icon">&#xe61f;</i>添加专业
                        </li>
                    </ul>
                </shiro:hasPermission>
            </blockquote>
            <div class="larry-separate"></div>

            <div class="layui-tab-content larry-personal-body clearfix mylog-info-box">
                <div class="layui-form ">
                    <table id="example" class="layui-table lay-even " data-name="articleCatData">
                        <thead>
                        <tr>
                            <th>序号</th>
                            <th>系名称</th>
                            <th>专业代码</th>
                            <th>名称</th>
                            <th>操作</th>
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
    {{# layui.each(d.professions, function(index, item){ }}
    <tr>
        <td>{{ index+1}}</td>
        <td> {{# if(item.departmentName === undefined){ }}
            无
            {{# }else{ }}
            {{ item.departmentName}}
            {{#}}}
        </td>
        <td>{{ item.code}}</td>
        <td>{{ item.name}}</td>
        <td>
            <shiro:hasPermission name="profession:update">
                <button class="layui-btn layui-btn-mini " style="background: #21a1a1"
                        onclick="profession.update('{{item.id}}','{{item.code}}','{{item.name}}')">
                    <i class="layui-icon">&#xe642;</i>修改
                </button>
            </shiro:hasPermission>
            <shiro:hasPermission name="profession:delete">
                <button class="layui-btn layui-btn-mini  layui-btn-danger" onclick="profession.delete('{{item.id}}')">
                    <i class="layui-icon">&#xe60a;</i>删除
                </button>
            </shiro:hasPermission>
        </td>
    </tr>
    {{# }); }}

</script>
<div id="add" style="margin: 10px;display: none">
    <form id="add-form" lay-filter="role-add" class="layui-form layui-form-pane" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">专业代码</label>
            <div class="layui-input-inline">
                <input type="text" name="code"
                       placeholder="请输入专业代码" autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">专业名称</label>
            <div class="layui-input-inline">
                <input type="text" name="name"
                       placeholder="请输入专业名称" autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <a class="layui-btn"   onclick="profession.addAjax()">立即提交</a>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<div id="update" style="margin: 10px;display: none">
    <form id="update-form" lay-filter="role-add" class="layui-form layui-form-pane" method="post">
        <input type="hidden" id="id" name="id"/>
        <div class="layui-form-item">
            <label class="layui-form-label">专业代码</label>
            <div class="layui-input-inline">
                <input type="text" id="code" name="code" required jq-verify="required"
                       placeholder="请输入专业代码" autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">专业名称</label>
            <div class="layui-input-inline">
                <input type="text" id="name" name="name" required jq-verify="required"
                       placeholder="请输入专业名称" autocomplete="off" class="layui-input ">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <a class="layui-btn" onclick="profession.updateAjax()">立即提交</a>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<script type="text/javascript" src="${baseurl}/public/common/layui/layui.js"></script>
<script type="text/javascript" src="${baseurl}/js/searchJs.js"></script>
<script type="text/javascript">
    let totalSize = 10;
    let currentIndex = 1;
    let pageSize = 10;
    let profession;
    layui.use(['jquery', 'layer', 'element', 'laypage', 'form', 'laytpl', 'tree'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;
        var element = layui.element(),
            form = layui.form(),
            laytpl = layui.laytpl;


        profession = {
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
                            profession.list();
                        }
                    }
                });
            },
            list: function () {
                $.ajax({
                    url: baseUrl + "/profession/list",
                    data: {currentIndex: currentIndex, pageSize: pageSize},
                    success: function (data) {
                        if (data.result) {
                            currentIndex = data.page.currentIndex;
                            totalSize = data.page.totalSize;
                            showTotalCount(data.page.totalCount);
                            profession.page();
                            laytpl($("#list-tpl").text()).render(data, function (html) {
                                $("#list").html(html);
                            });
                            form.render();

                        }
                    }
                });
            },
            add: function () {
                layer.open({
                    type: 1,
                    title: '添加'
                    , content: $("#add")
                });

            },
            update: function (id, code, name) {
                $("#id").val(id);
                $("#code").val(code);
                $("#name").val(name);
                layer.open({
                    type: 1,
                    title: '修改'
                    , content: $("#update")
                });
            },
            delete: function (id) {
                layer.confirm('确定删除？', {icon: 3, title: '提示'}, function (index) {
                    layer.close(index);
                    $.post(baseUrl + "/profession/delete", {id: id}, function (data) {
                        layer.msg(data.msg);
                        location.reload();
                    })
                });
            },
            addAjax: function () {
                let data = $("#add-form").serialize();
                $.post(baseUrl + "/profession/add", data, function (data) {
                    layer.msg(data.msg);
                    if (data.result) {
                        setTimeout("location.reload()", 500);
                    }
                })
            },
            updateAjax: function () {
                let data = $("#update-form").serialize();
                $.post(baseUrl + "/profession/update", data, function (data) {
                    layer.msg(data.msg);
                    if (data.result) {
                        setTimeout("location.reload()", 500);
                    }

                })
            }
        };
        $(function () {
            profession.list();
        });
    });


</script>

</html>
