<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../../../public/tag.jsp" %>
<html>
<head>
    <meta charset="utf-8">
    <title></title>
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
                <ul class="layui-tab-title">
                    <li class="layui-btn " onclick="menu.addMenu()"><i class="layui-icon">&#xe61f;</i>添加菜单
                    </li>
                </ul>
            </blockquote>
            <div class="larry-separate"></div>

            <div class="layui-tab-content larry-personal-body clearfix mylog-info-box">
                <div class="layui-form ">
                    <table id="example" class="layui-table lay-even " data-name="articleCatData">
                        <thead>
                        <tr>
                            <th>id</th>
                            <th>菜单名称</th>
                            <th>url</th>
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
<%@ include file="layer.jsp" %>
<script type="text/javascript" src="${baseurl}/public/common/layui/layui.js"></script>
<script type="text/javascript">
    let menu, currentMenuId;
    layui.use(['jquery', 'layer', 'element', 'laypage', 'form', 'laytpl'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;
        let element = layui.element(),
            form = layui.form(),
            laytpl = layui.laytpl;

        menu = {
            list: function () {
                $.ajax({
                    url: baseUrl + "menu/list",
                    type: "post",
                    success: function (data) {
                        if (data.result) {
                            laytpl($("#list-tpl").text()).render(data, function (html) {
                                $("#list").html(html);
                            });
                            form.render();
                        }
                    }
                });

            },
            addMenu: function () {
                layer.open({
                    type: 1,
                    title: '菜单添加'
                    , content: $("#add")
                });
            },
            addMenuAjax: function () {
                let data = $("#menu-add").serialize();
                $.post('${baseurl}/menu/addFirstMenu', data, (data) => {
                        layer.msg(data.msg);
                        if (data.result) {
                            setTimeout('location.reload()', 500);
                        }
                    }
                )
            },
            delete: function (id) {
                layer.confirm('确定删除？', {icon: 3, title: '提示'}, function (index) {
                    layer.close(index);
                    $.post(baseUrl + "/menu/delete", {id: id}, function (data) {
                        layer.msg(data.msg);
                        setTimeout("location.reload()", 500);
                    })
                });
            }
            ,
            update: function (id, name, url) {
                $("#update_id").val(id);
                $("#update_name").val(name);
                $("#update_url").val(url);
                layer.open({
                    type: 1,
                    title: '菜单添加'
                    , content: $("#update")
                });
            },
            updateMenuAjax: function () {
                let data = $("#update_form").serialize();
                $.post('${baseurl}/menu/updateMenu', data, (data) => {
                        layer.msg(data.msg);
                        if (data.result) {
                            setTimeout('location.reload()', 500);
                        }
                    }
                )
            },
            subMenu: function (id) {
                currentMenuId = id;
                $.post('${baseurl}/menu/secondMenus', {id: id}, (data) => {
                    if (data.result) {
                        menu.fillMenus(data.data);

                        layer.open({
                            type: 1,
                            title: '子菜单',
                            area: ["100%", "100%"]
                            , content: $("#subMenu")
                        });
                    }
                })
            },
            addSecondMenu: function () {
                layer.open({
                    type: 1,
                    title: '菜单添加'
                    , content: $("#secondMenu-add")
                });
            },
            addSecondMenuAjax: function () {
                let data = $("#secondMenu-add-form").serialize() + `&parentId=` + currentMenuId;
                $.post('${baseurl}/menu/addSecondMenu', data, (data) => {
                        layer.msg(data.msg);
                    }
                )
            },
            updateSecondMenu: function (event, id, name, url) {
                event.preventDefault();

                $("#updateSecond_id").val(id);
                $("#updateSecond_name").val(name);
                $("#updateSecond_url").val(url);
                layer.open({
                    type: 1,
                    title: '修改'
                    , content: $("#secondMenu-update")
                });
            },
            updateSecondMenuAjax: function () {
                let data = $("#secondMenu-update-form").serialize();
                $.post('${baseurl}/menu/updateMenu', data, (data) => {
                        layer.msg(data.msg);
                    }
                )
            },
            addPermission: function (event, id) {
                event.preventDefault();
                $("#parentId-add").val(id);
                layer.open({
                    type: 1,
                    title: '添加'
                    , content: $("#permission-add")
                });
            },
            addPermissionAjax: function () {
                let data = $("#permission-add-form").serialize();
                $.post('${baseurl}/menu/addPermission', data, (data) => {
                        layer.msg(data.msg);
                    }
                )
            },
            deleteSecondMenu: function (event, id) {
                event.preventDefault();
                layer.confirm('确定删除(同时将该菜单下所有的权限一起删除)？', {icon: 3, title: '提示'}, function (index) {
                    layer.close(index);
                    $.post(baseUrl + "/menu/deleteSecondMenu", {id: id}, function (data) {
                        layer.msg(data.msg);
                    })
                });
            },
            updatePermission: function (id,name,percode) {
                $("#permission_id").val(id);
                $("#permission_name").val(name);
                $("#permission_perCode").val(percode);
                layer.open({
                    type: 1,
                    title: '修改'
                    , content: $("#permission-update")
                });
            },
            updatePermissionAjax:function () {
                let data = $("#permission-update-form").serialize();
                $.post(baseUrl + "/menu/updatePermission", data, function (data) {
                    layer.msg(data.msg);
                })
            },
            fillMenus: function (menus) {
                let _html = "";
                menus.map(men => {
                    _html += menu.fillMenu(men);
                });
                $("#menus").html(_html);
                element.init();
            },
            fillMenu: function (men) {
                let _html = `<div class="layui-colla-item menu">
                                <h5 class="layui-colla-title">
                                    <span class="menu_text">` + men.name + `</span>
                                    <span class="menu_url">` + men.url + `</span>
                                    <div style="float: right">
                                        <button class="layui-btn layui-btn-mini  "
                                                onclick="menu.updateSecondMenu(event,` + men.id + `,'` + men.name + `','` + men.url + `')">
                                            <i class="layui-icon">&#xe642;</i>修改
                                        </button>
                                        <button class="layui-btn layui-btn-mini  layui-btn-danger" onclick="menu.deleteSecondMenu(event,` + men.id + `)">
                                            <i class="layui-icon">&#xe60a;</i>删除
                                        </button>
                                        <button class="layui-btn layui-btn-mini  " onclick="menu.addPermission(event,` + men.id + `)">
                                            <i class="layui-icon">&#xe61e;</i>添加权限
                                        </button>
                                    </div>
                                </h5>`;
                _html += men.permissions !== undefined ? menu.fillPermissions(men.permissions) : "";
                _html += `</div>`;
                return _html;
            },
            fillPermissions: function (permissions) {
                let _html = `<div class="layui-colla-content permissions" >`;
                for (let per of permissions) {
                    _html += `<div class="permission" style="display: inline-block;padding: 5px">
                                <label>` + per.name + `</label>
                                <label>` + per.percode + `</label>
                                <button class="layui-btn layui-btn-mini " onclick="menu.updatePermission(` + per.id + `,'` + per.name + `','` + per.percode + `')">
                                    <i class="layui-icon">&#xe61e;</i>修改
                                </button>
                                <button class="layui-btn layui-btn-mini layui-btn-danger" onclick="menu.delete(` + per.id + `)">
                                    <i class="layui-icon">&#xe61e;</i>删除
                                </button>
                            </div>`;
                }
                _html += `</div>`;
                return _html;
            }
        };
        $(function () {
            menu.list();
        });
    });
</script>
</html>
