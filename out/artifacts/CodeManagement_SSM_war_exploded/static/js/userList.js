let pageAddress;
let countPage;
let download;
let keyword;
let Address;
let codeId;

$(function () {
    pageAddress = $("#address").val();
    keyword = $("#keyWord");
    const current = $("#currentUserList");
    countPage = $("#countPage").val();
    //=============================对象==============================
    const submit_data = $("#submit-select-data");
    const table = $("#table_append");
    const allPage = $("#all-pages");
    const midden = $(".midden-li");
    let count = window.location.href.substring(window.location.href.lastIndexOf("/")+1);
    if(count.indexOf("?") !== -1){
        count = count.substring(0,count.lastIndexOf("?"));
    }
    //============================开始操作===========================
    submit_data.click(function () {
       keyword.val("");
       let changeUrl = window.location.href.substring(0,window.location.href.lastIndexOf("/")+1)+1;
       window.history.pushState(null,null,changeUrl);
    });

    if(count > 5){
        let digit = parseInt(count/5);
        $("#a1").children("a").text(digit * 5 + 1);
        $("#a2").children("a").text(digit * 5 + 2);
        $("#a3").children("a").text(digit * 5 + 3);
        $("#a4").children("a").text(digit * 5 + 4);
        $("#a5").children("a").text(digit * 5 + 5);
    }
    //=============================click===========================

    midden.click(function () {
        let p = "";
        let number = parseInt( $(this).children("a").text());
        codeId = parseInt(number) * parseInt(5) - parseInt(5);
        if (parseInt($(this).children("a").text()) <= parseInt(allPage.text().split("：")[1].split("页")[0]) && parseInt($(this).children("a").text()) > 0) {
            $(this).addClass("active").siblings().removeClass("active");
            $.ajax({
                url: pageAddress + "/admin/userListFirst/" + $(this).children("a").text(),
                type: "post",
                data: {"keyWord": keyword.val()},
                dataType: "json",
                success: function (data) {
                    if (data === 1) {
                        window.location.replace(pageAddress + "/free/pageError");
                    } else {
                        current.val(number);
                        $(".success_data").remove();
                        let resource = eval(data);
                        for (let i in resource) {
                            p = "<tr class='success_data'>" +
                                "<td>" + (((number * parseInt(5)) - parseInt(5))+parseInt(i)+1) + "</td>" +
                                "<td>" + "<a class='click-a'>" + resource[i].username + "</a>" + "</td>" +
                                "<td>" + resource[i].userRoleName + "</td>" +
                                "<td>" + resource[i].registerTime + "</td>" +
                                "<td align='center'>" +
                                "<button class='btn btn-default btn-sm btn-success return-file' value='" + resource[i].id + "'>" +
                                "<span class='glyphicon glyphicon-edit'></span>" + "&nbsp;查看" + "</button>" +
                                "<button class='delete-button btn btn-default btn-sm btn-danger' value='" + resource[i].id+"/"+resource[i].roleId + "'>" +
                                "<span  class='glyphicon glyphicon-trash' ></span>" + "&nbsp;删除" + "</button>" +
                                "</td>" +
                                +"</tr>";
                            table.append(p);
                        }
                    }
                    //根据关键字设置url
                    if (keyword.val().length === 0) {
                        let changeUrl = window.location.href.substring(0,window.location.href.lastIndexOf("/")+1)+current.val();
                        window.history.pushState(null,null,changeUrl);
                        submit_data.addClass("disabled").css({"background": "gray"});
                    } else {
                        let changeUrl = window.location.href.substring(0,window.location.href.lastIndexOf("/")+1)+current.val()+"?k="+keyword.val();
                        window.history.pushState(null,null,changeUrl);
                        submit_data.removeClass("disabled").css({'background': 'white'});
                    }
                }, error: function (data) {
                    alert("查询失败，请重新尝试！");
                }
            });
        }
    });

    $(document).on("click", ".delete-button", function () {
            if (confirm("是否彻底删除？") === true) {
                $.get({
                    url: pageAddress + "/admin/delete/" + $(this).val().split("/")[0]+"/"+$(this).val().split("/")[1],
                    success: function (data) {
                        if(data === "success"){
                            alert("已彻底删除!");
                            plush();
                            getAllPage();
                        }else if (data === '2') {
                            alert("您的权限不足！！！");
                        }else{
                            window.location.replace(pageAddress + "/free/operationError?error=3");
                        }

                    }, error: function (data) {
                        window.location.replace(pageAddress + "/free/codeError");
                    }
                });
            }
    });

    $(document).on("click",".return-file",function () {
        window.location.replace(pageAddress + "/admin/information/"+$(this).val()+"/"+$("#currentUserList").val());
    });


    function plush() {
        let p;
        $.post({
            url: pageAddress + "/admin/userListFirst/"+$("#currentUserList").val(),
            data: {"keyWord": $("#keyWord").val()},
            dataType: "json",
            success: function (data) {
                if (data === 1) {
                    window.location.replace(pageAddress + "/free/pageError");
                } else {
                    $(".success_data").remove();
                    if (data.length > 0) {
                        let resource = eval(data);
                        for (let i in resource) {
                            p = "<tr class='success_data'>" +
                                "<td>" + (($("#currentUserList").val() * 5 - 5) + parseInt(i) +1 ) + "</td>" +
                                "<td>" + "<a class='click-a'>" + resource[i].username + "</a>" + "</td>" +
                                "<td>" + resource[i].userRoleName + "</td>" +
                                "<td>" + resource[i].registerTime + "</td>" +
                                "<td align='center'>" +
                                "<button class='btn btn-default btn-sm btn-success return-file' value='" + resource[i].id + "'>" +
                                "<span class='glyphicon glyphicon-edit'></span>" + "&nbsp;查看" + "</button>" +
                                "<button class='delete-button btn btn-default btn-sm btn-danger' value='" + resource[i].id+"/"+resource[i].roleId + "'>" +
                                "<span  class='glyphicon glyphicon-trash' ></span>" + "&nbsp;删除" + "</button>" +
                                "</td>" +
                                +"</tr>";
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
    }

    function getAllPage() {
        $.post({
            url: pageAddress + "/admin/allPages",
            data: {"keyWord": keyword.val()},
            success: function (data) {
                let pages = "总页数：" + data + "页";
                allPage.text(pages);
            }, error: function (data) {
                window.location.replace(pageAddress + "/free/operationError?error=111");
            }
        });
    }

    keyword.blur(function () {
        let p = "";
        $.post({
            url: pageAddress + "/admin/userListFirst/1",
            data: {"keyWord": $("#keyWord").val()},
            dataType: "json",
            success: function (data) {
                if (data === 1) {
                    window.location.replace(pageAddress + "/free/pageError");
                } else {
                    if(keyword.val().length !== 0){
                        let changeUrl = window.location.href.substring(0,window.location.href.lastIndexOf("/")+1)+1+"?k="+keyword.val();
                        window.history.pushState(null,null,changeUrl);
                    }else{
                        let changeUrl = window.location.href.substring(0,window.location.href.lastIndexOf("/")+1)+1;
                        window.history.pushState(null,null,changeUrl);
                    }
                    a1.addClass("active").siblings().removeClass("active");
                    $(".success_data").remove();
                    if (data.length > 0) {
                        let resource = eval(data);
                        for (let i in resource) {
                            p = "<tr class='success_data'>" +
                                "<td>" + (parseInt(i) + 1) + "</td>" +
                                "<td>" + "<a class='click-a'>" + resource[i].username + "</a>" + "</td>" +
                                "<td>" + resource[i].userRoleName + "</td>" +
                                "<td>" + resource[i].registerTime + "</td>" +
                                "<td align='center'>" +
                                "<button class='btn btn-default btn-sm btn-success return-file' value='" + resource[i].id + "'>" +
                                "<span class='glyphicon glyphicon-edit'></span>" + "&nbsp;查看" + "</button>" +
                                "<button class='delete-button btn btn-default btn-sm btn-danger' value='" + resource[i].id+"/"+resource[i].roleId + "'>" +
                                "<span  class='glyphicon glyphicon-trash' ></span>" + "&nbsp;删除" + "</button>" +
                                "</td>" +
                                +"</tr>";
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
            url: pageAddress + "/admin/allPages",
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

        if (keyword.val().length === 0) {
            submit_data.addClass("disabled").css({"background": "gray"});
        } else {
            submit_data.removeClass("disabled").css({'background': 'white'});
        }
    });
});