<%@ page contentType="text/html; charset=UTF-8" %>

<style>
    #dataView span {
        width: 150px;
        border: 1px solid #c7c7c7;
    }

    .layui-form-checkbox {
        margin-bottom: 10px;
    }
</style>

<div class="layui-form" id="dataView" style="display: none;margin-left: 100px">
    <form class="layui-form">
        <br>
        <h3>基本信息</h3>
        <div id="baseInfo">
            <input type="checkbox" value="学号" name="no" title="学号">
            <input type="checkbox" value="姓名" name="name" title="姓名">
            <input type="checkbox" value="性别" name="gender" title="性别">
            <input type="checkbox" value="名族" name="famousFamily" title="名族">
            <input type="checkbox" value="身份证号" name="idcard" title="身份证号">
            <input type="checkbox" value="出生日期" name="born" title="出生日期">
            <input type="checkbox" value="入学前文化程度" name="pre_school_education" title="入学前文化程度">
            <input type="checkbox" value="婚否" name="is_marry" title="婚否">
            <input type="checkbox" value="生源类别" name="student_classify" title="生源类别">
            <input type="checkbox" value="邮政编码" name="family_zip_code" title="邮政编码">
            <input type="checkbox" value="户口是否转入" name="account_in" title="户口是否转入">
            <input type="checkbox" value="城乡生源名称" name="area_origin_name" title="城乡生源名称">
            <input type="checkbox" value="档案是否转入" name="file_in" title="档案是否转入">
            <input type="checkbox" value="入学前学校名称或工作单位" name="pre_school_name" title="入学前学校名称或工作单位">
            <input type="checkbox" value="紧急联系人" name="emergency_contact_name" title="紧急联系人">
            <input type="checkbox" value="联系方式" name="emergency_contact_method" title="联系方式">
            <input type="checkbox" value="入学前党派或团体组织" name="partyOrGroupOrganizationText"
                   title="入学前党派或团体组织">
            <input type="checkbox" value="入学前受过何奖励或处分" name="Pre_admissionOrRewardText"
                   title="入学前受过何奖励或处分">
            <input type="checkbox" value="籍贯" name="native_place" title="籍贯">
            <input type="checkbox" value="生源地所在名称" name="origin_address" title="生源地所在名称">
            <input type="checkbox" value="入学前档案所在单位" name="pre_school_file_where_location"
                   title="入学前档案所在单位">
            <input type="checkbox" value="入学前户口所在派出所" name="pre_school_account_where_station"
                   title="入学前户口所在派出所">
            <input type="checkbox" value="身份证地址" name="idcard_address" title="身份证地址">
            <input type="checkbox" value="家庭实际住址" name="actual_address" title="家庭实际住址">
            <input type="checkbox" value="手机号" name="student_contact_method" title="手机号">
            <input type="checkbox" value="QQ" name="qq" title="QQ">
            <input type="checkbox" value="邮箱" name="email" title="邮箱">
            <div onclick="dataOutput.selectAll(this)" style="float: right;">
                <input type="checkbox" value="全选" name="baseInfo" title="全选">
            </div>
        </div>
        <h3>学业状态</h3>
        <div id="academicStatus">
            <input type="checkbox" value="职业导师" name="teacher_id" title="职业导师">
            <input type="checkbox" value="学籍状态" name="student_status" title="学籍状态">
            <input type="checkbox" value="学生类型" name="student_type" title="学生类型">
            <input type="checkbox" value="高考成绩" name="sat_score" title="高考成绩">
            <input type="checkbox" value="录取专业" name="profession_id" title="录取专业">
            <input type="checkbox" value="系" name="department_id" title="系">
            <input type="checkbox" value="现专业" name="origin_profession_id" title="现专业">
            <input type="checkbox" value="就业方向" name="direction_id" title="就业方向">
            <input type="checkbox" value="班级" name="classes_id" title="班级">
            <input type="checkbox" value="组别" name="group" title="组别">
            <input type="checkbox" value="第一年缴费状态" name="payment_status_first_year" title="第一年缴费状态">
            <input type="checkbox" value="第二年缴费状态" name="payment_status_second_year" title="第二年缴费状态">
            <input type="checkbox" value="第三年缴费状态" name="payment_status_third_year" title="第三年缴费状态">
            <input type="checkbox" value="第四年缴费状态" name="payment_status_forth_year" title="第四年缴费状态">
            <input type="checkbox" value="第五年缴费状态" name="payment_status_fifth_year" title="第五年缴费状态">
            <input type="checkbox" value="第六年缴费状态" name="payment_status_sixth_year" title="第六年缴费状态">
            <input type="checkbox" value="实践类型" name="practice_learning_type" title="实践类型">
            <input type="checkbox" value="单位或项目" name="practice_learning_type" title="单位或项目">
            <input type="checkbox" value="联系人" name="units_or_projects_practical_type_contact" title="联系人">
            <input type="checkbox" value="联系人电话" name="units_or_projects_practical_type_contact_phone" title="联系人电话">
            <div onclick="dataOutput.selectAll(this)" style="float: right;">
                <input type="checkbox" value="全选" name="baseInfo" title="全选">
            </div>
        </div>

        <h3>社区管理</h3>
        <div id="communityManagement">
            <input type="checkbox" value="社区辅导员" name="community_teacher_id" title="社区辅导员">
            <input type="checkbox" value="政治面貌" name="political_status" title="政治面貌">
            <input type="checkbox" value="身高" name="height" title="身高">
            <input type="checkbox" value="体重" name="weight" title="体重">
            <input type="checkbox" value="血型" name="blood" title="血型">
            <input type="checkbox" value="健康状况" name="health_status" title="健康状况">
            <input type="checkbox" value="宗教信仰" name="religionText" title="宗教信仰">
            <input type="checkbox" value="华侨" name="is_out" title="华侨、港澳台">
            <input type="checkbox" value="第一年医保时间" name="first_time_medical_insurance" title="第一年医保时间">
            <input type="checkbox" value="第一年医保" name="first_medical_insurance1" title="第一年医保">
            <input type="checkbox" value="第二年医保时间" name="second_time_medical_insurance" title="第二年医保时间">
            <input type="checkbox" value="第二年医保" name="second_medical_insurance1" title="第二年医保">
            <input type="checkbox" value="第三年医保时间" name="third_time_medical_insurance" title="第三年医保时间">
            <input type="checkbox" value="第三年医保" name="third_medical_insurance1" title="第三年医保">
            <input type="checkbox" value="住宿类型" name="stay_type" title="住宿类型">
            <input type="checkbox" value="宿舍信息" name="write" title="宿舍信息">
            <input type="checkbox" value="校外住址信息" name="off_school_stay_address" title="校外住址信息">
            <input type="checkbox" value="联系人" name="updateOffCampusContactName" title="联系人">
            <input type="checkbox" value="联系电话" name="updateOffCampusContactPhone" title="联系电话">
            <div onclick="dataOutput.selectAll(this)" style="float: right;">
                <input type="checkbox" value="全选" name="baseInfo" title="全选">
            </div>
        </div>
        <div class="layui-form-item">
            <div class="layui-input-block" style="margin-left: 0">
                <a class="layui-btn" onclick="dataOutput.submitData(searchData)" id="submitData">导出Excel</a>
                <button type="reset" class="layui-btn layui-btn-primary">重置</button>
            </div>
        </div>
    </form>
</div>

<script>
    let searchData;
    let studentDate;
    layui.use(['jquery', 'layer', 'element', 'laypage', 'form', 'laytpl', 'tree'], function () {
        window.jQuery = window.$ = layui.jquery;
        window.layer = layui.layer;
        let element = layui.element(),
            form = layui.form(),
            laytpl = layui.laytpl;

        dataOutput = {
            showDataOutput: function (data) {
                searchData = data;
                layer.open({
                    type: 1,
                    title: "数据导出",
                    area: ["100%", "100%"],
                    content: $("#dataView")
                })
            },
            submitData: function (dataSearchInfo) {
                let no = $("input[name='no']:checked").val() + "--" + $("input[name='no']:checked").prop("name");
                let name = $("input[name='name']:checked").val() + "--" + $("input[name='name']:checked").prop("name");
                let gender = $("input[name='gender']:checked").val() + "--" + $("input[name='gender']:checked").prop("name");
                let famousFamily = $("input[name='famousFamily']:checked").val() + "--" + $("input[name='famousFamily']:checked").prop("name");
                let idcard = $("input[name='idcard']:checked").val() + "--" + $("input[name='idcard']:checked").prop("name");
                let born = $("input[name='born']:checked").val() + "--" + $("input[name='born']:checked").prop("name");
                let pre_school_education = $("input[name='pre_school_education']:checked").val() + "--" + $("input[name='pre_school_education']:checked").prop("name");
                let is_marry = $("input[name='is_marry']:checked").val() + "--" + $("input[name='is_marry']:checked").prop("name");
                let student_classify = $("input[name='student_classify']:checked").val() + "--" + $("input[name='student_classify']:checked").prop("name");
                let family_zip_code = $("input[name='family_zip_code']:checked").val() + "--" + $("input[name='family_zip_code']:checked").prop("name");
                let account_in = $("input[name='account_in']:checked").val() + "--" + $("input[name='account_in']:checked").prop("name");
                let area_origin_name = $("input[name='area_origin_name']:checked").val() + "--" + $("input[name='area_origin_name']:checked").prop("name");
                let file_in = $("input[name='file_in']:checked").val() + "--" + $("input[name='file_in']:checked").prop("name");
                let pre_school_name = $("input[name='pre_school_name']:checked").val() + "--" + $("input[name='pre_school_name']:checked").prop("name");
                let emergency_contact_name = $("input[name='emergency_contact_name']:checked").val() + "--" + $("input[name='emergency_contact_name']:checked").prop("name");
                let emergency_contact_method = $("input[name='emergency_contact_method']:checked").val() + "--" + $("input[name='emergency_contact_method']:checked").prop("name");
                let partyOrGroupOrganizationText = $("input[name='partyOrGroupOrganizationText']:checked").val() + "--" + $("input[name='partyOrGroupOrganizationText']:checked").prop("name");
                let Pre_admissionOrRewardText = $("input[name='Pre_admissionOrRewardText']:checked").val() + "--" + $("input[name='Pre_admissionOrRewardText']:checked").prop("name");
                let native_place = $("input[name='native_place']:checked").val() + "--" + $("input[name='native_place']:checked").prop("name");
                let origin_address = $("input[name='origin_address']:checked").val() + "--" + $("input[name='origin_address']:checked").prop("name");
                let pre_school_file_where_location = $("input[name='pre_school_file_where_location']:checked").val() + "--" + $("input[name='pre_school_file_where_location']:checked").prop("name");
                let pre_school_account_where_station = $("input[name='pre_school_account_where_station']:checked").val() + "--" + $("input[name='pre_school_account_where_station']:checked").prop("name");
                let idcard_address = $("input[name='idcard_address']:checked").val() + "--" + $("input[name='idcard_address']:checked").prop("name");
                let actual_address = $("input[name='actual_address']:checked").val() + "--" + $("input[name='actual_address']:checked").prop("name");
                let student_contact_method = $("input[name='student_contact_method']:checked").val() + "--" + $("input[name='student_contact_method']:checked").prop("name");
                let qq = $("input[name='qq']:checked").val() + "--" + $("input[name='qq']:checked").prop("name");
                let email = $("input[name='email']:checked").val() + "--" + $("input[name='email']:checked").prop("name");
                let teacherId = $("input[name='teacher_id']:checked").val() + "--" + $("input[name='teacher_id']:checked").prop("name");
                let student_status = $("input[name='student_status']:checked").val() + "--" + $("input[name='student_status']:checked").prop("name");
                let student_type = $("input[name='student_type']:checked").val() + "--" + $("input[name='student_type']:checked").prop("name");
                let sat_score = $("input[name='sat_score']:checked").val() + "--" + $("input[name='sat_score']:checked").prop("name");
                let profession_id = $("input[name='profession_id']:checked").val() + "--" + $("input[name='profession_id']:checked").prop("name");
                let department_id = $("input[name='department_id']:checked").val() + "--" + $("input[name='department_id']:checked").prop("name");
                let origin_profession_id = $("input[name='origin_profession_id']:checked").val() + "--" + $("input[name='origin_profession_id']:checked").prop("name");
                let direction_id = $("input[name='direction_id']:checked").val() + "--" + $("input[name='direction_id']:checked").prop("name");
                let classes_id = $("input[name='classes_id']:checked").val() + "--" + $("input[name='classes_id']:checked").prop("name");
                let group = $("input[name='group']:checked").val() + "--" + $("input[name='group']:checked").prop("name");
                let payment_status_first_year = $("input[name='payment_status_first_year']:checked").val() + "--" + $("input[name='payment_status_first_year']:checked").prop("name");
                let payment_status_second_year = $("input[name='payment_status_second_year']:checked").val() + "--" + $("input[name='payment_status_second_year']:checked").prop("name");
                let payment_status_third_year = $("input[name='payment_status_third_year']:checked").val() + "--" + $("input[name='payment_status_third_year']:checked").prop("name");
                let payment_status_forth_year = $("input[name='payment_status_forth_year']:checked").val() + "--" + $("input[name='payment_status_forth_year']:checked").prop("name");
                let payment_status_fifth_year = $("input[name='payment_status_fifth_year']:checked").val() + "--" + $("input[name='payment_status_fifth_year']:checked").prop("name");
                let payment_status_sixth_year = $("input[name='payment_status_sixth_year']:checked").val() + "--" + $("input[name='payment_status_sixth_year']:checked").prop("name");
                let practice_learning_type = $("input[name='practice_learning_type']:checked").val() + "--" + $("input[name='practice_learning_type']:checked").prop("name");
                let units_or_projects_practical_type_contact = $("input[name='units_or_projects_practical_type_contact']:checked").val() + "--" + $("input[name='units_or_projects_practical_type_contact']:checked").prop("name");
                let units_or_projects_practical_type_contact_phone = $("input[name='units_or_projects_practical_type_contact_phone']:checked").val() + "--" + $("input[name='units_or_projects_practical_type_contact_phone']:checked").prop("name");
                let community_teacher_id = $("input[name='community_teacher_id']:checked").val() + "--" + $("input[name='community_teacher_id']:checked").prop("name");
                let political_status = $("input[name='political_status']:checked").val() + "--" + $("input[name='political_status']:checked").prop("name");
                let height = $("input[name='height']:checked").val() + "--" + $("input[name='height']:checked").prop("name");
                let weight = $("input[name='weight']:checked").val() + "--" + $("input[name='weight']:checked").prop("name");
                let blood = $("input[name='blood']:checked").val() + "--" + $("input[name='blood']:checked").prop("name");
                let health_status = $("input[name='health_status']:checked").val() + "--" + $("input[name='health_status']:checked").prop("name");
                let religionText = $("input[name='religionText']:checked").val() + "--" + $("input[name='religionText']:checked").prop("name");
                let is_out = $("input[name='is_out']:checked").val() + "--" + $("input[name='is_out']:checked").prop("name");
                let first_time_medical_insurance = $("input[name='first_time_medical_insurance']:checked").val() + "--" + $("input[name='first_time_medical_insurance']:checked").prop("name");
                let first_medical_insurance1 = $("input[name='first_medical_insurance1']:checked").val() + "--" + $("input[name='first_medical_insurance1']:checked").prop("name");
                let second_time_medical_insurance = $("input[name='second_time_medical_insurance']:checked").val() + "--" + $("input[name='second_time_medical_insurance']:checked").prop("name");
                let second_medical_insurance1 = $("input[name='second_medical_insurance1']:checked").val() + "--" + $("input[name='second_medical_insurance1']:checked").prop("name");
                let third_time_medical_insurance = $("input[name='third_time_medical_insurance']:checked").val() + "--" + $("input[name='third_time_medical_insurance']:checked").prop("name");
                let third_medical_insurance1 = $("input[name='third_medical_insurance1']:checked").val() + "--" + $("input[name='third_medical_insurance1']:checked").prop("name");
                let stay_type = $("input[name='stay_type']:checked").val() + "--" + $("input[name='stay_type']:checked").prop("name");
                let write = $("input[name='write']:checked").val() + "--" + $("input[name='write']:checked").prop("name");
                let off_school_stay_address = $("input[name='off_school_stay_address']:checked").val() + "--" + $("input[name='off_school_stay_address']:checked").prop("name");
                let updateOffCampusContactName = $("input[name='updateOffCampusContactName']:checked").val() + "--" + $("input[name='updateOffCampusContactName']:checked").prop("name");
                let updateOffCampusContactPhone = $("input[name='updateOffCampusContactPhone']:checked").val() + "--" + $("input[name='updateOffCampusContactPhone']:checked").prop("name");
                studentDate = {
                    no: no,
                    name: name,
                    gender: gender,
                    famousFamily: famousFamily,
                    idcard: idcard,
                    born: born,
                    pre_school_education: pre_school_education,
                    is_marry: is_marry,
                    student_classify: student_classify,
                    family_zip_code: family_zip_code,
                    account_in: account_in,
                    area_origin_name: area_origin_name,
                    file_in: file_in,
                    pre_school_name: pre_school_name,
                    emergency_contact_name: emergency_contact_name,
                    emergency_contact_method: emergency_contact_method,
                    partyOrGroupOrganizationText: partyOrGroupOrganizationText,
                    Pre_admissionOrRewardText: Pre_admissionOrRewardText,
                    native_place: native_place,
                    origin_address: origin_address,
                    pre_school_file_where_location: pre_school_file_where_location,
                    pre_school_account_where_station: pre_school_account_where_station,
                    idcard_address: idcard_address,
                    actual_address: actual_address,
                    student_contact_method:student_contact_method,
                    qq:qq,
                    email:email,
                    teacher_id: teacherId,
                    student_status: student_status,
                    student_type: student_type,
                    sat_score: sat_score,
                    profession_id: profession_id,
                    department_id: department_id,
                    origin_profession_id: origin_profession_id,
                    direction_id: direction_id,
                    classes_id: classes_id,
                    group: group,
                    payment_status_first_year: payment_status_first_year,
                    payment_status_second_year: payment_status_second_year,
                    payment_status_third_year: payment_status_third_year,
                    payment_status_forth_year: payment_status_forth_year,
                    payment_status_fifth_year: payment_status_fifth_year,
                    payment_status_sixth_year: payment_status_sixth_year,
                    practice_learning_type: practice_learning_type,
                    units_or_projects_practical_type_contact: units_or_projects_practical_type_contact,
                    units_or_projects_practical_type_contact_phone: units_or_projects_practical_type_contact_phone,
                    community_teacher_id: community_teacher_id,
                    political_status: political_status,
                    height: height,
                    weight: weight,
                    blood: blood,
                    health_status: health_status,
                    religionText: religionText,
                    is_out: is_out,
                    first_time_medical_insurance: first_time_medical_insurance,
                    first_medical_insurance: first_medical_insurance1,
                    second_time_medical_insurance: second_time_medical_insurance,
                    second_medical_insurance: second_medical_insurance1,
                    third_time_medical_insurance: third_time_medical_insurance,
                    third_medical_insurance: third_medical_insurance1,
                    stay_type: stay_type,
                    write: write,
                    off_school_stay_address: off_school_stay_address,
                    updateOffCampusContactName: updateOffCampusContactName,
                    updateOffCampusContactPhone: updateOffCampusContactPhone,
                }
                let data = Object.assign(studentDate, dataSearchInfo);
                location.href = baseUrl + "/dataOutput/list?" + JSON.stringify(data).replace(/:/g, "=").replace(/,/g, "&").replace(/{/g, "").replace(/}/g, "").replace(/"/g, "");
            },
            //信息全部选中
            selectAll: function (data) {
                if ($(data).find("input[name='baseInfo']:checked").val() !== undefined) {
                    $(data).parent().find("input[type='checkbox']").prop("checked", true);
                } else {
                    $(data).parent().find("input[type='checkbox']").prop("checked", false);
                }
                form.render();
            },
        }
    })
</script>

