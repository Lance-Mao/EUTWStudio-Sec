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
                    <shiro:hasPermission name="rolePermission:add">
                        <li class="layui-btn " onclick="role.addMenu()"><i class="layui-icon">&#xe61f;</i>添加角色
                        </li>
                    </shiro:hasPermission>

                </ul>
            </blockquote>
            <div class="larry-separate"></div>

            <div class="layui-tab-content larry-personal-body clearfix mylog-info-box">
                <div class="layui-form ">
                    <table id="example" class="layui-table lay-even " data-name="articleCatData">
                        <thead>
                        <colgroup>
                            <col width="200">
                            <col width="400">
                            <col width="300">
                            <col width="300">
                        </colgroup>
                        <tr>
                            <th>序号</th>
                            <th>角色名称</th>
                            <th>是否可用</th>
                            <th >操作</th>
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
<script type="text/javascript" src="${baseurl}/js/searchJs.js"></script>
<script type="text/javascript" src="${baseurl}/public/common/layui/layui.js"></script>
<script type="text/javascript">
    let totalSize = 10;
    let currentIndex = 1;
    let pageSize = 10;
    let role;
    let roleid;
    let hasPermission;
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
                $.ajax({
                    url: baseUrl + "userRole/list",
                    type:"post",
                    data: {currentIndex: currentIndex, pageSize: pageSize},
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
            addMenu: function () {
                layer.open({
                    type: 1,
                    title: '角色添加'
                    , content: $("#add")
                });

            },
            viewRole: function (id) {
                $.ajax({
                    url: baseUrl + "userRole/query",
                    type:"post",
                    data: {roleId: id},
                    success: function (data) {
                        if (data.result) {
                            data = data.data;
                            $("#update_id").val(data.id);
                            $("#update_name").val(data.name);
                            let isAvailable = data.available === "true" ? true : false;
                            $("#update_available_" + isAvailable + "").prop({checked: true});
                            form.render();
                            layer.open({
                                type: 1,
                                title: '角色修改'
                                , content: $("#update")
                            });
                        }
                    }
                });
            },
            updateRole: function () {
                let data = $("#update_form").serialize();
                $.post(baseUrl + "/userRole/update", data, function (data) {
                    layer.msg(data.msg);
                    if (data.result) {
                        setTimeout("location.reload()", 500);
                    }
                })
            },
            viewPermission: function (roleId) {
                $.ajax({
                    url: baseUrl + "/userRole/viewPermission",
                    type:"post",
                    data: {roleId: roleId},
                    success: function (data) {
                        if (data.result) {
                            roleid = roleId;
                            hasPermission = data.data.hasPermissions;
                            let nodes = role.changePermissionToTree(data.data.permissions);

                            role.showRoleTree(nodes);
                        }
                    }
                })

            }
            ,deletePermission: function (roleId) {
                layer.confirm('确定删除？', {icon: 3, title: '提示'}, function (index) {
                    layer.close(index);
                    $.ajax({
                        url: baseUrl + "/userRole/deletePermission",
                        type:"post",
                        data: {roleId: roleId},
                        success: function (data) {
                            layer.msg(data.msg);
                            if (data.result) {
                                setTimeout("location.reload()", 500);
                            }
                        }
                    })
                });
            }
            ,
            showRoleTree: function (nodes) {
                $("#tree").html("");
                layui.tree({
                    elem: $("#tree"),
                    nodes: nodes
                });
                layer.open({
                    type: 1,
                    title: '角色权限分配'
                    , content: $("#tree"),
                    area: ['100%', '100%'],
                    btnAlign: 'l',
                    btn: ['确定修改']
                    , yes: function (index, layero) {
                        let updatePermissions = "";
                        let allNodes = $(".per");
                        for (let i = 0; i < allNodes.length; ++i) {
                            if ($(allNodes[i]).prop("checked")) {
                                updatePermissions += $(allNodes[i]).val() + ",";
                            }
                        }
                        $.post(baseUrl + "/userRole/updateRolePermissions", {
                            hasPers: hasPermission.toString(),
                            updatePers: updatePermissions,
                            roleId: roleid
                        }, function (data) {
                            layer.msg(data.msg);
                            if (data.result) {
                                setTimeout("location.reload()", 500);
                            }
                        });
                    }
                })
            },
            check: function (t, type, parentId) {
                let currentNodeChecked = $(t).prop("checked");
                if (type === 1) {
                    if (currentNodeChecked) return;
                    let childrens = role.findChildrenNode(t, "side_");
                    for (let i = 0; i < childrens.length; ++i) {
                        $(childrens[i]).prop({checked: false});
                        let permissions = role.findChildrenNode(childrens[i], "per_");
                        for (let i = 0; i < permissions.length; ++i) {
                            $(permissions[i]).prop({checked: false});
                        }
                    }
                } else if (type === 2) {
                    if (currentNodeChecked) {
                        $(".top_" + parentId + "").prop({checked: true});
                    } else {
                        let permissions = role.findChildrenNode(t, "per_");
                        for (let i = 0; i < permissions.length; ++i) {
                            $(permissions[i]).prop({checked: false});
                        }
                    }
                } else if (type === 3) {
                    if (currentNodeChecked) {
                        $(".currentId_" + parentId + "").prop({checked: true});
                    }
                }
            },
            findChildrenNode: function (t, type) {
                let currentId = $(t).val();
                return $("." + type + currentId + "");
            },
            changePermissionToTree: function (data) {
                let nodesStr = "[";
                data.forEach(node => {
                    let children = node.children;
                    let checked = node.has === true ? "checked" : "";
                    nodesStr += `{"spread":true,`;
                    nodesStr += `"id":` + node.id + `,`;
                    nodesStr += `"name":"<input value=` + node.id + ` type='checkbox' class='per top_` + node.id + `' ` + checked + `  onclick='role.check(this,1,null)' name='id'   style='position: absolute;' lay-skin='primary'><span style='margin-left: 20px'>` + node.name + '</span>"';
                    if (children.length === 0) {
                        nodesStr += "},"
                    } else {
                        nodesStr += ',"children":[';
                        children.forEach(sideNode => {
                            let permission = sideNode.children;
                            let checked = sideNode.has === true ? "checked" : "";
                            nodesStr += `{"spread":true,`;
                            nodesStr += `"id":` + node.id + `,`;
                            nodesStr += `"name":"<input value=` + sideNode.id + ` type='checkbox' class='currentId_` + sideNode.id + ` per side_` + node.id + `'` + checked + `  onclick='role.check(this,2,` + node.id + `)' name='id'   style='position: absolute;' lay-skin='primary'><span style='margin-left: 20px'>` + sideNode.name + "</span>";
                            if (permission.length === 0) {
                                nodesStr += '"},';
                            } else {
                                permission.forEach(per => {
                                    let checked = per.has === true ? "checked" : "";
                                    nodesStr += "<input value=" + per.id + " type='checkbox' class='topId_`+node.id+` per per_" + sideNode.id + "' id='a3' " + checked + " name='id' onclick='role.check(this,3," + sideNode.id + ")' style='position: absolute;margin-left: 5px' lay-skin='primary'>";
                                    nodesStr += "<span style='margin-left: 25px'>" + per.name + "</span>";
                                })
                                nodesStr += '"},';
                            }
                        })
                        nodesStr = nodesStr.substr(0, nodesStr.length - 1) + "]},";
                    }
                })
                nodesStr = nodesStr.substr(0, nodesStr.length - 1) + "]";
                return JSON.parse(nodesStr);
            },
            updateAvailable(t, roleId){
                alert($(t).prop("checked"));
            }
        }
        $(function () {
            role.list();

            form.on('submit(role-add)', function (data) {
                $.ajax({
                    url: baseUrl + "userRole/add",
                    type:"post",
                    data: $("#role-add").serialize(),
                    success: function (data) {
                        if (data.result) {
                            layer.msg(data.msg);
                            setTimeout("location.reload()", 1000);
                        }
                    }
                });

                return false;
            })
            form.on('switch(role-available)', function (data) {
                $.post(baseUrl + "/userRole/updateAvailable", {
                    available: data.elem.checked,
                    id: data.value
                }, function (data) {
                    layer.msg(data.msg);
                })
            });

        });
    });


</script>

</html>
