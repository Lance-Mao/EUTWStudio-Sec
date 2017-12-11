<%@ page contentType="text/html; charset=UTF-8" %>
<script id="list-tpl" type="text/html">
    {{# layui.each(d.trainPrograms, function(index, item){ }}
    <tr>
        <td>{{ index+1}}</td>
        <td>{{ item.level}}</td>
        <td>{{ item.department}}</td>
        <td>{{ item.direction}}</td>
        <td>
            <shiro:hasPermission name="trainProgram:update">
                <button class="layui-btn layui-btn-mini " style="background: #21a1a1"
                        onclick="trainProgram.update('{{item.id}}','{{item.level}}','{{item.department}}','{{item.direction}}')">
                    <i class="layui-icon">&#xe642;</i>修改
                </button>
            </shiro:hasPermission>
            <shiro:hasPermission name="trainProgram:delete">
                <button class="layui-btn layui-btn-mini  layui-btn-danger" onclick="trainProgram.delete('{{item.id}}')">
                    <i class="layui-icon">&#xe640;</i>删除
                </button>
            </shiro:hasPermission>
            <shiro:hasPermission name="trainProgram:preview">
                <button class="layui-btn layui-btn-mini  layui-btn-danger"
                        onclick="trainProgram.preview('{{item.id}}','{{item.level}}','{{item.department}}','{{item.direction}}')">
                    <i class="layui-icon">&#xe60a;</i>预览
                </button>
            </shiro:hasPermission>
        </td>
    </tr>
    {{# }); }}

</script>
<div id="add" style="margin: 10px;display: none">
    <form id="add-form" lay-filter="role-add" class="layui-form layui-form-pane" method="post">
        <div class="layui-form-item">
            <label class="layui-form-label">级</label>
            <div class="layui-input-inline">
                <select id="level" name="level">
                    <option value="">请选择一个级</option>

                </select>
            </div>
            <label class="layui-form-label">所属系</label>
            <div class="layui-input-inline">
                <select id="department" name="departmentId" lay-filter="department">
                    <option value="">请选择一个系</option>

                </select>
            </div>
            <label class="layui-form-label">所属方向</label>
            <div class="layui-input-inline">
                <select id="direction" name="directionId" lay-verify="">
                    <option value="">请选择一个方向</option>

                </select>
            </div>
        </div>

        <label class="layui-form-label" style="margin-bottom: 20px">模块课程</label>
        <div id="modelCourses-add">

        </div>

        <div class="layui-form-item" style="margin-top: 30px">
            <div class="layui-input-block">
                <a class="layui-btn" onclick="trainProgram.addAjax()">立即提交</a>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>
<div id="update" style="margin: 10px;display: none">
    <form id="update-form" lay-filter="role-add" class="layui-form layui-form-pane" method="post">
        <input type="hidden" id="id" name="id"/>
        <div class="layui-form-item">
            <label class="layui-form-label">级</label>
            <div class="layui-input-inline">
                <input type="text" id="level-update" name="level" disabled
                       autocomplete="off" class="layui-input ">
            </div>
            <label class="layui-form-label">系</label>
            <div class="layui-input-inline">
                <input type="text" id="department-update" name="departmentId" disabled
                       autocomplete="off" class="layui-input ">
            </div>
            <label class="layui-form-label">专业方向</label>
            <div class="layui-input-inline">
                <input type="text" id="direction-update" name="directionId" disabled
                       autocomplete="off" class="layui-input ">
            </div>
        </div>
        <label class="layui-form-label" style="margin-bottom: 20px">模块课程</label>
        <div id="modelCourses-update">

        </div>
        <div class="layui-form-item">
            <div class="layui-input-block">
                <a class="layui-btn" onclick="trainProgram.updateAjax()">立即提交</a>
            </div>
        </div>
    </form>
</div>

<div id="preview" style="margin: 10px;display: none">
    <form id="preview-form" class="layui-form layui-form-pane" method="post">
        <fieldset class="layui-elem-field">
            <legend id="title-preview" style="font-size: 24px;font-weight: 700;padding: 10px 10%;text-align: center;">
                西安欧亚学院高职学院2017级物业方向人才培养方案
            </legend>
            <div class="layui-field-box">
                <div  style="margin: 3%  5%">

                    <table class="layui-table lay-even " data-name="articleCatData"
                           style="border: 0px solid red">
                        <colgroup>
                            <col width="100">
                            <col width="50">
                            <col width="100">
                            <col width="220">
                            <col width="100">
                            <col width="100">
                            <col width="100">
                            <col width="220">
                            <col width="100">
                            <col width="100">
                        </colgroup>
                        <tbody id="modelCourses-preview">

                        </tbody>
                    </table>

                </div>
            </div>
        </fieldset>
        <blockquote class="layui-elem-quote layui-quote-nm">
            必修：<span id="compulsoryScore">100</span>学分&nbsp;&nbsp;&nbsp;选修：<span id="electiveScore">8</span>学分&nbsp;&nbsp;&nbsp;总计：<span
                id="totalScore">108</span>学分
        </blockquote>

    </form>
</div>