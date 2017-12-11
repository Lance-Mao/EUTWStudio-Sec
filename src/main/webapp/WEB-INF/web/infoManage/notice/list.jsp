<%@ page contentType="text/html; charset=UTF-8" %>
<%@ include file="../../../public/tag.jsp" %>
<html>
<head>
    <title></title>
    <script type="text/javascript" src="${baseurl}/public/common/js/jquery-3.2.0.min.js"></script>
    <script src="${baseurl}/public/common/layui/layui.js" charset="utf-8"></script>
    <script src="${baseurl}/js/separator.js" charset="utf-8"></script>
    <link rel="stylesheet" href="${baseurl}/public/common/layui/css/layui.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/layui/css/layui.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/bootstrap/css/bootstrap.min.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/common/css/global.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/css/common.css" media="all">
    <link rel="stylesheet" type="text/css" href="${baseurl}/public/css/personal.css" media="all">
    <script type="text/javascript" src="${baseurl}/js/searchJs.js"></script>

</head>
<body style=" background: #fff;">
<section class=" layui-form">
    <div class="larry-personal" style="width: 95% ">
        <form>
        <div class="layui-tab" >
                <fieldset class="layui-elem-field layui-field-title" style="margin-top: 50px;">
                    <legend>发布公告</legend>
                </fieldset>
            <div class="layui-form-item">

                <div class="layui-input-block"style="    margin-left: 0px;">
                    <input type="text" id = "title" name="title" lay-verify="title" autocomplete="off" placeholder="请输入标题" class="layui-input">
                </div>
            </div>
                <textarea class="layui-textarea" id="LAY_demo1"  style="display: none">
                </textarea>

                <div class="site-demo-button" style="margin-top: 20px;">
                    <p class="layui-btn site-demo-layedit" data-type="content">发布</p>
                </div>

        </div>
        </form>
    </div>
</section>

</body>
<script type="text/javascript" src="${baseurl}/public/common/layui/layui.js"></script>
<script type="text/javascript">
    layui.use(['jquery', 'layer', 'element', 'laypage', 'form', 'laytpl', 'tree'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;
        var element = layui.element(),
            form = layui.form(),
            laytpl = layui.laytpl;

        notice = {
            add: function (title, content) {
                var date = new Date();
                var year = date.getFullYear();
                var month = date.getMonth()+1;
                var day = date.getDate();
                var hour = date.getHours();
                var minute = date.getMinutes();
                var second = date.getSeconds();
                let time = year+'年'+month+'月'+day+'日 '+hour+':'+minute+':'+second
                $.post(baseUrl + "/notice/add", {
                    name: "<shiro:principal property="name"/>",
                    title:title,
                    content:content,
                    time:time
                    }, function (data) {
                    layer.msg(data.msg);
                    if (data.msg) {
                        setTimeout("location.reload()", 1000);
                    }
                })
            }
        }
        $(function () {

        });
    });
</script>
<script>
    layui.use('layedit', function(){
        var layedit = layui.layedit
            ,$ = layui.jquery;

        //构建一个默认的编辑器
        var index = layedit.build('LAY_demo1',{
        tool: [
            'strong' //加粗
            ,'italic' //斜体
            ,'underline' //下划线
            ,'del' //删除线

            ,'|' //分割线

            ,'left' //左对齐
            ,'center' //居中对齐
            ,'right' //右对齐
            ,'link' //超链接
            ,'unlink' //清除链接
            ,'face' //表情
        ]
        });

        //编辑器外部操作
        var active = {
            content: function(){
                var content = layedit.getContent(index);
                notice.add($("#title").val(), content);
            }
        };

        $('.site-demo-layedit').on('click', function(){
            var type = $(this).data('type');
            active[type] ? active[type].call(this) : '';
        });

    });
</script>

<script>
    layui.use(['form', 'layedit', 'laydate'], function () {
        var form = layui.form()
            , layer = layui.layer
            , layedit = layui.layedit
            , laydate = layui.laydate;

        //创建一个编辑器
        var editIndex = layedit.build('LAY_demo_editor');

        //自定义验证规则
        form.verify({
            title: function (value) {
                if (value.length < 5) {
                    return '标题至少得5个字符啊';
                }
            }
            , pass: [/(.+){6,12}$/, '密码必须6到12位']
            , content: function (value) {
                layedit.sync(editIndex);
            }
        });

    });
</script>

</html>
