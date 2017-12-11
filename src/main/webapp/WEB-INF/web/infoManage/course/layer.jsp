<%@ page contentType="text/html; charset=UTF-8" %>
<script id="list-tpl" type="text/html">
    {{# layui.each(d.courses, function(index, item){ }}
    <tr>
        <td>{{ index+1}}</td>
        <td>
            {{# if(item.departmentName === undefined){ }}
            无
            {{# }else{ }}
            {{ item.departmentName}}
            {{#}}}
        </td>
        <td>
            {{# if(item.moduleName === undefined){ }}
            无
            {{# }else{ }}
            {{ item.moduleName}}
            {{#}}}
        </td>

        <td>{{ item.code}}</td>
        <td>{{ item.name}}</td>
        <td>{{ item.schoolScore}}</td>
        <td>{{ item.schoolHours}}</td>
        <td>{{ item.semester}}</td>
        <td>{{ item.nature}}</td>

        <td> {{# if(item.method === undefined){ }}
            无
            {{# }else{ }}
            {{ item.method}}
            {{#}}}
        </td>
        <td>
            <button class="layui-btn layui-btn-mini " style="background: #21a1a1"
                    onclick="course.update('{{item.id}}','{{item.code}}','{{item.name}}','{{item.methodId}}',
                                        '{{item.moduleId}}','{{item.schoolScore}}','{{item.schoolHours}}','{{item.semester}}','{{item.nature}}','{{item.departmentId}}')">
                <i class="layui-icon">&#xe642;</i> 修改
            </button>
            <button class="layui-btn layui-btn-mini  layui-btn-danger" onclick="course.delete('{{item.id}}')">
                <i class="layui-icon">&#xe60a;</i> 删除
            </button>
        </td>
    </tr>
    {{# }); }}

</script>
<div id="add" style="margin: 10px;display: none">
    <form id="add-form" class="layui-form layui-form-pane" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">课程归属</label>
            <div class="layui-input-inline">
                <select id="add-department" name="departmentId">
                    <option value="">课程归属</option>
                </select>
            </div>
            <label class="layui-form-label">课程代码</label>
            <div class="layui-input-inline">
                <input type="text" name="code"
                       placeholder="请输入课程代码" id="add-code" autocomplete="off" class="layui-input ">
            </div>
            <label class="layui-form-label">课程名称</label>
            <div class="layui-input-inline">
                <input type="text" name="name"
                       placeholder="请输入课程名称" id="add-name" autocomplete="off" class="layui-input ">
            </div>

        </div>
        <div class="layui-form-item">
            <label class="layui-form-label">课程学分</label>
            <div class="layui-input-inline">
                <input type="text" name="schoolScore"
                       placeholder="请输入课程学分" id="add-schoolScore" autocomplete="off" class="layui-input ">
            </div>
            <label class="layui-form-label">课程学时</label>
            <div class="layui-input-inline">
                <input type="text" name="schoolHours"
                       placeholder="请输入课程学时" id="add-schoolHours" autocomplete="off" class="layui-input ">
            </div>
            <label class="layui-form-label">开课学期</label>
            <div class="layui-input-inline">
                <select id="add-semester" name="semester">
                    <option value="1">1</option>
                    <option value="2">2</option>
                    <option value="3">3</option>
                    <option value="4">4</option>
                    <option value="5">5</option>
                    <option value="6">6</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">课程性质</label>
            <div class="layui-input-inline">
                <select id="add-nature" name="nature">
                    <option value="必修">必修</option>
                    <option value="选修">选修</option>
                </select>
            </div>
            <label class="layui-form-label">考核方式</label>
            <div class="layui-input-inline">
                <select id="add-method" name="method">
                    <option value="笔试">笔试</option>
                </select>
            </div>
            <label class="layui-form-label">模块</label>
            <div class="layui-input-inline">
                <select id="add-module" name="moduleId">
                    <option value="0">请选择</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item" style="margin-top: 30px">
            <div class="layui-input-block">
                <a class="layui-btn" onclick="course.addAjax()">立即添加</a>
            </div>
        </div>
    </form>
</div>
<div id="update" style="margin: 10px;display: none">
    <form id="update-form" class="layui-form layui-form-pane" method="post">
        <input type="hidden" name="id" id="id">

        <div class="layui-form-item">
            <label class="layui-form-label">课程归属</label>
            <div class="layui-input-inline">
                <select id="update-department" name="departmentId">
                    <option value="">课程归属</option>
                </select>
            </div>
            <label class="layui-form-label">课程代码</label>
            <div class="layui-input-inline">
                <input type="text" name="code"
                       placeholder="请输入课程代码" id="update-code" autocomplete="off" class="layui-input ">
            </div>
            <label class="layui-form-label">课程名称</label>
            <div class="layui-input-inline">
                <input type="text" name="name"
                       placeholder="请输入课程名称" id="update-name" autocomplete="off" class="layui-input ">
            </div>

        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">课程学分</label>
            <div class="layui-input-inline">
                <input type="number" name="schoolScore"
                       placeholder="请输入课程学分" id="update-schoolScore" autocomplete="off" class="layui-input ">
            </div>
            <label class="layui-form-label">课程学时</label>
            <div class="layui-input-inline">
                <input type="number" name="schoolHours"
                       placeholder="请输入课程学时" id="update-schoolHours" autocomplete="off" class="layui-input ">
            </div>
            <label class="layui-form-label">开课学期</label>
            <div class="layui-input-inline">
                <select id="update-semester" name="semester">
                    <option value="0">请选择</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item">
            <label class="layui-form-label">课程性质</label>
            <div class="layui-input-inline">
                <select id="update-nature" name="nature">
                    <option class="natures" value="选修">选修</option>
                    <option value="必修" class="natures">必修</option>
                </select>
            </div>
            <label class="layui-form-label">考核方式</label>
            <div class="layui-input-inline">
                <select id="update-method" name="method">
                    <option value="0">请选择</option>
                </select>
            </div>
            <label class="layui-form-label">模块</label>
            <div class="layui-input-inline">
                <select id="update-module" name="moduleId">
                    <option value="0">请选择</option>
                </select>
            </div>
        </div>

        <div class="layui-form-item" style="margin-top: 30px">
            <div class="layui-input-block">
                <a class="layui-btn" onclick="course.updateAjax()">立即修改</a>
            </div>
        </div>
    </form>
</div>

<div id="upload" style="display: none">
    <form id="upload-form" class="layui-form layui-form-pane" method="post" enctype="multipart/form-data"
          style="padding: 20% 20%">
        <div class="layui-form-item">
            <input type="file" name="file" lay-ext="xls|xlsx" lay-type="file" lay-title="请选择Excel文件"
                   class=" layui-upload-file ">
        </div>
        <%--<a class="layui-form-mid layui-word-aux">只支持 excel 2003 ，后缀为 .xls 的文件</a>--%>
    </form>
</div>

