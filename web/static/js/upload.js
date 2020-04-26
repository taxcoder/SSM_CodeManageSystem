$(function () {
    $("#register-btn").click("on", function () {
        window.location.replace($("#address").val()+"/free/register");
    });
    $("#login-btn").click("on", function () {
        window.location.replace($("#address").val()+"/free/login");
    });

    $("#pages_show").hover(function () {
        $("#pages").fadeIn(1100);
    },function () {
        $("#pages").fadeOut(1100);
    });

    let isFileName = false;
    let isIntro = false;
    $("#codefile").change(function () {
            if ($("#codefile").val().length > 0) {
                if (check()) {
                    $("#fileClass").remove();
                    let p = $("<span class='glyphicon glyphicon-ok-circle' id='fileClass' style='color,green;'></span>");
                    $("#file-text").append(p);
                    $("#fileClass").css({"position": "absolute", "right": "364px", "top": "10px"});
                    isFileName = true;
                } else {
                    $("#fileClass").remove();
                    let p = $("<span class='glyphicon glyphicon-remove-sign' id='fileClass' style='color,red;'><b color='red'>上传的文件后缀必须为zip或rar</b></span>");
                    $("#file-text").append(p);
                    $("#fileClass").css({"position": "absolute", "right": "139px", "top": "10px", "width": "241px"});
                    isFileName = false;
                }
            } else {
                isFileName = false;
            }
        }
    );

    $("#intro").blur(function () {

        if ($("#intro").val().length > 0) {
            $("#code-not-null").remove();
            let p = $("<span class='glyphicon glyphicon-ok-circle' id='code-not-null' style='color,green;'></span>");
            $("#not_null").append(p);
            $("#code-not-null").css({"position": "absolute", "right": "143px", "top": "10px"});
            isIntro = true;
        } else {
            $("#code-not-null").remove();
            let p = $("<span class='glyphicon glyphicon-remove-sign' id='code-not-null' style='color,red;'><b color='red'>代码说明不可为空！</b></span>");
            $("#not_null").append(p);
            $("#code-not-null").css({"position": "absolute", "right": "0", "top": "10px", "width": "160px"});
            isIntro = false;
        }
    });

    function check() {
        let name = $("#codefile").val();
        let suffix = name.substring(name.lastIndexOf("\.") + 1);
        if (suffix === "zip" || suffix === "rar") {
            return true;
        }
    }

    $("#button_submit_file").click(function (event) {
        let name = $("#codefile").val();
        if (isIntro && isFileName) {
            if (name.length === 0) {
                $("#fileClass").remove();
                let p = $("<span class='glyphicon glyphicon-remove-sign' id='fileClass' style='color,red;'><b color='red'>上传的文件不能为空！</b></span>");
                $("#file-text").append(p);
                $("#fileClass").css({"position": "absolute", "right": "139px", "top": "10px", "width": "241px"});
                isFileName = false;
            }else {
                event.preventDefault();
                $("#fileDesc").val($("#intro").val());
                $("#formSubmit").submit();
            }
        } else {
            alert("请正确填写表单后提交！");
        }
    });
});