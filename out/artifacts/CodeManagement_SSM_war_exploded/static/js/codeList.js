let pageAddress;
let countPage;
let download;
let Address;
let codeId;

$(function () {
    pageAddress = $("#address").val();
    countPage = $("#countPage").val();
    //=============================对象==============================
    const submit_data = $("#submit-select-data");
    const table = $("#table_append");
    const allPage = $("#all-pages");
    const midden = $(".midden-li");
    const keyword = $("#keyWord");
    const current = $("#current");
    let count = window.location.href.substring(window.location.href.lastIndexOf("/")+1);
    //============================开始操作===========================
    if(count.indexOf("?") !== -1){
        count = count.substring(0,count.lastIndexOf("?"));
    }
    //============================开始操作===========================
    submit_data.click(function () {
        keyword.val("");
        let changeUrl = window.location.href.substring(0,window.location.href.lastIndexOf("/")+1)+1;
        window.history.pushState(null,null,changeUrl);
    });

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


    let current_a = $(".pagination .midden-li").find("a");
    for (let i=0;i<current_a.length;++i){
        if(current_a.eq(i).text() === count){
            current_a.eq(i).parent().removeClass("active").addClass("active").siblings().removeClass("active");
        }
    }

    if (keyword.val().length===0) {
        submit_data.addClass("disabled").css({"background": "gray"});
    } else {
        submit_data.removeClass("disabled").css({'background': 'white'});
    }


    //=============================click===========================
    submit_data.click(function () {
        keyword.val("");
        window.location.href = pageAddress + "/free/code/1";
    });

    midden.click(function () {
        let number = $(this).children("a").text();
        codeId = parseInt(number) * parseInt(countPage) - parseInt(countPage);
        //判断操作
        if (parseInt(number) <= parseInt(allPage.text().split("：")[1].split("页")[0]) && parseInt(number) > 0) {
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
                        resource(data,codeId);
                    }
                }, error: function (data) {
                    operationError();
                }
            });
            if(keyword.val().length === 0){
                window.history.pushState(null,null,window.location.href.substring(0,window.location.href.lastIndexOf("/")+1)+number);
            }else{
                window.history.pushState(null,null,window.location.href.substring(0,window.location.href.lastIndexOf("/")+1)+number+"?k="+keyword.val());
            }
        }
    });

    keyword.blur(function () {
        $.post({
            url: pageAddress + "/free/codes/1",
            data: {"keyWord": keyword.val()},
            dataType: "json",
            success: function (data) {
                if(data === 1){
                    window.location.replace(pageAddress + "/free/pageError");
                } else {
                    a1.addClass("active").siblings().removeClass("active");
                    $(".success_data").remove();
                    if (data.length > 0) {
                        resource(data,0);
                    } else {
                        table.append("<tr class='success_data'><td colspan='5' style='text-align: center'>" + '暂无数据' + "</td></tr>");
                    }
                }
            }, error: function (data) {
                operationError();
            }
        });

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
                operationError();
            }
        });

        if (keyword.val().length===0) {
            submit_data.addClass("disabled").css({"background": "gray"});
        } else {
            submit_data.removeClass("disabled").css({'background': 'white'});
        }

        if(keyword.val().length === 0){
            window.history.pushState(null,null,window.location.href.substring(0,window.location.href.lastIndexOf("/")+1)+1);
        }else{
            window.history.pushState(null,null,window.location.href.substring(0,window.location.href.lastIndexOf("/")+1)+1+"?k="+keyword.val());
        }
    });
    function operationError() {
        alert("查询失败，请重新尝试！");
    }

    function resource(data,codeId) {
        let resource = eval(data);
        for (let i in resource) {
            let p = "<tr class='success_data'>" +
                "<td>" + (parseInt(codeId) + (parseInt(i) + 1)) + "</td>" +
                "<td>" + "<a class='click-a' href= '"+pageAddress+"/file/download?n="+resource[i].saveName+"'>"+resource[i].showName+"</a>" + "</td>" +
                "<td>" + resource[i].fileDesc + "</td>" +
                "<td>" + resource[i].uploadUser + "</td>" +
                "<td>" + resource[i].uploadTime + "</td>"
                + "</tr>";
            table.append(p);
        }
    }
});