let countPage;
let PageAddress;
let addressURL;
let codeId;
$(function () {

    addressURL = $("#requestURI").val().split(".")[0].split("/")[4];
    pageAddress = $("#address").val();
    countPage = $("#countPage").val();
    const table = $("#table-append");
    const allPage = $("#all-pages");
    const midden = $(".midden-li");
    const keyword = $("#keyWord-input");
    const current_input = $("#current-input");

    $("#pages_show").hover(function () {
        $("#pages").fadeIn(1100);
    }, function () {
        $("#pages").fadeOut(1100);
    });

    $("#ul_menu_3").css({"display": ""});
    $("#nav-span-3").removeClass("glyphicon-chevron-left").addClass("glyphicon-chevron-down");

    let count = window.location.href.substring(window.location.href.lastIndexOf("/")+1);
    //============================开始操作===========================
    if(count.indexOf("?") !== -1){
        count = count.substring(0,count.lastIndexOf("?"));
    }

    if (parseInt(current_input.val()) < parseInt(count)){
        count = current_input.val();
    }
    if(count > 5){
        let digit = parseInt(count/5);
        if (count%5!==0){
            $("#a1").children("a").text(digit * 5 + 1);
            $("#a2").children("a").text(digit * 5 + 2);
            $("#a3").children("a").text(digit * 5 + 3);
            $("#a4").children("a").text(digit * 5 + 4);
            $("#a5").children("a").text(digit * 5 + 5);
        }else{
            $("#a1").children("a").text((digit-1) * 5 + 1);
            $("#a2").children("a").text((digit-1) * 5 + 2);
            $("#a3").children("a").text((digit-1) * 5 + 3);
            $("#a4").children("a").text((digit-1) * 5 + 4);
            $("#a5").children("a").text((digit-1) * 5 + 5);
        }
    }

    let current_a = $(".pagination .midden-li").find("a");
    for (let i=0;i<current_a.length;++i){
        if(current_a.eq(i).text() === count){
            current_a.eq(i).parent().removeClass("active").addClass("active").siblings().removeClass("active");
        }
    }

    if (keyword.val().length === 0) {
        $("#submit-select-data").addClass("disabled").css({"background": "gray"});
    } else {
        $("#submit-select-data").removeClass("disabled").css({'background': 'white'});
    }

    $("#submit-select-data").click(function () {
        keyword.val("");
        window.location.href = pageAddress + "/file/myFile/1";
    });

    // //=================hover========================

    midden.click(function () {
        let p = "";
        let number = $(this).children("a").text();
        codeId = (parseInt($(this).children("a").text()) * parseInt(5)) - parseInt(5);
        if ((parseInt($(this).children("a").text()) <= parseInt(allPage.text().split("：")[1].split("页")[0])) && parseInt($(this).children("a").text()) > 0) {
            $(this).addClass("active").siblings().removeClass("active");
            $("#currentPage").val($(this).children("a").text());
            $.post({
                url: pageAddress + "/file/myFiles/" + number,
                data: {"keyWord": keyword.val()},
                dataType: "json",
                success: function (data) {
                    if(data === 1){
                        window.location.replace(pageAddress + "/free/pageError");
                    } else {
                        $("#current").val(number);
                        $(".success_data").remove();
                        print(codeId,data);
                    }
                }, error: function (data) {
                    alert("查询失败，请重新尝试！");
                }
            });
            let changeUrl = window.location.href.substring(0,window.location.href.lastIndexOf("/")+1)+number;
            if(keyword.val().length===0){
                window.history.pushState(null,null,changeUrl);
            }else{
                window.history.pushState(null,null,changeUrl+"?k="+keyword.val());
            }

        }
    });

    keyword.blur(function () {
        let p;
        $.post({
            url: pageAddress + "/file/myFiles/1",
            data: {"keyWord": keyword.val()},
            dataType: "json",
            success: function (data) {
                if(data === 1){
                    window.location.replace(pageAddress + "/free/pageError");
                } else {
                    $("#a1").addClass("active").siblings().removeClass("active");
                    $(".success_data").remove();
                    if (data.length > 0) {
                        print(0,data);
                    } else {
                        table.append("<tr class='success_data'><td colspan='6' style='text-align: center'>" + '暂无数据' + "</td></tr>");
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

        let changeUrl = window.location.href.substring(0,window.location.href.lastIndexOf("/")+1)+1;
        if (keyword.val().length === 0) {
            $("#submit-select-data").addClass("disabled").css({"background": "gray"});
            window.history.pushState(null,null,changeUrl);
        } else {
            $("#submit-select-data").removeClass("disabled").css({'background': 'white'});
            window.history.pushState(null,null,changeUrl+"?k="+keyword.val());
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
            url: pageAddress + "/file/myFiles/"+$("#current").val(),
            data: {"keyWord": $("#keyWord").val()},
            dataType: "json",
            success: function (data) {
                $(".success_data").remove();
                if (data.length > 0) {
                    print(($("#current").val() * 5 - 5),data);
                } else {
                    table.append("<tr class='success_data'><td colspan='6' style='text-align: center'>" + '暂无数据' + "</td></tr>");
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

    function print(currentPage,data) {
        let resource = eval(data);
        for (let i in resource) {
            p = "<tr class='success_data'>" +
                "<td>" + (currentPage + parseInt(i)+1)+ "</td>" +
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
    }
});