let countPage;
let PageAddress;
let allPage;
let midden;
let table;
let codeId;
let keyword;
$(function () {
    pageAddress = $("#address").val();
    countPage = $("#countPage").val();
    table = $("#table-append");
    allPage = $("#all-pages");
    midden = $(".midden-li");
    keyword = $("#keyWord");

    $("#pages_show").hover(function () {
        $("#pages").fadeIn(1100);
    }, function () {
        $("#pages").fadeOut(1100);
    });

    //当刷新时，删除输入框数据自动跳转到开始查询页
    window.onbeforeunload = function () {
        if (parseInt(keyword.val()).length !== 0) {
            keyword.val("");
        }
    };

    Address = "http://" + window.location.host + pageAddress + "/file/myFile";
    if (Address === "http://localhost:8080/CodeManagement/file/myFile" && keyword.val().length === 0) {

        let p = "";
        $.ajax({
            url: pageAddress + "/file/myFiles/1",
            type: "get",
            dataType: "json",
            success: function (data) {
                if(data === 1){
                    window.location.replace(pageAddress + "/free/pageError");
                }else{
                    $(".success_data").remove();
                    let obj = JSON.stringify(data);
                    let resource = eval(data);
                    $("#submit-select-data").addClass("disabled").css({"background": "gray"});
                    for (let i in resource) {
                        p = "<tr class='success_data'>" +
                            "<td>" + (parseInt(i) + 1) + "</td>" +
                            "<td>" + "<a class='click-a' href= '" + pageAddress + "/file/download?saveName=" + resource[i].saveName + "'>" + resource[i].showName + "</a>" + "</td>" +
                            "<td>" + resource[i].fileDesc + "</td>" +
                            "<td>" + resource[i].uploadUser + "</td>" +
                            "<td>" + resource[i].uploadTime + "</td>" +
                            "<td align='center'>" +
                            "<a class='btn btn-default btn-sm btn-success' href='" + pageAddress + "/file/codeedit/" + resource[i].id + "' role='button'>" +
                            "<span class='glyphicon glyphicon-edit'></span>" + "&nbsp;修改" + "</a>" +
                            "<button class='delete-button btn btn-default btn-sm btn-danger' value='" + resource[i].id + "'>" +
                            "<span  class='glyphicon glyphicon-trash' ><input type='hidden' id='put_name' value='" + resource[i].id + "'/></span>" + "&nbsp;删除" + "</button>" +
                            "</td>" +
                            "</tr>";
                        table.append(p);
                    }
                }
            }, error: function (data) {
                alert(data);
                alert("查询失败，请重新尝试！");
            }
        });
    }

    $("#submit-select-data").click(function () {
        keyword.val("");
    });

    // //=================hover========================

    midden.click(function () {
        let p = "";
        codeId = (parseInt($(this).children("a").text()) * parseInt(countPage)) - parseInt(countPage);
        if ((parseInt($(this).children("a").text()) <= parseInt(allPage.text().split("：")[1].split("页")[0])) && parseInt($(this).children("a").text()) > 0) {
            $(this).addClass("active").siblings().removeClass("active");
            $("#currentPage").val($(this).children("a").text());
            $.ajax({
                url: pageAddress + "/file/myFiles/" + $(this).children("a").text(),
                type: "post",
                data: {"keyWord": keyword.val()},
                dataType: "json",
                success: function (data) {
                    if(data === 1){
                        window.location.replace(pageAddress + "/free/pageError");
                    } else {
                        $(".success_data").remove();
                        let obj = JSON.stringify(data);
                        let resource = eval(data);
                        for (let i in resource) {
                            p = "<tr class='success_data'>" +
                                "<td>" + (parseInt(codeId) + (parseInt(i) + 1)) + "</td>" +
                                "<td>" + "<a class='click-a' href= '" + pageAddress + "/file/download?saveName=" + resource[i].saveName + "'>" + resource[i].showName + "</a>" + "</td>" +
                                "<td>" + resource[i].fileDesc + "</td>" +
                                "<td>" + resource[i].uploadUser + "</td>" +
                                "<td>" + resource[i].uploadTime + "</td>" +
                                "<td align='center'>" +
                                "<a class='btn btn-default btn-sm btn-success' href='" + pageAddress + "/file/codeedit/" + resource[i].id + "' role='button'>" +
                                "<span class='glyphicon glyphicon-edit'></span>" + "&nbsp;修改" + "</a>" +
                                "<button class='delete-button btn btn-default btn-sm btn-danger' value='" + resource[i].id + "'>" +
                                "<span  class='glyphicon glyphicon-trash' ></span>" + "&nbsp;删除" + "</button>" +
                                "</td>" +
                                "</tr>";
                            table.append(p);
                        }
                    }
                }, error: function (data) {
                    alert("查询失败，请重新尝试！");
                }
            });
        }
    });

    keyword.blur(function () {
        let p;
        $.post({
            url: pageAddress + "/file/myFiles/1",
            data: {"keyWord": $("#keyWord").val()},
            dataType: "json",
            success: function (data) {
                if(data === 1){
                    window.location.replace(pageAddress + "/free/pageError");
                } else {
                    $("#a1").addClass("active").siblings().removeClass("active");
                    $(".success_data").remove();
                    if (data.length > 0) {
                        let obj = JSON.stringify(data);
                        let resource = eval(data);
                        for (let i in resource) {
                            p = "<tr class='success_data'>" +
                                "<td>" + (parseInt(i) + 1) + "</td>" +
                                "<td>" + "<a class='click-a' href= '" + pageAddress + "/file/download?saveName=" + resource[i].saveName + "'>" + resource[i].showName + "</a>" + "</td>" +
                                "<td>" + resource[i].fileDesc + "</td>" +
                                "<td>" + resource[i].uploadUser + "</td>" +
                                "<td>" + resource[i].uploadTime + "</td>" +
                                "<td align='center' class='button-click'>" +
                                "<a class='btn btn-default btn-sm btn-success' href='" + pageAddress + "/file/codeedit/" + resource[i].id + "' role='button'>" +
                                "<span class='glyphicon glyphicon-edit'></span>" + "&nbsp;修改" + "</a>" +
                                "<button class='delete-button btn btn-default btn-sm btn-danger' value='" + resource[i].id + "'>" +
                                "<span  class='glyphicon glyphicon-trash' ></span>" + "&nbsp;删除" + "</button>" +
                                "</td>" +
                                "</tr>";
                            table.append(p);
                        }
                    } else {
                        table.append("<tr class='success_data'><td colspan='5' style='text-align: center'>" + '暂无数据' + "</td></tr>");
                    }
                }
            }, error: function (data) {
                alert("查询失败，请重新尝试！");
            }
        });

        $.post({
            url: pageAddress + "/file/myFilePages",
            data: {"keyWord": keyword.val()},
            success: function (data) {
                $("#a1").children("a").text(1);
                $("#a2").children("a").text(2);
                $("#a3").children("a").text(3);
                $("#a4").children("a").text(4);
                $("#a5").children("a").text(5);
                let pages = "总页数：" + data + "页";
                allPage.text(pages);
            },
            error: function (data) {
                alert(data);
                alert("查询异常，请重试！");
            }
        });
        if (keyword.val().length === 0) {
            $("#submit-select-data").addClass("disabled").css({"background": "gray"});
        } else {
            $("#submit-select-data").removeClass("disabled").css({'background': 'white'});
        }
    });

    $(document).on("click", ".delete-button", function () {
        if (confirm("是否删除该数据？") === true) {
            $.get({
                url: pageAddress + "/file/deleteFile/" + $(this).val(),
                success: function (data) {
                    if (data === "success") {
                        alert("删除成功");
                        plush();
                        getAllPage();
                    } else {
                        window.location.replace(pageAddress + "/free/operationError?error=3");
                    }
                }, error: function (data) {
                    window.location.replace(pageAddress + "/free/operationError?error=3");
                }
            });
        }
    });

    function plush() {
        let p;
        $.post({
            url: pageAddress + "/file/myFiles/1",
            data: {"keyWord": $("#keyWord").val()},
            dataType: "json",
            success: function (data) {
                $("#a1").addClass("active").siblings().removeClass("active");
                $(".success_data").remove();
                if (data.length > 0) {
                    let obj = JSON.stringify(data);
                    let resource = eval(data);
                    for (let i in resource) {
                        p = "<tr class='success_data'>" +
                            "<td>" + (parseInt(i) + 1) + "</td>" +
                            "<td>" + "<a class='click-a' href= '" + pageAddress + "/file/download?saveName=" + resource[i].saveName + "'>" + resource[i].showName + "</a>" + "</td>" +
                            "<td>" + resource[i].fileDesc + "</td>" +
                            "<td>" + resource[i].uploadUser + "</td>" +
                            "<td>" + resource[i].uploadTime + "</td>" +
                            "<td align='center' class='button-click'>" +
                            "<a class='btn btn-default btn-sm btn-success' href='" + pageAddress + "/file/codeedit/" + resource[i].id + "' role='button'>" +
                            "<span class='glyphicon glyphicon-edit'></span>" + "&nbsp;修改" + "</a>" +
                            "<button class='delete-button btn btn-default btn-sm btn-danger' value='" + resource[i].id + "'>" +
                            "<span  class='glyphicon glyphicon-trash' ></span>" + "&nbsp;删除" + "</button>" +
                            "</td>" +
                            "</tr>";
                        table.append(p);
                    }
                } else {
                    table.append("<tr class='success_data'><td colspan='5' style='text-align: center'>" + '暂无数据' + "</td></tr>");
                }
            }, error: function (data) {
                alert("查询失败，请重新尝试！");
            }
        });
    }

    function getAllPage() {
        $.get({
            url: pageAddress + "/file/myFilePages",
            success: function (data) {
                let pages = "总页数：" + data + "页";
                allPage.text(pages);
            }, error: function (data) {
                window.location.replace(pageAddress + "/free/operationError?error=111");
            }
        });
    }
});