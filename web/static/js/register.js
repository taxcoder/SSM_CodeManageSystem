$(function () {
    let isUsername = false, isPassword = false, isRePassword = false;
    $("#username").blur(function () {
        let value = $(this).val();
        let box_one = $("#errormsg-box_one");
        //box.empty();
        if (isBlank(value)) {
            //为空
            $(".error-1").remove();
            isUsername = false;
            let p = $("<p class='error-1 text-danger text-left' style='font-size: 16px; padding-top: 4px;'><span class='glyphicon glyphicon-remove-circle'></span><font color='blue'>&nbsp;用户名不可为空！</font></p>");
            box_one.append(p);
        } else if (isExistence()) {
            //占用
            $(".error-1").remove();
            isUsername = false;
            let p = $("<p class='error-1 text-danger text-left' style='font-size: 16px; padding-top: 4px;'><span class='glyphicon glyphicon-remove-circle'></span><font color='blue'>&nbsp;用户名已存在！</font></p>");
            box_one.append(p);
        } else if (!/^[a-zA-Z0-9]{5,11}$/.test(value)) {
            //用户位数不足
            $(".error-1").remove();
            isUsername = false;
            let p = $("<p class='error-1 text-danger text-left' style='font-size: 16px; padding-top: 4px;'><span class='glyphicon glyphicon-remove-circle'></span><font color='blue'>&nbsp;用户名需在5到11位之间，且为字母或数字！</font></p>");
            box_one.append(p);
        } else {
            //OK
            $(".error-1").remove();
            isUsername = true;
        }
    });

    $("#password").blur(function () {
        let value = $(this).val();
        var uPattern = /(?=.{6,17})(?=.*\d)(?=.*[a-z])[\x20-\x7f]*/;
        let box_two = $("#errormsg-box_two");
        //box.empty();
        if (isBlank(value)) {
            //为空
            $(".error-2").remove();
            isPassword = false;
            let p = $("<p class='error-2 text-danger text-left' style='font-size: 16px; padding-top: 4px;'><span class='glyphicon glyphicon-remove-circle'></span><font color='blue'>&nbsp;密码不可为空！</font></p>");
            box_two.append(p);
        } else if (uPattern.test(value)) {
            $(".error-2").remove();
            isPassword = true;
        } else {
            $(".error-2").remove();
            isPassword = false;
            let p = $("<p class='error-2 text-danger text-left' style='font-size: 16px; padding-top: 4px;min-width: 465px'><span class='glyphicon glyphicon-remove-circle'></span><font color='blue'>&nbsp;密码需在6到17位之间，有字母和数字组成，可包含英文字符！</font></p>");
            box_two.append(p);
        }
    });


    $("#repassword").blur(function () {
        let value = $(this).val();
        let password = $("#password").val();
        let box_three = $("#errormsg-box_three");
        //box.empty();
        if (isBlank(value)) {
            //为空
            $(".error-3").remove();
            isRePassword = false;
            let p = $("<p class='error-3 text-danger text-left' style='font-size: 16px; padding-top: 4px;'><span class='glyphicon glyphicon-remove-circle'></span><font color='blue'>&nbsp;重复密码不可为空！</font></p>");
            box_three.append(p);
        } else if (value !== password) {
            isRePassword = false;
            $(".error-3").remove();
            let p = $("<p class='error-3 text-danger text-left' style='font-size: 16px; padding-top: 4px;'><span class='glyphicon glyphicon-remove-circle'></span><font color='blue'>&nbsp;重复密码与密码不一致！</font></p>");
            box_three.append(p);
        } else {
            //OK
            $(".error-3").remove();
            isRePassword = true;
        }
    });
    $("#register").click(function (event) {
        if ((isUsername && isPassword && isRePassword) === true) {
            event.preventDefault();
            $("#register-form").submit();
        } else {
            alert("请正确填写表单再提交！");
        }
    });

    function isExistence() {
        let username = $("#username").val();
        $.post({
            url: $("#contextPath").val() + "/user/fight",
            data: {"username": username},
            async: false,
            success: function (resource) {
                $("#ajax_username").val(resource);
            },
            error: function (resource) {
                alert("注册出现异常！");
                window.location.href = $("#contextPath").val() + "/free/registerError";
            }
        });
        return $("#ajax_username").val() === "1";
    }
});
