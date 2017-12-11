function queryAreaAndFloor () {
    $.post(baseUrl + "dorm/room/showAreaAndFloorsToQuery", function (data) {
        if (data.result) {
            $("#queryAreas").html("<option value=\"\">区</option>").append(room.loadDepartmentOrDirection(data.data.queryAreaOfRoom, "-"))
            $("#queryFloors").html("<option value=\"\">宿舍</option>").append(room.loadDepartmentOrDirection(data.data.queryFloorOfRoom, "-"))
        }
        form.render();
    })
}
