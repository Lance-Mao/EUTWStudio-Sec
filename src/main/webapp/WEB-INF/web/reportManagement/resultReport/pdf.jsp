<%@ page contentType="text/html; charset=UTF-8" %>
<script type="text/javascript">
    function printPDF(data) {
let studentInfo = data.student;
        //图片格式转换
        var x = new ImageDataURL([HEAD_IMAGE_PREFIX + data.student.head_image]);
        x.oncomplete = function () {
            var imgs = new Array();
            for (key in this.imgdata) {
                if (this.imgdata[key] == this.emptyobj) {
                    imgs.push({text: '请上传头像', fontSize: 10, rowSpan: 3});
                    continue;
                }//不存在的圖片直接忽略
                imgs.push({image: this.imgdata[key], fit: [80, 120], rowSpan: 3});//在的圖片直接忽略
            }
            let gender;
            if (studentInfo.gender == 'F') {
                gender = "女";
            } else if (studentInfo.gender == 'M') {
                gender = "男";
            }


            let result = data.results;
            let leftReport = [];
            let rightReport = [];
            let elective_score =0;
            let compulsory_score = 0;
            leftReport.push([{text: '时间',fontSize: 6, color: "#36B7AB",style: 'tableHeader'},
                {text: '属性', fontSize: 6,color: "#36B7AB",style: 'tableHeader'},
                {text: '课程名称', fontSize: 6,color: "#36B7AB",style: 'tableHeader'},
                {text: '学分', fontSize: 6,color: "#36B7AB",style: 'tableHeader'},
                {text: '成绩', fontSize: 6,color: "#36B7AB",style: 'tableHeader'}]);
            rightReport.push([{text: '时间',fontSize: 6, color: "#36B7AB",style: 'tableHeader'},
                {text: '属性', fontSize: 6,color: "#36B7AB",style: 'tableHeader'},
                {text: '课程名称', fontSize: 6,color: "#36B7AB",style: 'tableHeader'},
                {text: '学分', fontSize: 6,color: "#36B7AB",style: 'tableHeader'},
                {text: '成绩', fontSize: 6,color: "#36B7AB",style: 'tableHeader'}]);
            if (result.length !== 0 && result.length >35) {
                for (let i = 0; i < 35; i++) {
                    let test_time = "";
                    let nature = "";
                    let result_style = "";

                    if (result[i].testTime != null) {
                        let testTime = result[i].testTime.split("-");
                        test_time = testTime[0] + testTime[1];
                    } else test_time = "";
                    nature = result[i].nature == 1 ? "选修" : "必修";
                    if (nature === "选修" && result[i].is_pass == 1) elective_score += result[i].credit;
                    if (nature === "必修" && result[i].is_pass == 1) compulsory_score += result[i].credit;
                    result_style = result[i].is_pass == 1 ? "" : `color: "#36B7AB",`;

                    if (result[i].is_pass !== 1) {
                        leftReport.push([{
                            text: test_time,
                            fontSize: 6, color: "red"
                        }, {
                            text: nature,
                            fontSize: 6, color: "red"
                        }, {
                            text: result[i].courseName,
                            fontSize: 6, color: "red"
                        }, {
                            text: result[i].credit,
                            fontSize: 6, color: "red"
                        }, {
                            text: result[i].score,
                            fontSize: 6, color: "red"
                        }]);
                    } else {
                        leftReport.push([{
                            text: test_time,
                            fontSize: 6,
                        }, {
                            text: nature,
                            fontSize: 6,
                        }, {
                            text: result[i].courseName,
                            fontSize: 6,
                        }, {
                            text: result[i].credit,
                            fontSize: 6,
                        }, {
                            text: result[i].score,
                            fontSize: 6,
                        }]);
                    }
                }
                    for (let i = 35; i < result.length; i++) {
                        let test_time = "";
                        let nature = "";
                        let result_style = "";
                        if (result[i].testTime != null) {
                            let testTime = result[i].testTime.split("-");
                            test_time = testTime[0] + testTime[1];
                        } else test_time = "";


                        nature = result[i].nature == 1 ? "选修" : "必修";
                        if (nature === "选修" && result[i].is_pass == 1) elective_score += result[i].credit;
                        if (nature === "必修" && result[i].is_pass == 1) compulsory_score += result[i].credit;
                        if (result[i].is_pass !== 1) {
                            rightReport.push([{
                                text: test_time,
                                fontSize: 6, color: "red"
                            }, {
                                text: nature,
                                fontSize: 6, color: "red"
                            }, {
                                text: result[i].courseName,
                                fontSize: 6, color: "red"
                            }, {
                                text: result[i].credit,
                                fontSize: 6, color: "red"
                            }, {
                                text: result[i].score,
                                fontSize: 6, color: "red"
                            }]);
                        } else {
                            rightReport.push([{
                                text: test_time,
                                fontSize: 6,
                            }, {
                                text: nature,
                                fontSize: 6,
                            }, {
                                text: result[i].courseName,
                                fontSize: 6,
                            }, {
                                text: result[i].credit,
                                fontSize: 6,
                            }, {
                                text: result[i].score,
                                fontSize: 6,
                            }]);
                        }
                    }

            }if(result.length !== 0 && result.length <=35){
                for (let i = 0; i < result.length; i++) {
                    let test_time = "";
                    let nature = "";
                    let result_style = "";
                    if (result[i].testTime != null) {
                        let testTime = result[i].testTime.split("-");
                        test_time = testTime[0] + testTime[1];
                    } else test_time = "";

                    nature = result[i].nature == 1 ? "选修" : "必修";
                    if (nature === "选修" && result[i].is_pass == 1) elective_score += result[i].credit;
                    if (nature === "必修" && result[i].is_pass == 1) compulsory_score += result[i].credit;
                    if (result[i].is_pass !== 1) {
                        leftReport.push([{
                            text: test_time,
                            fontSize: 6, color: "red"
                        }, {
                            text: nature,
                            fontSize: 6, color: "red"
                        }, {
                            text: result[i].courseName,
                            fontSize: 6, color: "red"
                        }, {
                            text: result[i].credit,
                            fontSize: 6, color: "red"
                        }, {
                            text: result[i].score,
                            fontSize: 6, color: "red"
                        }]);
                    } else {
                        leftReport.push([{
                            text: test_time,
                            fontSize: 6,
                        }, {
                            text: nature,
                            fontSize: 6,
                        }, {
                            text: result[i].courseName,
                            fontSize: 6,
                        }, {
                            text: result[i].credit,
                            fontSize: 6,
                        }, {
                            text: result[i].score,
                            fontSize: 6,
                        }]);
                    }
                }
            }
            var content = {
                content: [
                    {
                        text: "西安欧亚学院高职学院学生成绩单",
                        fontSize: 22,
                        style: "subheader",
                        color: "#36B7AB",
                        alignment: "center"
                    },
                    {
                        style: 'tableExample',
                        table: {
                            widths: [100, 60, 55, "*", "*", 80],
                            body: [
                                [{
                                    text: "姓名：" + (studentInfo.studentName === undefined ? "" : studentInfo.studentName),
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
                                        margin: [0, 11, 0, 11]
                                    },
                                    {
                                        text: "政治面貌：" + (studentInfo.political_status === undefined ? "" : studentInfo.political_status),
                                        fontSize: 8,
                                        margin: [0, 11, 0, 11]
                                    }, {
                                    text: "学号：" + (studentInfo.no === undefined ? "" : studentInfo.no),
                                    fontSize: 8,
                                    margin: [0, 13, 0, 13]
                                },
                                    imgs[0]
                                ],
                                [
                                    {
                                        text: "学历：专科",
                                        fontSize: 8,
                                        margin: [0, 11, 0, 11]
                                    },
                                    {
                                        text: "籍贯：" + (studentInfo.native_place === undefined ? "" : studentInfo.native_place),
                                        fontSize: 8,
                                        colSpan: 2,
                                        margin: [0, 11, 0, 11]
                                    }, {},
                                    {
                                        text: "身份证号：" + (studentInfo.idcard === undefined ? "" : studentInfo.idcard),
                                        fontSize: 8,
                                        colSpan: 2,
                                        margin: [0, 11, 0, 11]
                                    }, {},
                                ],
                                [{
                                    text: "专业名称：" + (studentInfo.professionName === undefined ? "" : studentInfo.professionName),
                                    fontSize: 8,
                                    margin: [0, 11, 0, 11]
                                },
                                    {
                                        text: "就业方向：" + (studentInfo.directionName === undefined ? "" : studentInfo.directionName),
                                        fontSize: 8,
                                        colSpan: 2,
                                        margin: [0, 11, 0, 11]
                                    },{},
                                    {
                                        text: "入学时间：" + (studentInfo.in_school === undefined ? "" : studentInfo.in_school)+"-09-01",
                                        fontSize: 8,
                                        colSpan: 2,
                                        margin: [0, 11, 0, 11]
                                    }, {}],
                            ]
                        },
                        layout: 'noBorders'
                    },
                        {
                        style: 'tableExample',
                        table: {
                            widths: [250,250],
                            body: [
                                [
                                    {
                                        style: 'tableExample',
                                        table: {
                                            widths: [25, 20,120,15,20],
                                            body: leftReport
                                        }
                                    }
                                    , {
                                    style: 'tableExample',
                                    table: {
                                        widths: [25, 20,120,15,20],
                                        body: rightReport
                                    }
                                }],
                            ]
                        },
                        layout: 'noBorders'
                    },
                    {
                        style: 'tableExample',
                        table: {
                            widths: [100, 100],
                            body: [
                                [{
                                    text: "必修/实修："+data.totalCredit+"/"+compulsory_score,
                                    fontSize: 8,
                                    color: "#36B7AB",
                                    margin: [0, 13, 0, 13]
                                },
                                    {
                                        text: "选修/实修："+"6/"+elective_score,
                                        fontSize: 8,
                                        color: "#36B7AB",
                                        margin: [0, 11, 0, 11]
                                    }]
                            ]
                        },
                        layout: 'headerLineOnly'
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
            pdfmak(content, "西安欧亚学院高职学院学生成绩单");
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
