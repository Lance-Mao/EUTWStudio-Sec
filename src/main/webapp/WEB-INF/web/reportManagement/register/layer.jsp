<%@ page contentType="text/html; charset=UTF-8" %>
<script id="list-tpl" type="text/html">
    {{# layui.each(d.students, function(index, item){ }}
    <tr>

        <td> {{# if(item.departmentName === undefined){ }}
            无
            {{# }else{ }}
            {{ item.departmentName}}{{#}}}
        </td>
        <td>{{ item.level}}</td>
        <td>
            {{# if(item.directionName === undefined){ }}
            无
            {{# }else{ }}
            {{ item.directionName}}{{#}}}

        </td>
        <td>{{# if(item.classesName === undefined){ }}
            无
            {{# }else{ }}
            {{ item.classesName}}{{#}}}
        </td>
        <td>{{ item.no}}</td>
        <td>{{ item.studentName}}</td>
        <td>
            <%--<shiro:hasPermission name="communication:delete">--%>
            <button class="layui-btn layui-btn-mini  " onclick="resultReport.preview('{{ item.no}}')">
                <i class="layui-icon">&#xe60a;</i>查看入学登记表
            </button>
            <%--</shiro:hasPermission>--%>
        </td>
    </tr>
    {{# }); }}

</script>

<style>
    .layui-table td {
        line-height: 15px;
        border: 1px solid #000000;
    }
</style>

<div id="preview" style="display: none;width: auto;margin-top: 10px;text-align: center;padding: 2%">
    <button class="layui-btn " id="excel" style="float:right;" onclick="resultReport.exportRegisterReport()">
        <i class="layui-icon">&#xe61e;</i>导出 PDF
    </button>
    <h2 id="title">西安欧亚学院学生入学登记表</h2>
    <div id="head">
        <ul>
            <li>
                <label>分院：</label>
                <label style="text-decoration: underline">高职学院</label>
            </li>
            <li>
                <label>专业：</label>
                <label id="professionName" style="text-decoration: underline"></label>
            </li>
            <li>
                <label>班级：</label>
                <label id="classesName" style="text-decoration: underline"></label>
            </li>
            <li>
                <label>学号：</label>
                <label id="no" style="text-decoration: underline"></label>
            </li>
            <li>
                <label>入学时间：</label>
                <label id="in_school" style="text-decoration: underline"></label>
            </li>

        </ul>
    </div>
    <table class="layui-table">
        <tbody id="stu_info">
        <tr>
            <td style="width: 80px">姓名</td>
            <td class="studentName" style="width: 100px;"></td>

            <td>性别</td>
            <td id="gender"></td>

            <td>出生年月</td>
            <td id="born"></td>

            <td>民族</td>
            <td id="famous_family"></td>

            <td>婚否</td>
            <td width="170px" id="is_marry"></td>

            <td id="head_image1" width="100px" style="padding: 0" rowspan="4">
                <img id="head_image" src="${baseurl}/images/user/user.jpg"
                     width="100px"
                     height="150px"></td>
        </tr>
        <tr>
            <td>籍贯</td>
            <td colspan="2" id="origin_address"></td>

            <td>政治面貌</td>
            <td id="political_status"></td>

            <td>文化程度</td>
            <td id="pre_school_education">高中</td>

            <td>学生类别</td>
            <td colspan="2" id="student_classify">☐本科 ☐专升本 ☐专科</td>
        </tr>
        <tr>
            <td id="actual">家庭住址<br>(文书可达)</td>
            <td colspan="5" id="actual_address"></td>

            <td>邮编</td>
            <td id="family_zip_code"></td>

            <td>电话</td>
            <td id="family_phone"></td>
        </tr>
        <tr>
            <td colspan="2">来校前毕业学校或工作单位</td>
            <td colspan="2" id="pre_school_work"></td>

            <td>任何职务</td>
            <td id="pre_school_staff"></td>

            <td>健康状况</td>
            <td id="health_status"></td>

            <td>身份证号码</td>
            <td id="idcard"></td>

        </tr>
        <tr>
            <td colspan="4">何时何地经何人介绍加入何党派或团体组织</td>
            <td colspan="7" id="own_experience"></td>
        </tr>
        <tr>
            <td colspan="4">何时何地因何原因受过何奖励或处分</td>
            <td colspan="7" id="own_punishment"></td>
        </tr>

        <tr>
            <td colspan="11" style="text-align: center">本人学历及社会经历(从小学起)</td>
        </tr>

        <tr>
            <td colspan="2">自何年何月</td>
            <td colspan="2">至何年何月</td>
            <td colspan="6">在何地何校或和单位学习或工作</td>
            <td colspan="1">证明人</td>
        </tr>

        <tr id="experience">
            <td colspan="11" style="text-align: center">直系亲属或主要社会关系情况</td>
        </tr>
        <tr>
            <td colspan="1">称呼</td>
            <td colspan="1">姓名</td>
            <td colspan="1">政治面貌</td>
            <td colspan="1">职务</td>
            <td colspan="6">工作单位</td>
            <td colspan="1">联系电话</td>
        </tr>
        <tr id="family"></tr>

        </tbody>
    </table>
    <span style="float: left;margin-left: 50px;font-size: 14px;">本人承诺以上信息属实，因信息不实产生的一切法律责任由本人承担，与校方无关。</span>
    <span style="float: right ;font-size: 14px;margin-right: 50px;text-align: left">本人签名：<br>日期：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;年&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;月&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;日</span>
</div>
