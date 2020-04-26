let pageAddress;
let addressURL;
let countPage;
let download;
let codeId;

$(function () {
    addressURL = $("#requestURI").val().split(".")[0].split("/")[4];
    pageAddress = $("#address").val();
    countPage = $("#countPage").val();
    //=============================对象==============================
    const submit_data = $("#submit-data");
    const table = $("#table_append");
    const allPage = $("#all-pages");
    const midden = $(".midden-li");
    const keyword = $("#keyWord-Data");
    const current = $("#current");

    $("#ul_menu_3").css({"display": ""});
    $("#nav-span-3").removeClass("glyphicon-chevron-left").addClass("glyphicon-chevron-down");

    //============================开始操作===========================
    let count = window.location.href.substring(window.location.href.lastIndexOf("/")+1);
    if(count.indexOf("?") !== -1){
        count = count.substring(0,count.lastIndexOf("?"));
    }
    if (parseInt(current.val()) < parseInt(count)){
        count = current.val();
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
    submit_data.click(function () {
        keyword.val("");
        window.location.href = pageAddress + "/file/recycleFile/1";
    });

    if (keyword.val().length === 0) {
        $("#submit-select-data").addClass("disabled").css({"background": "gray"});
    } else {
        $("#submit-select-data").removeClass("disabled").css({'background': 'white'});
    }

    let current_a = $(".pagination .midden-li").find("a");
    for (let i=0;i<current_a.length;++i){
        if(current_a.eq(i).text() === count){
            current_a.eq(i).parent().removeClass("active").addClass("active").siblings().removeClass("active");
        }
    }

    midden.click(function () {
        let number = $(this).children("a").text();
        codeId = parseInt(number) * parseInt(5) - parseInt(5);
        if (parseInt(number) <= parseInt(allPage.text().split("：")[1].split("页")[0]) && parseInt(number) > 0) {
            $(this).addClass("active").siblings().removeClass("active");
            $.post({
                url: pageAddress + "/file/myRecycleFiles/" + number,
                data: {"keyWord": keyword.val()},
                dataType: "json",
                success: function (data) {
                    if (data === 1) {
                        window.location.replace(pageAddress + "/free/pageError");
                    } else {
                        $("#current-recycle").val(number);
                        $(".success_data").remove();
                        print(parseInt(codeId), data);
                    }
                }, error: function (data) {
                    alert("查询失败，请重新尝试！");
                }
            });
            let changeUrl = window.location.href.substring(0, window.location.href.lastIndexOf("/") + 1) + number;
            if (keyword.val().length === 0) {
                window.history.pushState(null, null, changeUrl);
            } else {
                window.history.pushState(null, null, changeUrl + "?k=" + keyword.val());
            }
        }
    });

    $(document).on("click", ".return-file", function () {
        if (confirm("是否撤回？") === true) {
            $.get({
                url: pageAddress + "/file/deleteFileWithdraw/" + $(this).val(),
                success: function (data) {
                    if (data === "success") {
                        alert("已撤回");
                        plush();
                        getAllPage();
                    } else {
                        alert("撤回失败！");
                    }

                }, error: function (data) {
                    window.location.replace(pageAddress + "/free/codeError");
                }
            });
        }
    });

    $(document).on("click", ".delete-button", function () {
        if (confirm("是否彻底删除？") === true) {
            $.get({
                url: pageAddress + "/file/deleteFileTrue/" + $(this).val(),
                success: function (data) {
                    if (data === "success") {
                        alert("已彻底删除!");
                        plush();
                        getAllPage();
                    } else if(data === "lose"){
                        alert("文件存储异常，文件不存在！");
                        plush();
                        getAllPage();

                    }else{
                        window.location.replace(pageAddress + "/free/operationError?error=3");
                    }

                }, error: function (data) {
                    window.location.replace(pageAddress + "/free/codeError");
                }
            });
        }
    });


    function plush() {
        $.post({
            url: pageAddress + "/file/myRecycleFiles/" + $("#current-recycle").val(),
            data: {"keyWord": keyword.val()},
            dataType: "json",
            success: function (data) {
                if (data === 1) {
                    window.location.replace(pageAddress + "/free/pageError");
                } else {
                    $(".success_data").remove();
                    if (data.length > 0) {
                        print($("#current-recycle").val() * 5 - 5, data);
                    } else {
                        table.append("<tr class='success_data'><td colspan='5' style='text-align: center'>" + '暂无数据' + "</td></tr>");
                    }
                }
            }, error: function (data) {
                alert("查询失败，请重新尝试！");
            }
        });
    }

    function getAllPage() {
        $.get({
            url: pageAddress + "/file/RecycleFileAllPages",
            success: function (data) {
                let pages = "总页数：" + data + "页";
                allPage.text(pages);
            }, error: function (data) {
                window.location.replace(pageAddress + "/free/operationError?error=111");
            }
        });
    }

    keyword.blur(function () {
        $.post({
            url: pageAddress + "/file/myRecycleFiles/1",
            data: {"keyWord": keyword.val()},
            dataType: "json",
            success: function (data) {
                if (data === 1) {
                    window.location.replace(pageAddress + "/free/pageError");
                } else {
                    a1.addClass("active").siblings().removeClass("active");
                    $(".success_data").remove();
                    if (data.length > 0) {
                        print(0, data);
                    } else {
                        table.append("<tr class='success_data'><td colspan='5' style='text-align: center'>" + '暂无数据' + "</td></tr>");
                    }
                }
            }, error: function (data) {
                alert("查询失败，请重新尝试！");
            }
        });

        $.post({
            url: pageAddress + "/file/RecycleFileAllPages",
            data: {"keyWord": keyword.val()},
            dataType: "json",
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
                alert("查询异常，请重试！");
            }
        });
        let changeUrl = window.location.href.substring(0, window.location.href.lastIndexOf("/") + 1) + 1;
        if (keyword.val().length === 0) {
            submit_data.addClass("disabled").css({"background": "gray"});
            window.history.pushState(null, null, changeUrl);
        } else {
            submit_data.removeClass("disabled").css({'background': 'white'});
            window.history.pushState(null, null, changeUrl + "?k=" + keyword.val());
        }
    });

    function print(index, data) {
        let resource = eval(data);
        for (let i in resource) {
            let p = "<tr class='success_data'>" +
                "<td>" + (index + (parseInt(i) + 1)) + "</td>" +
                "<td>" + "<a class='click-a'>" + resource[i].showName + "</a>" + "</td>" +
                "<td>" + resource[i].fileDesc + "</td>" +
                "<td>" + resource[i].deleteTime + "</td>" +
                "<td align='center'>" +
                "<button class='btn btn-default btn-sm btn-success return-file' value='" + resource[i].id + "'>" +
                "<span class='glyphicon glyphicon-edit'></span>" + "&nbsp;撤回" + "</button>" +
                "<button class='delete-button btn btn-default btn-sm btn-danger' value='" + resource[i].id + "'>" +
                "<span  class='glyphicon glyphicon-trash' ></span>" + "&nbsp;删除" + "</button>" +
                "</td>" +
                "</tr>";
            table.append(p);
        }
    }
});