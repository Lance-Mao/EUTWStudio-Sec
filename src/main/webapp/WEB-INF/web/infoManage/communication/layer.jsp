<%@ page contentType="text/html; charset=UTF-8" %>
<script id="list-tpl" type="text/html">
    {{# layui.each(d.student, function(index,item){ }}
    <tr>
        <td>
            {{# if(item.no === undefined){ }}
            无
            {{# }else{ }}
            {{ item.no}}
            {{#}}}
        </td>

        <td>
            {{# if(item.name === undefined){ }}
            无
            {{# }else{ }}
            {{ item.name}}
            {{#}}}
        </td>
        <td>
            {{# if(item.gender === undefined){ }}
            无
            {{# }else{ }}
            {{ item.gender === "F" ? "女" : "男"}}
            {{#}}}
        </td>
        <td>
            {{# if(item.department === undefined){ }}
            无
            {{# }else{ }}
            {{ item.department}}
            {{#}}}
        </td>
        <td>
            {{# if(item.level === undefined){ }}
            无
            {{# }else{ }}
            {{ item.level}}
            {{#}}}
        </td>
        <td>
            {{# if(item.profession === undefined){ }}
            无
            {{# }else{ }}
            {{ item.profession}}
            {{#}}}
        </td>
        <td>
            {{# if(item.direction === undefined){ }}
            无
            {{# }else{ }}
            {{ item.direction}}
            {{#}}}
        </td>
        //学籍状态
        <td>
            {{# if(item.student_status === undefined){ }}
            无
            {{# }else { }}
            {{item.student_status}}
            {{#}}}
        </td>

        <td>
            {{# if(item.classes === undefined){ }}
            无
            {{# }else{ }}
            {{ item.classes}}
            {{#}}}
        </td>

        <td>
            {{# if(item.teacher_name === undefined){ }}
            无
            {{# }else{ }}
            {{ item.teacher_name}}
            {{#}}}
        </td>

        <td>
            {{# if(item.community_teacher_name === undefined){ }}
            无
            {{# }else{ }}
            {{ item.community_teacher_name}}
            {{#}}}
        </td>

        <td style="width: 60px">
            {{# if(item.stay_type === "1"){ }}
            校内
            {{# }else{ }}
            {{item.stay_type === "2" ? "校外" : ""}}
            {{#}}}
        </td>

        <td>
            {{# if(item.stay_type !== "1" || item.area === undefined){ }}
            无
            {{# }else{ }}
            {{ item.area}}
            {{#}}}
        </td>

        <td>
            {{# if(item.stay_type !== "1" || item.floor === undefined){ }}
            无
            {{# }else{ }}
            {{ item.floor}}
            {{#}}}
        </td>

        <td>
            {{# if(item.stay_type !== "1"){ }}
            无
            {{# }else if(item.room == undefined){ }}
            无
            {{# }else{ }}
            {{ item.room}}
            {{#}}}
        </td>
        <td style="font-size: 12px">
            <shiro:hasPermission name="communication:add">
                <button class="layui-btn layui-btn-mini "
                        onclick="communication.add('{{item.no}}')">
                    添加反馈
                </button>
            </shiro:hasPermission>
            <shiro:hasPermission name="communication:update">
                <button class="layui-btn layui-btn-mini " style="background: #21a1a1;display: none"
                        onclick="communication.previewOrUpdate('{{ item.name}}','{{item.no}}','update')">
                    修改
                </button>
            </shiro:hasPermission>
            <shiro:hasPermission name="communication:preview">
                <button class="layui-btn layui-btn-mini  "
                        onclick="communication.previewOrUpdate('{{ item.name}}','{{item.no}}','preview')">
                    预览
                </button>
            </shiro:hasPermission>
        </td>
    </tr>
    {{# }); }}

</script>
<div id="add" style="display: none;width: auto;margin-top: 20px" class="layui-form">
    <form class="layui-form layui-form-pane" id="add_form" style="padding: 30px">
        <input type="hidden" name="no" class="no">
        <div class="layui-form-item layui-form-pane">

            <label class="layui-form-label " style="font-size: 13px">学生学号</label>
            <div class="layui-input-inline">
                <input name="no" disabled value="" autocomplete="off"
                       class="layui-input no">
            </div>
            <label class="layui-form-label layui-form-pane" style="font-size: 13px">学生姓名</label>
            <div class="layui-input-inline">
                <input id="studentName" disabled value="" autocomplete="off"
                       class="layui-input">
            </div>

        </div>

        <div class="layui-form-item layui-form-pane">
            <label class="layui-form-label " style="font-size: 13px">沟通项目</label>
            <div class="layui-input-inline">
                <select name="modules" id="direction" lay-verify="required" lay-search="">
                    <option value="学业指导">学业指导</option>
                    <option value="质量跟踪">质量跟踪</option>
                    <option value="生活服务">生活服务</option>
                    <option value="行为养成">行为养成</option>
                </select>
            </div>

            <label class="layui-form-label " style="font-size: 13px">沟通方式</label>
            <div class="layui-input-inline">
                <select name="modules" id="communicationMode" lay-verify="required" lay-search="">
                    <option value="面谈">面谈</option>
                    <option value="电话">电话</option>
                    <option value="QQ">QQ</option>
                    <option value="微信">微信</option>
                    <option value="书信">书信</option>
                </select>
            </div>

            <label class="layui-form-label " style="font-size: 13px">沟通对象</label>
            <div class="layui-input-inline">
                <input type="radio" name="name" id="student_radio" lay-filter="talk" value="student" title="学生" checked>
                <input type="radio" name="name" lay-filter="talk" value="parent" title="家长">
            </div>

            <label class="layui-form-label " style="font-size: 13px">电话</label>
            <div class="layui-input-inline">
                <div class="layui-input-inline">
                    <input type="tel" name="phone" lay-verify="phone" autocomplete="off" class="layui-input"
                           id="communicationPhone">
                </div>
            </div>
        </div>

        <div class="layui-form-item layui-form-pane">
            <label class="layui-form-label " style="font-size: 13px">沟通反馈记录</label>
        </div>

        <div id="content">
            <div class="layui-form-item content_node">

                <label class="layui-form-label " style="font-size: 13px">Q</label>
                <textarea placeholder="请输入问题" class="layui-textarea add-contents textarea"
                          style="width: 80%;min-height: 30px;height: 38px;font-size: 12px;margin-bottom: 5px"></textarea>
                <label class="layui-form-label " style="font-size: 13px">A</label>
                <textarea placeholder="请输入回答" class="layui-textarea add-contents textarea"
                          style="width: 80%;min-height: 50px;height: 70px;font-size: 12px;margin-left: .9%"></textarea>
                <div class="layui-btn-group">
                    <a onclick="addTalkContent()" class="layui-btn layui-btn-small"><i
                            class="layui-icon">&#xe608;</i>添加一条 Q&A</a>

                </div>
            </div>
        </div>
    </form>
    <a class="lay-submit layui-btn" onclick="communication.addAjax()" style="width: 115px;margin-left: 30px">立即提交</a>

</div>

<div id="update" style="display: none;background: #fff;">
    <a class="layui-btn" onclick="printPdf()" id="printPDF" style="float: right"><i class="layui-icon">&#xe630;</i>导出
        PDF</a>

    <div class="container" id="container" style="padding: 35px 15px 35px 60px;width: 55%">
        <div style="border: 1px solid #DBDBDB;height: 1100px;">
            <img style="width: 200px;height: 60px;margin: 30px 40px;" src="${baseurl}/images/public/logo_.png"/>
            <div style="margin-top: 400px;text-align: right;margin-right: 50px;line-height: normal">
                <span style="font-size: 22px;font-weight: bold">西安欧亚学院高职学院学生成长报告</span><br>
                <span style="font-weight: bold;margin-top: 20px;">
                    姓名：<span style="font-size: 12px" id="name"></span><br/>
                    性别：<span style="font-size: 12px" id="gender"></span><br/>
                    籍贯：<span style="font-size: 12px" id="native_place"></span><br/>
                    身份证号：<span style="font-size: 12px" id="idcard"></span><br>
                    专业：<span style="font-size: 12px" id="profession"></span><br/>
                    就业方向：<span style="font-size: 12px" id="direction2"></span><br/>
                    班级：<span style="font-size: 12px" id="political_status"></span><br/>
                </span>
            </div>
            <div style="height: 200px;margin-top: 40px;">
                <span style="float:left;display: block;width: 40%;height: 200px;background-color: #009688"></span>
                <span style="float:left;display: block;width: 18%;height: 200px;background-color: #33B8AD"></span>
                <span style="float:left;display: block;width: 18%;height: 200px;background-color: #2fd2c3"></span>
                <span style="float:left;display: block;width: 18%;height: 200px;text-align: center;font-weight: lighter"><span
                        style="font-size: 150px;color: grey;">></span></span>
                <span style="float:left;display: block;width: 6%;height: 200px;background-color: #4ED9C6"></span>
            </div>
        </div>
        <div id="communication_container" style="border: 1px solid #DBDBDB;margin: 30px 0;padding: 30px 30px;">
            <blockquote class="layui-elem-quote layui-quote-nm">
            <span style="display:inline-block;line-height:25px;font-size: 14px;font-weight: bold;">时间：2017-3-28 &nbsp;&nbsp;&nbsp;沟通老师：付老师 &nbsp;&nbsp;&nbsp; 沟通对象：吕俊杰
                <br>沟通项目：学业指导  &nbsp;&nbsp;&nbsp;沟通方式：面谈  &nbsp;&nbsp;&nbsp;电话：15682145362</span></blockquote>
            <div class="layui-form-item  content_node" style="margin-top: 10px;">
                <label class="layui-form-label " style="font-size: 13px">Q</label>
                <input class="layui-textarea add-contents textarea"
                       style="width: 80%;min-height: 30px;height: 38px;font-size: 12px;margin-bottom: 5px"/>
                <label class="layui-form-label " style="font-size: 13px">A</label>
                <input class="layui-textarea add-contents textarea"
                       style="width: 80%;min-height: 50px;height: 70px;font-size: 12px;margin-left: .9%"/>
            </div>

        </div>
    </div>

</div>
</div>

</div>

<script>
    layui.use(['jquery', 'layer', 'form'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;
        form = layui.form()
    });

    const content_html = `
    <div class="layui-form-item content_node">
    <label class="layui-form-label " style="font-size: 13px">Q</label>
                    <textarea placeholder="请输入问题" class="layui-textarea add-contents"
                              style="width: 80%;min-height: 30px;height: 38px;font-size: 12px;margin-bottom: 5px"></textarea>
                              <br>
                    <label class="layui-form-label " style="font-size: 13px">A</label>
                    <textarea placeholder="请输入回答" class="layui-textarea add-contents"
                              style="width: 80%;min-height: 50px;height: 70px;font-size: 12px;margin-left: .9%"></textarea>

                    <div class="layui-btn-group" >
                        <a onclick="addTalkContent()" class="layui-btn layui-btn-small"><i class="layui-icon">&#xe608;</i>添加一条 Q&A</a>
                          <a onclick="deleteContent(this)" class="layui-btn layui-btn-small layui-btn-danger"><i
                                class="layui-icon">&#xe640;</i>删除本条
                            Q&A
                        </a>
                    </div>

            </div>`;


    function addTalkContent() {
        $("#content").append(content_html);
    }

    function deleteContent(t) {
        layer.confirm('确定删除？', {icon: 3, title: '提示'}, function (index) {
            layer.close(index);
            $(t).parents(".content_node").remove();
            layer.msg("删除成功");
        })
    };


    function showCommunicationContent(data, type) {
        let communication = ""
        for (let i = 0; i < data.length - 1; ++i) {
            let com = data[i];
            communication += `<blockquote class="layui-elem-quote layui-quote-nm">
            <span style="display:inline-block;line-height:25px;font-size: 14px;font-weight: bold;">时间：` + com.time + ` &nbsp;&nbsp;&nbsp;沟通老师：` + com.teacherName + ` &nbsp;&nbsp;&nbsp; 沟通对象：` + com.talkName + `
                <br>沟通项目：` + com.direction + `  &nbsp;&nbsp;&nbsp;沟通方式：` + com.communicationMode + `  &nbsp;&nbsp;&nbsp;电话：` + com.communicationPhone + `</span></blockquote>
`;

            communication += loadPreviewQA(com.contents);

        }

        $("#communication_container").html(communication);
    }

    function loadEditQA(contents, id) {
        let QA = "";
        for (let index = 0; index < contents.length; index += 2) {
            let qaId = "q" + id + "a" + index;
            QA += `
             <dl class="timelineMinor" id="` + qaId + `">
                <dt id="` + index + `"><a style="font-size: 12px;color: peru">Q&A</a></dt>
                <div class="layui-btn-group" style="margin-bottom: 10px">
                    <a onclick="communication.updateContent(` + id + `,'` + id + `')" class="layui-btn layui-btn-small"><i
                            class="layui-icon">&#xe642;</i>修改 Q&A</a>
                </div>

                <dd class="timelineEvent" id="` + index + `EX" style="display:none;">
                     <textarea style="min-height: 30px;height: 38px;font-size: 12px;width: 500px;margin-bottom: 5px"
                               class="layui-textarea update-contents">` + contents[index] + `</textarea>
                    <textarea style="min-height: 50px;height: 70px;font-size: 12px;width: 500px"
                              class="layui-textarea update-contents">` + contents[index + 1] + `</textarea>
                    <br class="clear">
                </dd>
            </dl>
            `;
        }
        return QA;
    }

    function loadPreviewQA(contents) {
        let QA = "";
        let count = 1;
        for (let index = 0; index < contents.length; index += 2) {
            QA += ` <div class="layui-form-item  " style="margin-top: 10px;">
            <div style="line-height: 25px;">
                <div  style="font-size: 13px;width: 8%;float: left;font-weight: bold;text-align: right">Q` + (count) + `：</div>
                <div style="width: 90%;min-height: 20px;float: left;font-size: 12px;margin-bottom: 5px;">` + contents[index] + `<br></div>
            </div>
            <div style="line-height: 25px;">
                <div style="font-size: 13px;width: 8%;float: left;font-weight: bold;text-align: right">A` + (count++) + `：</div>
                <div   style="width: 90%;float: left;min-height: 20px;font-size: 12px;"> ` + contents[index + 1] + `</div>
            </div>
            </div>`;

        }
        return QA;
    }


</script>
