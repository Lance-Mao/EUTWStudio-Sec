<%@ page contentType="text/html; charset=UTF-8" %>
<script type="text/javascript">
    function printPDF(data) {
        let studentInfo = data.student[0];
        let gender = "";
        let partyOrGroupOrganization = "";
        let Pre_admissionOrReward = "";
        if (studentInfo.gender == 'F') {
            gender = "女";
        } else if (studentInfo.gender == 'M') {
            gender = "男";
        }

        if (studentInfo.partyOrGroupOrganization === "无") {
            partyOrGroupOrganization = "无";
        } else {
            partyOrGroupOrganization = studentInfo.partyOrGroupOrganizationText;
        }
        if (studentInfo.Pre_admissionOrReward === "无") {
            Pre_admissionOrReward = "无";
        } else {
            Pre_admissionOrReward = studentInfo.Pre_admissionOrRewardText;
        }
        let fam = [];
        if (data.family.length !== 0) {
            for (let i = 0; i < data.family.length; i++) {
                if (data.family[i].political_status === "请选择") {
                    data.family[i].political_status = "";
                }
                fam.push([{
                    text: data.family[i].relationship + "：" + data.family[i].name,
                    fontSize: 8,
                    margin: [0, 10, 0, 10]
                },
                    {text: "职务：" + data.family[i].staff, fontSize: 8, margin: [0, 10, 0, 10]},
                    {text: "联系电话：" + data.family[i].phone, fontSize: 8, margin: [0, 10, 0, 10]}],);
                fam.push([{text: "政治面貌：" + data.family[i].political_status, fontSize: 8, margin: [0, 10, 0, 10]},
                    {text: "工作单位：" + data.family[i].work_place, fontSize: 8, margin: [0, 10, 0, 10], colSpan: 2}, {},]);
            }
        } else {
            fam.push([]);
        }
        let experience = [];
        if (data.experience.length !== 0) {
            for (var i = 0; i < data.experience.length; i++) {
                experience.push([{
                    text: "时间：" + data.experience[i].start_time + "——" + data.experience[i].end_time,
                    fontSize: 8,
                    margin: [0, 10, 0, 10]
                },
                    {text: "学校名称：" + data.experience[i].work_place, fontSize: 8, margin: [0, 10, 0, 10]},
                    {text: "担任职位：" + data.experience[i].staff, fontSize: 8, margin: [0, 10, 0, 10]}],);
            }
        } else {
            experience.push([]);
        }

        let payment_status_first_year = "";
        let payment_status_second_year = "";
        let payment_status_third_year = "";
        let payment_status_forth_year = "";
        let payment_status_fifth_year = "";
        let payment_status_sixth_year = "";

        if (studentInfo.payment_status_first_year === "欠费") {
            payment_status_first_year = "第一年：(" + (studentInfo.payment_status_first_year === undefined ? "" : studentInfo.payment_status_first_year) + "：" + (studentInfo.arrears_first_year === undefined ? "" : studentInfo.arrears_first_year) + "元)"
        } else {
            payment_status_first_year = "第一年：(" + (studentInfo.payment_status_first_year === undefined ? "" : studentInfo.payment_status_first_year) + ")"
        }

        if (studentInfo.payment_status_second_year === "欠费") {
            payment_status_second_year = "第一年：(" + (studentInfo.payment_status_second_year === undefined ? "" : studentInfo.payment_status_second_year) + "：" + (studentInfo.arrears_second_year === undefined ? "" : studentInfo.arrears_second_year) + "元)"
        } else {
            payment_status_second_year = "第一年：(" + (studentInfo.payment_status_second_year === undefined ? "" : studentInfo.payment_status_second_year) + ")"
        }
        if (studentInfo.payment_status_third_year === "欠费") {
            payment_status_third_year = "第一年：(" + (studentInfo.payment_status_third_year === undefined ? "" : studentInfo.payment_status_third_year) + "：" + (studentInfo.arrears_third_year === undefined ? "" : studentInfo.arrears_third_year) + "元)"
        } else {
            payment_status_third_year = "第一年：(" + (studentInfo.payment_status_third_year === undefined ? "" : studentInfo.payment_status_third_year) + ")"
        }
        if (studentInfo.payment_status_forth_year === "欠费") {
            payment_status_forth_year = "第一年：(" + (studentInfo.payment_status_forth_year === undefined ? "" : studentInfo.payment_status_forth_year) + "：" + (studentInfo.arrears_forth_year === undefined ? "" : studentInfo.arrears_forth_year) + "元)"
        } else {
            payment_status_forth_year = "第一年：(" + (studentInfo.payment_status_forth_year === undefined ? "" : studentInfo.payment_status_forth_year) + ")"
        }
        if (studentInfo.payment_status_fifth_year === "欠费") {
            payment_status_fifth_year = "第一年：(" + (studentInfo.payment_status_fifth_year === undefined ? "" : studentInfo.payment_status_fifth_year) + "：" + (studentInfo.arrears_fifth_year === undefined ? "" : studentInfo.arrears_fifth_year) + "元)"
        } else {
            payment_status_fifth_year = "第一年：(" + (studentInfo.payment_status_fifth_year === undefined ? "" : studentInfo.payment_status_fifth_year) + ")"
        }
        if (studentInfo.payment_status_sixth_year === "欠费") {
            payment_status_sixth_year = "第一年：(" + (studentInfo.payment_status_sixth_year === undefined ? "" : studentInfo.payment_status_sixth_year) + "：" + (studentInfo.arrears_sixth_year === undefined ? "" : studentInfo.arrears_sixth_year) + "元)"
        } else {
            payment_status_sixth_year = "第一年：(" + (studentInfo.payment_status_sixth_year === undefined ? "" : studentInfo.payment_status_sixth_year) + ")"
        }

        let stay_type = "";
        let DormitoryInformation = "";
        if (data.student[0].stay_type === "1") {
            stay_type = "校内";
            DormitoryInformation = "宿舍位置：" + data.student[0].area + "  " + data.student[0].floor + "   " + data.student[0].room + "房间";
        } else if (data.student[0].stay_type === "2") {
            stay_type = "校外";
            DormitoryInformation = "校外住址信息：" + data.student[0].off_school_stay_address + "    联系人：" + data.student[0].updateOffCampusContactName + "     联系人电话：" + data.student[0].updateOffCampusContactPhone;
        } else {
            stay_type = "暂无";
            DormitoryInformation = "住址信息：暂无";
        }


        let religion = "";
        if (data.student[0].religion === "无") {
            religion = "无";
        } else {
            religion = data.student[0].religionText;
        }
        let political_status = ""
        if (data.student[0].political_status === "请选择") {
            political_status = "暂无";
        } else {
            political_status = data.student[0].political_status;
        }

        let scholarship = [[{text: "年份", fontSize: 8, margin: [0, 10, 0, 10]},
            {text: "奖学金", fontSize: 8, margin: [0, 10, 0, 10]},
            {text: "助学金", fontSize: 8, margin: [0, 10, 0, 10]}],
        ];
        if (studentInfo.first_year !== undefined && studentInfo.first_year !== "") {
            scholarship.push([{text: studentInfo.first_year, fontSize: 8, margin: [0, 10, 0, 10]},
                {text: studentInfo.first_scholarship, fontSize: 8, margin: [0, 10, 0, 10]},
                {text: studentInfo.first_stipend, fontSize: 8, margin: [0, 10, 0, 10]}],
            );
        }
        if (studentInfo.second_year !== undefined && studentInfo.second_year !== "") {
            scholarship.push([{text: studentInfo.second_year, fontSize: 8, margin: [0, 10, 0, 10]},
                {text: studentInfo.second_scholarship, fontSize: 8, margin: [0, 10, 0, 10]},
                {text: studentInfo.second_stipend, fontSize: 8, margin: [0, 10, 0, 10]}],
            );
        }
        if (studentInfo.third_year !== undefined && studentInfo.third_year !== "") {
            scholarship.push([{text: studentInfo.third_year, fontSize: 8, margin: [0, 10, 0, 10]},
                {text: studentInfo.third_scholarship, fontSize: 8, margin: [0, 10, 0, 10]},
                {text: studentInfo.third_stipend, fontSize: 8, margin: [0, 10, 0, 10]}],
            );
        }
        let own_punishment = [];
        if (data.ownPunishment.length !== 0) {
            for (var i = 0; i < data.ownPunishment.length; i++) {
                own_punishment.push([{
                        text: data.ownPunishment[i].date + "   " + data.ownPunishment[i].centent,
                        fontSize: 8,
                        margin: [0, 10, 0, 10],
                        colSpan: 2
                    }, {},
                        {text: "证明人：" + data.ownPunishment[i].witness, fontSize: 8, margin: [0, 10, 0, 10]}],
                );
            }
        } else {
            own_punishment.push([]);
        }
        let disciplineAndPunishment = [[{text: "时间", fontSize: 8, margin: [0, 10, 0, 10]},
            {text: "类别", fontSize: 8, margin: [0, 10, 0, 10]},
            {text: "行为", fontSize: 8, margin: [0, 10, 0, 10]},
            {text: "级别", fontSize: 8, margin: [0, 10, 0, 10]},
            {text: "证明人", fontSize: 8, margin: [0, 10, 0, 10]},
            {text: "是否撤销", fontSize: 8, margin: [0, 10, 0, 10]}],
        ];
        if (data.disciplineAndPunishment.length !== 0) {
            for (var i = 0; i < data.disciplineAndPunishment.length; i++) {
                let revokeDiscipline = "";
                if (data.disciplineAndPunishment[i].revokeDiscipline === "none") {
                    revokeDiscipline = "已撤销";
                } else {
                    revokeDiscipline = "未撤销";
                }
                disciplineAndPunishment.push([{
                        text: data.disciplineAndPunishment[i].date,
                        fontSize: 8,
                        margin: [0, 10, 0, 10]
                    },
                        {text: data.disciplineAndPunishment[i].category, fontSize: 8, margin: [0, 10, 0, 10]},
                        {text: data.disciplineAndPunishment[i].behavior, fontSize: 8, margin: [0, 10, 0, 10]},
                        {text: data.disciplineAndPunishment[i].rank, fontSize: 8, margin: [0, 10, 0, 10]},
                        {text: data.disciplineAndPunishment[i].witness, fontSize: 8, margin: [0, 10, 0, 10]},
                        {text: revokeDiscipline, fontSize: 8, margin: [0, 10, 0, 10]}],
                );
            }
        } 
        let groupActivities = [[{text: "时间", fontSize: 8, margin: [0, 10, 0, 10]},
            {text: "类别", fontSize: 8, margin: [0, 10, 0, 10]},
            {text: "学时", fontSize: 8, margin: [0, 10, 0, 10]},
            {text: "名称	", fontSize: 8, margin: [0, 10, 0, 10]},
            {text: "证明人", fontSize: 8, margin: [0, 10, 0, 10]}],
        ];
        if (data.groupActivities.length !== 0) {
            for (var i = 0; i < data.groupActivities.length; i++) {
                groupActivities.push([{text: data.groupActivities[i].date, fontSize: 8, margin: [0, 10, 0, 10]},
                    {text: data.groupActivities[i].types, fontSize: 8, margin: [0, 10, 0, 10]},
                    {text: data.groupActivities[i].hours, fontSize: 8, margin: [0, 10, 0, 10]},
                    {text: data.groupActivities[i].heading, fontSize: 8, margin: [0, 10, 0, 10]},
                    {text: data.groupActivities[i].witness, fontSize: 8, margin: [0, 10, 0, 10]}])
            }
        }

        //图片格式转换
        var x = new ImageDataURL([HEAD_IMAGE_PREFIX + data.student[0].head_image]);
        x.oncomplete = function () {
            var imgs = new Array();
            for (key in this.imgdata) {
                if (this.imgdata[key] == this.emptyobj){
                    imgs.push({text:'请上传头像',fontSize: 10,rowSpan: 3});
                    continue;
                }//不存在的圖片直接忽略
                imgs.push({image:this.imgdata[key],fit: [80, 120], rowSpan: 3});//在的圖片直接忽略
            }

            var content = {
                content: [
                    {
                        text: "西安欧亚学院" + studentInfo.name + "学生档案",
                        fontSize: 22,
                        style: "subheader",
                        color: "#36B7AB",
                        alignment: "center"
                    },
                    {text: "基本信息", fontSize: 15, style: "subheader", color: "#36B7AB"},
                    {
                        style: "tableExample",
                        table: {
                            widths: [100, 60, 55, "*", "*", "*", 80],
                            body: [
                                [{
                                    text: "学号：" + (studentInfo.no === undefined ? "" : studentInfo.no),
                                    fontSize: 8,
                                    margin: [0, 13, 0, 13]
                                },
                                    {
                                        text: "姓名：" + (studentInfo.name === undefined ? "" : studentInfo.name),
                                        fontSize: 8,
                                        margin: [0, 13, 0, 13]
                                    },
                                    {
                                        text: "性别：" + (gender === undefined ? "" : gender),
                                        fontSize: 8,
                                        margin: [0, 11, 0, 11]
                                    },
                                    {
                                        text: "民族：" + (studentInfo.famousFamily === undefined ? "" : studentInfo.famousFamily),
                                        fontSize: 8,
                                        colSpan: 2,
                                        margin: [0, 11, 0, 11]
                                    }, {},
                                    {
                                        text: "婚否：" + (studentInfo.is_marry === undefined ? "" : studentInfo.is_marry),
                                        fontSize: 8,
                                        margin: [0, 11, 0, 11]
                                    },
                                    imgs[0]
                                ],
                                [{
                                    text: "身份证号：" + (studentInfo.idcard === undefined ? "" : studentInfo.idcard),
                                    fontSize: 8,
                                    colSpan: 2,
                                    margin: [0, 11, 0, 11]
                                }, {},
                                    {
                                        text: "出生日期：" + (studentInfo.born === undefined ? "" : studentInfo.born),
                                        fontSize: 8,
                                        colSpan: 2,
                                        margin: [0, 11, 0, 11]
                                    }, {},
                                    {
                                        text: "入学前文化程度：" + (studentInfo.pre_school_education === undefined ? "" : studentInfo.pre_school_education),
                                        fontSize: 8,
                                        colSpan: 2,
                                        margin: [0, 11, 0, 11]
                                    }, {}],
                                [{
                                    text: "邮箱：" + (studentInfo.email === undefined ? "" : studentInfo.email),
                                    fontSize: 8,
                                    colSpan: 2,
                                    margin: [0, 11, 0, 11]
                                }, {},
                                    {
                                        text: "联系方式：" + (studentInfo.student_contact_method === undefined ? "" : studentInfo.student_contact_method),
                                        fontSize: 8,
                                        colSpan: 2,
                                        margin: [0, 11, 0, 11]
                                    }, {},
                                    {
                                        text: "QQ：" + (studentInfo.qq === undefined ? "" : studentInfo.qq),
                                        fontSize: 8,
                                        colSpan: 2,
                                        margin: [0, 11, 0, 11]
                                    }, {}],
                                [{
                                    text: "籍贯：" + (studentInfo.native_place === undefined ? "" : studentInfo.native_place),
                                    fontSize: 8,
                                    colSpan: 3,
                                    margin: [0, 10, 0, 10]
                                }, {}, {},
                                    {
                                        text: "入学前学校名称或工作单位：" + (studentInfo.pre_school_name === undefined ? "" : studentInfo.pre_school_name),
                                        fontSize: 8,
                                        colSpan: 4,
                                        margin: [0, 10, 0, 10]
                                    }, {}, {}, {}],
                                [{
                                    text: "入学前党派或团体组织：" + (partyOrGroupOrganization === undefined ? "" : partyOrGroupOrganization),
                                    fontSize: 8,
                                    colSpan: 7,
                                    margin: [0, 10, 0, 10]
                                }],
                                [{
                                    text: "入学前受过何奖励或处分：" + (Pre_admissionOrReward === undefined ? "" : Pre_admissionOrReward),
                                    fontSize: 8,
                                    colSpan: 7,
                                    margin: [0, 10, 0, 10]
                                }],
                                [{
                                    text: "档案是否转入：" + (studentInfo.file_in === undefined ? "" : studentInfo.file_in),
                                    fontSize: 8,
                                    colSpan: 2,
                                    margin: [0, 10, 0, 10]
                                }, {},
                                    {
                                        text: "入学前档案所在单位：" + (studentInfo.pre_school_file_where_location === undefined ? "" : studentInfo.pre_school_file_where_location),
                                        fontSize: 8,
                                        colSpan: 5,
                                        margin: [0, 10, 0, 10]
                                    }, {}, {}, {}, {}],
                                [{
                                    text: "户口是否转入：" + (studentInfo.account_in === undefined ? "" : studentInfo.account_in),
                                    fontSize: 8,
                                    colSpan: 2,
                                    margin: [0, 10, 0, 10]
                                }, {},
                                    {
                                        text: "入学前户口所在派出所：" + (studentInfo.pre_school_account_where_station === undefined ? "" : studentInfo.pre_school_account_where_station),
                                        fontSize: 8,
                                        colSpan: 5,
                                        margin: [0, 10, 0, 10]
                                    }, {}, {}, {}, {}],
                                [{
                                    text: "邮编编码：" + (studentInfo.family_zip_code === undefined ? "" : studentInfo.family_zip_code),
                                    fontSize: 8,
                                    colSpan: 2,
                                    margin: [0, 10, 0, 10]
                                }, {},
                                    {
                                        text: "身份证住址：" + (studentInfo.idcard_address === undefined ? "" : studentInfo.idcard_address),
                                        fontSize: 8,
                                        colSpan: 5,
                                        margin: [0, 10, 0, 10]
                                    }, {}, {}, {}, {}],
                                [{
                                    text: "生源类别 ：" + (studentInfo.student_classify === undefined ? "" : studentInfo.student_classify),
                                    fontSize: 8,
                                    colSpan: 2,
                                    margin: [0, 10, 0, 10]
                                }, {},
                                    {
                                        text: "家庭实际住址：" + (studentInfo.actual_address === undefined ? "" : studentInfo.actual_address),
                                        fontSize: 8,
                                        colSpan: 5,
                                        margin: [0, 10, 0, 10]
                                    }, {}, {}, {}, {}],
                                [{
                                    text: "城乡生源名称：" + (studentInfo.area_origin_name === undefined ? "" : studentInfo.area_origin_name),
                                    fontSize: 8,
                                    colSpan: 2,
                                    margin: [0, 10, 0, 10]
                                }, {},
                                    {
                                        text: "生源所在地名称：" + (studentInfo.origin_address === undefined ? "" : studentInfo.origin_address),
                                        fontSize: 8,
                                        colSpan: 5,
                                        margin: [0, 10, 0, 10]
                                    }, {}, {}, {}, {}],
                                [{
                                    text: "紧急联系人：" + (studentInfo.emergency_contact_name === undefined ? "" : studentInfo.emergency_contact_name),
                                    fontSize: 8,
                                    colSpan: 2,
                                    margin: [0, 10, 0, 10]
                                }, {},
                                    {
                                        text: "联系方式：" + (studentInfo.emergency_contact_method === undefined ? "" : studentInfo.emergency_contact_method),
                                        fontSize: 8,
                                        colSpan: 5,
                                        margin: [0, 10, 0, 10]
                                    }, {}, {}, {}, {}]
                            ]
                        }
                    },
                    {text: "家庭成员", fontSize: 15, style: "subheader", color: "#36B7AB"},
                    {
                        style: "tableExample",
                        table: {
                            widths: ["*", "*", "*"],
                            body: fam
                        }
                    },
                    {text: "教育经历", fontSize: 15, style: "subheader", pageBreak: 'before', color: "#36B7AB"},
                    {
                        style: "tableExample",
                        table: {
                            widths: ["*", "*", "*"],
                            body: experience
                        }
                    },
                    {text: "学业状态", fontSize: 15, style: "subheader", color: "#36B7AB"},
                    {
                        style: "tableExample",
                        table: {
                            widths: ["*", "*", "*", "*"],
                            body: [
                                [{
                                    text: "学籍状态：" + (studentInfo.student_status === undefined ? "" : studentInfo.student_status),
                                    fontSize: 8,
                                    margin: [0, 10, 0, 10]
                                },
                                    {
                                        text: "职业导师：" + (studentInfo.teacherName === undefined ? "" : studentInfo.teacherName),
                                        fontSize: 8,
                                        margin: [0, 10, 0, 10]
                                    },
                                    {
                                        text: "学生类别：" + (studentInfo.student_type === undefined ? "" : studentInfo.student_type),
                                        fontSize: 8,
                                        margin: [0, 10, 0, 10]
                                    },
                                    {
                                        text: "高考成绩：" + (studentInfo.sat_score === undefined ? "" : studentInfo.sat_score),
                                        fontSize: 8,
                                        margin: [0, 10, 0, 10]
                                    }],
                                [{
                                    text: "录取专业：" + (studentInfo.origin_profession === undefined ? "" : studentInfo.origin_profession),
                                    fontSize: 8,
                                    margin: [0, 10, 0, 10]
                                },
                                    {
                                        text: "系：" + (studentInfo.department === undefined ? "" : studentInfo.department),
                                        fontSize: 8,
                                        margin: [0, 10, 0, 10]
                                    },
                                    {
                                        text: "现专业：" + (studentInfo.originProfession === undefined ? "" : studentInfo.originProfession),
                                        fontSize: 8,
                                        margin: [0, 10, 0, 10]
                                    },
                                    {
                                        text: "就业方向：" + (studentInfo.direction === undefined ? "" : studentInfo.direction),
                                        fontSize: 8,
                                        margin: [0, 10, 0, 10]
                                    }],
                                [{
                                    text: "班级：" + (studentInfo.classes === undefined ? "" : studentInfo.classes),
                                    fontSize: 8,
                                    margin: [0, 10, 0, 10]
                                },
                                    {
                                        text: "组别：" + (studentInfo.group === undefined ? "" : studentInfo.group),
                                        fontSize: 8,
                                        margin: [0, 10, 0, 10]
                                    },
                                    {
                                        text: "实践类型：" + (studentInfo.practice_learning_type === undefined ? "" : studentInfo.practice_learning_type),
                                        fontSize: 8,
                                        margin: [0, 10, 0, 10],
                                        colSpan: 2
                                    }, {}],
                                [{
                                    text: "实践单位或项目：" + (studentInfo.units_or_projects_practical_type === undefined ? "" : studentInfo.units_or_projects_practical_type),
                                    fontSize: 8,
                                    margin: [0, 10, 0, 10],
                                    colSpan: 2
                                }, {},
                                    {
                                        text: "联系人：" + (studentInfo.units_or_projects_practical_type_contact === undefined ? "" : studentInfo.units_or_projects_practical_type_contact),
                                        fontSize: 8,
                                        margin: [0, 10, 0, 10]
                                    },
                                    {
                                        text: "联系人电话：" + (studentInfo.units_or_projects_practical_type_contact_phone === undefined ? "" : studentInfo.units_or_projects_practical_type_contact_phone),
                                        fontSize: 8,
                                        margin: [0, 10, 0, 10]
                                    }],
                                [{
                                    text: "缴费状态： " + (payment_status_first_year === undefined ? "" : payment_status_first_year) + "  " + (payment_status_second_year === undefined ? "" : payment_status_second_year) + "  " + (payment_status_third_year === undefined ? "" : payment_status_third_year) + "  " + ( payment_status_forth_year === undefined ? "" : payment_status_forth_year) + "  " + (payment_status_fifth_year === undefined ? "" : payment_status_fifth_year) + "  " + (payment_status_sixth_year === undefined ? "" : payment_status_sixth_year),
                                    fontSize: 8, margin: [0, 10, 0, 10], colSpan: 4
                                }, {}, {}, {}]
                            ]
                        }
                    },
                    {text: "社区管理", fontSize: 15, style: "subheader", color: "#36B7AB"},
                    {
                        style: "tableExample",
                        table: {
                            widths: ["*", "*", "*", "*"],
                            body: [
                                [{
                                    text: "住宿类型：" + (stay_type === undefined ? "" : stay_type),
                                    fontSize: 8,
                                    margin: [0, 10, 0, 10]
                                },
                                    {
                                        text: "宿舍位置：" + (DormitoryInformation === undefined ? "" : DormitoryInformation),
                                        fontSize: 8,
                                        margin: [0, 10, 0, 10],
                                        colSpan: 3
                                    }, {}, {}],
                                [{
                                    text: "社区辅导员：" + (studentInfo.teacherCommunity === undefined ? "" : studentInfo.teacherCommunity),
                                    fontSize: 8,
                                    margin: [0, 10, 0, 10]
                                },
                                    {
                                        text: "华侨、港澳台：" + (studentInfo.is_out === undefined ? "" : studentInfo.is_out),
                                        fontSize: 8,
                                        margin: [0, 10, 0, 10]
                                    },
                                    {
                                        text: "政治面貌：" + (political_status === undefined ? "" : political_status),
                                        fontSize: 8,
                                        margin: [0, 10, 0, 10]
                                    },
                                    {
                                        text: "宗教信仰：" + (religion === undefined ? "" : religion),
                                        fontSize: 8,
                                        margin: [0, 10, 0, 10]
                                    }],
                                [{
                                    text: "血型：" + (studentInfo.blood === undefined ? "" : studentInfo.blood),
                                    fontSize: 8,
                                    margin: [0, 10, 0, 10]
                                },
                                    {
                                        text: "身高：" + (studentInfo.height === undefined ? "" : studentInfo.height),
                                        fontSize: 8,
                                        margin: [0, 10, 0, 10]
                                    },
                                    {
                                        text: "身高：" + (studentInfo.weight === undefined ? "" : studentInfo.weight),
                                        fontSize: 8,
                                        margin: [0, 10, 0, 10]
                                    },
                                    {
                                        text: "健康状况：" + (studentInfo.health_status === undefined ? "" : studentInfo.health_status),
                                        fontSize: 8,
                                        margin: [0, 10, 0, 10]
                                    }],
                                [{
                                    text: "第一年医保：" + (studentInfo.first_time_medical_insurance === undefined ? "" : studentInfo.first_time_medical_insurance) + "年（" + (studentInfo.first_medical_insurance === undefined ? "" : studentInfo.first_medical_insurance) + "）",
                                    fontSize: 8,
                                    margin: [0, 10, 0, 10],
                                },
                                    {
                                        text: "第二年医保：" + (studentInfo.second_time_medical_insurance === undefined ? "" : studentInfo.second_time_medical_insurance) + "年（" + (studentInfo.second_medical_insurance === undefined ? "" : studentInfo.second_medical_insurance) + "）",
                                        fontSize: 8,
                                        margin: [0, 10, 0, 10]
                                    },
                                    {
                                        text: "第三年医保：" + (studentInfo.third_time_medical_insurance === undefined ? "" : studentInfo.third_time_medical_insurance) + "年（" + (studentInfo.third_medical_insurance === undefined ? "" : studentInfo.third_medical_insurance) + "）",
                                        fontSize: 8,
                                        margin: [0, 10, 0, 10],
                                        colSpan: 2
                                    }, {}]
                            ]
                        }
                    },
                    {text: "奖学金或助学金", fontSize: 15, style: "subheader", pageBreak: 'before', color: "#36B7AB"},
                    {
                        style: "tableExample",
                        table: {
                            widths: ["*", "*", "*"],
                            body: scholarship
                        }
                    },
                    {text: "获奖或荣誉", fontSize: 15, style: "subheader", color: "#36B7AB"},
                    {
                        style: "tableExample",
                        table: {
                            widths: ["*", "*", "*"],
                            body: own_punishment
                        }
                    },
                    {text: "违纪或处分", fontSize: 15, style: "subheader", color: "#36B7AB"},
                    {
                        style: "tableExample",
                        table: {
                            widths: ["*", "*", "*", "*", "*", "*"],
                            body: disciplineAndPunishment
                        }
                    },
                    {text: "团学活动", fontSize: 15, style: "subheader", color: "#36B7AB"},
                    {
                        style: "tableExample",
                        table: {
                            widths: ["*", "*", "*", "*", "*"],
                            body: groupActivities
                        }
                    },
                ],
                styles: {
                    header: {
                        fontSize: 18,
                        bold: true,
                        margin: [0, 0, 0, 10]
                    },
                    subheader: {
                        fontSize: 16,
                        bold: true,
                        margin: [0, 10, 0, 5]
                    },
                    tableExample: {
                        margin: [0, 5, 0, 15]
                    },
                    tableHeader: {
                        bold: true,
                        fontSize: 13,
                        color: "black"
                    }
                },
                defaultStyle: {
                    font: "微软雅黑"
                }
            };
        pdfmak(content, "西安欧亚学院" + studentInfo.name + "学生档案");
        }
    }
</script>

<script>

    function pdfmak(content,fileName) {
        var dd = content;

        pdfMake.fonts = {
            Roboto: {
                normal: 'Roboto-Regular.ttf',
                bold: 'Roboto-Medium.ttf',
                italics: 'Roboto-Italic.ttf',
                bolditalics: 'Roboto-Italic.ttf'
            },
            微软雅黑: {
                normal: '微软雅黑.ttf',
                bold: '微软雅黑.ttf',
                italics: '微软雅黑.ttf',
                bolditalics: '微软雅黑.ttf',
            }
        };
        pdfMake.createPdf(dd).download(fileName, function () {
        });
    }

    function ImageDataURL(urls) {//urls必須是字符串或字符串數組
        this.completenum = 0;
        this.totalnum = 0;
        this.imgdata = new Array();
        this.emptyobj = new Object();
        this.oncomplete = function(){};
        this.getDataURL = function(url, index) {
            var c = document.createElement("canvas");
            var cxt = c.getContext("2d");
            var img = new Image();
            var dataurl;
            var p;
            p = this;
            img.src = url;
            img.onload = function() {
                var i;
                var maxwidth = 500;
                var scale = 1.0;
                if (img.width > maxwidth) {
                    scale = maxwidth / img.width;
                    c.width = maxwidth;
                    c.height = Math.floor(img.height * scale);
                } else {
                    c.width= img.width;
                    c.height= img.height;
                }
                cxt.drawImage(img, 0, 0, c.width, c.height);

                p.imgdata[index] = c.toDataURL('image/jpeg');
                for (i = 0; i < p.totalnum; ++i) {
                    if (p.imgdata[i] == null)break;
                }
                if (i == p.totalnum) {
                    p.oncomplete();
                }
            };
            img.onerror = function() {
                p.imgdata[index] = p.emptyobj;
                for (i = 0; i < p.totalnum; ++i) {
                    if (p.imgdata[i] == null)break;
                }
                if (i == p.totalnum) {
                    p.oncomplete();
                }
            };
        }
        if (urls instanceof Array) {
            this.totalnum = urls.length;
            this.imgdata = new Array(this.totalnum);
            for (key in urls) {
                this.getDataURL(urls[key], key);
            }
        } else {
            this.imgdata = new Array(1);
            this.totalnum = 1;
            this.getDataURL(urls, 0);
        }
    }
</script>
