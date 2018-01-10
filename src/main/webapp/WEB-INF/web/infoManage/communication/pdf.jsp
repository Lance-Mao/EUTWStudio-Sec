<%@ page contentType="text/html; charset=UTF-8" %>

<script type="text/javascript">
    function printPDF(data) {
        let communicationData = data.data;
        let communicateContentHead = [];
        if (communicationData.length >= 2){
            for (let i = 0; i < communicationData.length - 1; i++) {
                communicateContentHead.push([
                    {
                        text: "时间：" + communicationData[i].time,
                        fontSize: 8,
                        border: [false, true, false, true],
                        margin: [0, 4, 0, 4]
                    },
                    {
                        text: "沟通老师：" + communicationData[i].teacherName,
                        fontSize: 8,
                        border: [false, true, false, true],
                        margin: [0, 4, 0, 4]
                    },
                    {
                        text: "沟通对象：" + communicationData[i].talkName,
                        fontSize: 8,
                        border: [false, true, false, true],
                        margin: [0, 4, 0, 4]
                    },
                    {
                        text: "沟通类型：" + communicationData[i].direction,
                        fontSize: 8,
                        border: [false, true, false, true],
                        margin: [0, 4, 0, 4]
                    },
                    {
                        text: "沟通方式：" + communicationData[i].communicationMode,
                        fontSize: 8,
                        border: [false, true, false, true],
                        margin: [0, 4, 0, 4]
                    },
                    {
                        text: "电话：" + communicationData[i].communicationPhone,
                        fontSize: 8,
                        border: [false, true, false, true],
                        margin: [0, 4, 0, 4]
                    },
                ]);
                let communicationDataContent = communicationData[i].contents;
                let contentTimes = 0;
                for (let count = 0; count < communicationDataContent.length - 1; count += 2) {
                    contentTimes++;
                    communicateContentHead.push(
                        [
                            {
                                text: "Q" + contentTimes + "：",
                                alignment: 'center',
                                colSpan: 1,
                                margin: [0, 4, 0, 4],
                                border: [false, false, false, false],
                                style: "removeTheBorder"
                            },
                            {
                                text: communicationDataContent[count],
                                margin: [0, 4, 0, 4],
                                border: [false, false, false, false],
                                colSpan: 5,
                            }, {}, {}, {}, {}
                        ],
                        [
                            {
                                text: "A" + contentTimes + "：",
                                alignment: 'center',
                                border: [false, false, false, false],
                                margin: [0, 4, 0, 4],
                                colSpan: 1,
                                style: "removeTheBorder"
                            },
                            {
                                text: communicationDataContent[count + 1],
                                margin: [0, 4, 0, 4],
                                border: [false, false, false, false],
                                colSpan: 5,
                            }, {}, {}, {}, {}
                        ]
                    )
                }
            }
        }else {
            communicateContentHead.push([{
                text: "沟通记录暂无！",
                fontSize: 8,
                border: [false, true, false, true],
                margin: [0, 4, 0, 4]
            }]);
        }
        //图片格式转换
        var x = new ImageDataURL([baseUrl + "/images/public/logo_1.jpg", baseUrl + "/images/public/cover.png"]);
        var imgs = [];
        var imgs1 = [];
        x.oncomplete = function () {
            for (let key in this.imgdata) {
                if (this.imgdata[key] == this.emptyobj) {
                    imgs.push({text: '请上传头像', fontSize: 10, rowSpan: 3});
                    continue;
                }//不存在的圖片直接忽略
                if (imgs1.length === 0) {
                    imgs1.push({image: this.imgdata[key], fit: [150, 120], rowSpan: 3});//在的圖片直接忽略
                } else {
                    imgs.push({image: this.imgdata[key], width: 550, height: 180});//在的圖片直接忽略
                }
            }
            var info = data.data[data.data.length - 1];
            var content = {
                content: [
                    {
                        style: "coverStyle",
                        table: {
                            widths: [120, "*", "*", "*", 240],
                            body: [
                                [imgs1, {}, {}, {}, {}],
                                [{text: "\n\n\n\n\n\n\n\n\n\n\n\n"}, {text: ""}, {text: ""}, {text: ""}, {text: ""}],
                                [{text: ""}, {text: ""}, {text: ""}, {text: ""},
                                    {
                                        text: "西安欧亚学院高职学院学生成长报告",
                                        color: "#36B7AB",
                                        fontSize: 15,
                                    }],
                                [{text: ""}, {text: ""}, {text: ""}, {text: ""}, {text: "姓名：" + (info.name !== undefined ? info.name : "")}],
                                [{text: ""}, {text: ""}, {text: ""}, {text: ""}, {text: "籍贯：" + (info.famousFamily !== undefined ? info.famousFamily : "")}],
                                [{text: ""}, {text: ""}, {text: ""}, {text: ""}, {text: "身份证号：" + info.idcard}],
                                [{text: ""}, {text: ""}, {text: ""}, {text: ""}, {text: "专业：" + (info.profession !== undefined ? info.profession : "")}],
                                [{text: ""}, {text: ""}, {text: ""}, {text: ""}, {text: "就业方向：" + info.direction}],
                                [{text: ""}, {text: ""}, {text: ""}, {text: ""}, {text: "班级：" + info.classesName}],
                                [{text: "\n\n"}, {text: ""}, {text: ""}, {text: ""}, {text: ""}],
                                [imgs, {}, {}, {}, {}],
                                [{},{},{},{},{text: "\n\n\n\n\n\n\n\n\n"}],
                            ]
                        },

                        layout: 'noBorders',
                    },
                    {
                        style: "tableExample",
                        table: {
                            widths: [110, 80, 70, 75, 60, 90],
                            body: communicateContentHead,
                        },
                    },
                ],
                styles: {
                    coverStyle: {
                        margin: [20, 20, 20, 20]
                    },
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
                        fontSize: 8,
                        bold: false,
                        margin: [0, 5, 0, 15]
                    },
                    tableHeader: {
                        bold: true,
                        fontSize: 13,
                        color: "black"
                    },
                    removeTheBorder: {
                        border: "none",
                        margin: [0, 0, 0, 0]
                    }
                },
                defaultStyle: {
                    font: "微软雅黑"
                }
            };
            pdfmake(content,info.name + "成长报告");
        }
    }
</script>


<script>
    function pdfmake(content,fileName) {
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
        pdfMake.createPdf(dd).download(fileName,function () {
        });
    }
</script>
<script>
    function ImageDataURL(urls) {//urls必须是字符串或字符串数组
        this.completenum = 0;
        this.totalnum = 0;
        this.imgdata = new Array();
        this.emptyobj = new Object();
        this.oncomplete = function () {
        };
        this.getDataURL = function (url, index) {
            var c = document.createElement("canvas");
            var cxt = c.getContext("2d");
            var img = new Image();
            var dataurl;
            var p;
            p = this;
            img.src = url;
            img.onload = function () {
                var i;
                var maxwidth = 500;
                var scale = 1.0;
                if (img.width > maxwidth) {
                    scale = maxwidth / img.width;
                    c.width = maxwidth;
                    c.height = Math.floor(img.height * scale);
                } else {
                    c.width = img.width;
                    c.height = img.height;
                }
                cxt.drawImage(img, 0, 0, c.width, c.height);

                p.imgdata[index] = c.toDataURL('image/jpeg');
                for (i = 0; i < p.totalnum; ++i) {
                    if (p.imgdata[i] == null)
                        break;
                }
                if (i == p.totalnum) {
                    p.oncomplete();
                }
            };
            img.onerror = function () {
                p.imgdata[index] = p.emptyobj;
                for (i = 0; i < p.totalnum; ++i) {
                    if (p.imgdata[i] == null)
                        break;
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
        this.completenum = 0;
        this.totalnum = 0;
        this.imgdata = new Array();
        this.emptyobj = new Object();
        this.oncomplete = function () {
        };
        this.getDataURL = function (url, index) {
            var c = document.createElement("canvas");
            var cxt = c.getContext("2d");
            var img = new Image();
            var dataurl;
            var p;
            p = this;
            img.src = url;
            img.onload = function () {
                var i;
                var maxwidth = 500;
                var scale = 1.0;
                if (img.width > maxwidth) {
                    scale = maxwidth / img.width;
                    c.width = maxwidth;
                    c.height = Math.floor(img.height * scale);
                } else {
                    c.width = img.width;
                    c.height = img.height;
                }
                cxt.drawImage(img, 0, 0, c.width, c.height);

                p.imgdata[index] = c.toDataURL('image/jpeg');
                for (i = 0; i < p.totalnum; ++i) {
                    if (p.imgdata[i] == null)
                        break;
                }
                if (i == p.totalnum) {
                    p.oncomplete();
                }
            };
            img.onerror = function () {
                p.imgdata[index] = p.emptyobj;
                for (i = 0; i < p.totalnum; ++i) {
                    if (p.imgdata[i] == null)
                        break;
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