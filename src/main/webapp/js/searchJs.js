function loadALlDepartments() {
    $.post(baseUrl + "/department/allDepartments", function (data) {
        if (data.result) {
            $("#department_search").html(`<option value="" selected>系</option>`).append(loadOptionsHtml(data.data, "-"));
        }
    });
}
function loadAllLevels() {
    let date = new Date();
    let year = date.getFullYear();
    let currentMonth = new Date().getMonth() + 1;
    year = currentMonth > 7 ? year : year - 1;
    let differ = year - 2015;
    $("#level_search").html();
    if (differ >= 0) {
        for (let i = differ; i >= 0; i--) {
            $("#level_search").append(`<option  value="` + (year - i) + `">` + (year - i) + `</option>`)
        }
    }
}

function loadClassessByDirectionId(id) {
    $.post(baseUrl + "/studentClass/queryClassesByDirectionId", {id: id}, function (data) {
        if (data.result) {
            $("#classes_search").html(`<option value="">班级</option>`).append(loadOptionsHtml(data.data, "-"))
        }
    })
}
function loadAllDirections() {
    $.post(baseUrl + "/communication/queryDirectionByDepartment", function (data) {
        if (data.result) {
            $("#direction_search").html(`<option value="">方向</option>`).append(loadOptionsHtml(data.data, "-"))
        }
    })
}
function loadAllProfessions() {
    $.post(baseUrl + "/profession/list", function (data) {
        if (data.result) {
            $("#profession_search").html(`<option value="">专业</option>`).append(loadOptionsHtml(data.data, "-"))
        }
    })
}
function loadAllClassess() {
    $.post(baseUrl + "/communication/queryClass", function (data) {
        if (data.result) {
            $("#classes_search").html(`<option value="">班级</option>`).append(loadOptionsHtml(data.data, "-"));
        }
    });
}


function loadOptionsHtml(data, selectId) {
    let _html = `<option value="">请选择</option><option value="">请选择</option>`;
    for (let i = 0; i < data.length; ++i) {
        if (selectId == data[i].id) {
            _html += `<option  selected value="` + data[i].id + `">` + data[i].name + `</option>`;
        } else {
            _html += `<option value="` + data[i].id + `">` + data[i].name + `</option>`;
        }
    }

    return _html;
}

function getSearchLevels() {
    let levels = [];
    let currentMonth = new Date().getMonth() + 1;
    let currentYear = new Date().getFullYear();
    if (currentMonth >= 8) levels.push(currentYear);
    levels.push(currentYear - 1);
    levels.push(currentYear - 2);
    if (currentMonth < 8) levels.push(currentYear - 3);

    return levels;
}

function showTotalCount(totalCount) {
    $("#totalCount").remove();
    $("#demo1").css({display: "inline-block"});
    $("#demo1").after(`<a class=" layui-word-aux" id="totalCount">总记录数${totalCount}</a>`);
}

function getBirthday(idcard) {
    return idcard.substr(6, 4) + "-" + idcard.substr(10, 2) + "-" + idcard.substr(12, 2);
}