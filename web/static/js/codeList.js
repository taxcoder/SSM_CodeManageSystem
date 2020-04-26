let submit_data;
let pageAddress;
let countPage;
let download;
let keyword;
let Address;
let allPage;
let codeId;
let midden;
let table;

$(function () {
    pageAddress = $("#address").val();
    keyword = $("#keyWord");
    countPage = $("#countPage").val();
    Address = "http://" + window.location.host + pageAddress + "/free/code";
    //=============================对象==============================
    submit_data = $("#submit-select-data");
    table = $("#table_append");
    allPage = $("#all-pages");
    midden = $(".midden-li");


    //============================开始操作===========================
    window.onbeforeunload = function () {
        if (parseInt(keyword.val()).length !== 0) {
            keyword.val("");
        }
    }

    if (Address === "http://localhost:8080/CodeManagement/free/code" && keyword.val().length === 0) {
        let p = "";
        $.ajax({
            url: pageAddress + "/free/codes/1",
            type: "get",
            dataType: "json",
            success: function (data) {
                if(data === 1){
                    window.location.replace(pageAddress + "/free/pageError");
                } else {
                    $(".success_data").remove();
                    let obj = JSON.stringify(data);
                    let resource = eval(data);
                    submit_data.addClass("disabled").css({"background": "gray"});
                    for (let i in resource) {
                        p = "<tr class='success_data'>" +
                            "<td>" + (parseInt(i) + 1) + "</td>" +
                            "<td>" + "<a class='click-a' href= '"+pageAddress+"/file/download?saveName="+ resource[i].saveName +"'>"+resource[i].showName+"</a>" + "</td>" +
                            "<td>" + resource[i].fileDesc + "</td>" +
                            "<td>" + resource[i].uploadUser + "</td>" +
                            "<td>" + resource[i].uploadTime + "</td>"
                            + "</tr>";
                        table.append(p);
                    }
                }
            }, error: function (data) {
                alert("查询失败，请重新尝试！");
            }
        });
    }

    //=============================click===========================

    submit_data.click(function () {
        keyword.val("");
    });

    midden.click(function () {
        let p = "";
        let number = $(this).children("a").text();
        codeId = parseInt(number) * parseInt(countPage) - parseInt(countPage);
        if (keyword.val().length===0) {
            submit_data.addClass("disabled").css({"background": "gray"});
        } else {
            submit_data.removeClass("disabled").css({'background': 'white'});
        }
        if (parseInt($(this).children("a").text()) <= parseInt(allPage.text().split("：")[1].split("页")[0]) && parseInt($(this).children("a").text()) > 0) {
            $(this).addClass("active").siblings().removeClass("active");
            $.ajax({
                url: pageAddress + "/free/codes/" + $(this).children("a").text(),
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
                                "<td>" + "<a class='click-a' href= '"+pageAddress+"/file/download?saveName="+resource[i].saveName+"'>"+resource[i].showName+"</a>" + "</td>" +
                                "<td>" + resource[i].fileDesc + "</td>" +
                                "<td>" + resource[i].uploadUser + "</td>" +
                                "<td>" + resource[i].uploadTime + "</td>"
                                + "</tr>";
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
        let p = "";
        $.post({
            url: pageAddress + "/free/codes/1",
            data: {"keyWord": $("#keyWord").val()},
            dataType: "json",
            success: function (data) {
                if(data === 1){
                    window.location.replace(pageAddress + "/free/pageError");
                } else {
                    a1.addClass("active").siblings().removeClass("active");
                    $(".success_data").remove();
                    if (data.length > 0) {
                        let obj = JSON.stringify(data);
                        let resource = eval(data);
                        for (let i in resource) {
                            p = "<tr class='success_data'>" +
                                "<td>" + (parseInt(i) + 1) + "</td>" +
                                "<td>" + "<a class='click-a' href= '"+pageAddress+"/file/download?saveName="+resource[i].saveName+"'>"+resource[i].showName+"</a>" + "</td>" +
                                "<td>" + resource[i].fileDesc + "</td>" +
                                "<td>" + resource[i].uploadUser + "</td>" +
                                "<td>" + resource[i].uploadTime + "</td>"
                                + "</tr>";
                            table.append(p);
                        }
                    } else {
                        table.append("<tr class='success_data'><td colspan='5' style='text-align: center'>" + '暂无数据' + "</td></tr>");
                    }
                }
            }, error: function (data) {
                alert("查询失败，请重新尝试！");
            }
        })

        $.post({
            url: pageAddress + "/free/allPages",
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

        if (keyword.val().length===0) {
            submit_data.addClass("disabled").css({"background": "gray"});
        } else {
            submit_data.removeClass("disabled").css({'background': 'white'});
        }

    });
});