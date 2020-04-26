let AllPages;
let Midden;
let Dpage;
let Upage;
let a1;
let a2;
let a3;
let a4;
let a5;

$(function () {
    Midden = $(".midden-li");
    AllPages = $("#all-pages");
    Dpage = $("#down-page");
    Upage = $("#up-page");
    a1 = $("#a1");
    a2 = $("#a2");
    a3 = $("#a3");
    a4 = $("#a4");
    a5 = $("#a5");

    Midden.hover(function () {
        if (parseInt($(this).children("a").text()) <= parseInt(AllPages.text().split("：")[1].split("页")[0])) {
            if ($(this).hasClass("disabled")) {
                $(this).removeClass("disabled");
            }
        } else {
            $(this).addClass("disabled");
        }
    });

    Dpage.hover(function () {
        if (parseInt($(this).prev("li").children("a").text()) < parseInt(AllPages.text().split("：")[1].split("页")[0])) {
            $(this).removeClass("disabled");
        } else {
            $(this).addClass("disabled");
            AllPages.fadeIn(1000);
        }
    }, function () {
        AllPages.fadeOut(1000);
    });

    Upage.hover(function () {
        if (parseInt($(this).next("li").children("a").text()) === 1) {
            AllPages.fadeIn(1000);
            $(this).addClass("disabled");
        } else {
            $(this).removeClass("disabled");
        }
    }, function () {
        AllPages.fadeOut(1000);
    });

    //=============================click===========================

    Upage.click(function () {
        if (parseInt($(this).next("li").children("a").text()) !== 1) {
            a1.children("a").text(parseInt(a1.children("a").text()) - parseInt(5));
            a2.children("a").text(parseInt(a2.children("a").text()) - parseInt(5));
            a3.children("a").text(parseInt(a3.children("a").text()) - parseInt(5));
            a4.children("a").text(parseInt(a4.children("a").text()) - parseInt(5));
            a5.children("a").text(parseInt(a5.children("a").text()) - parseInt(5));
        }
    });

    Dpage.click(function () {
        if (parseInt($(this).prev("li").children("a").text()) < parseInt(AllPages.text().split("：")[1].split("页")[0])) {
            a1.children("a").text(parseInt(a1.children("a").text()) + parseInt(5));
            a2.children("a").text(parseInt(a2.children("a").text()) + parseInt(5));
            a3.children("a").text(parseInt(a3.children("a").text()) + parseInt(5));
            a4.children("a").text(parseInt(a4.children("a").text()) + parseInt(5));
            a5.children("a").text(parseInt(a5.children("a").text()) + parseInt(5));
        }
    });
});