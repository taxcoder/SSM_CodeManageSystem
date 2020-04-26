let isPassword;
let isOldPassword;
let isRePassword;
$(function () {
    const oldPassword = $("#oldPassword");
    const resource = $("#oldPassword_resource");
    const address = $("#address").val();
    let isOldPassword = false;
    isPassword = false;
    isRePassword = false;
    oldPassword.blur(function () {
        $.post({
            url: address+"/user/judgePassword",
            data: {"password": oldPassword.val()},
            sync: true,
            success: function (data) {
                if (data === "-1") {
                    validateInfo("oldPassword_info", false, "原密码不可为空!");
                } else if (data === "0") {
                    validateInfo("oldPassword_info", false, "原密码错误!");
                } else {
                    validateInfo("oldPassword_info", true, "");
                    isOldPassword = true;
                }
            }, error: function (data) {
                alert("操作异常，请重新尝试！");
                window.location.href = address+"/free/sysError";
            }
        });
    });
    $("#password").blur(function () {
        let regex = /(?=.{6,17})(?=.*\d)(?=.*[a-z])[\x20-\x7f]*/;
        let value = $(this).val();
        if (isBlank(value)) {
            validateInfo("password_info", false, "新密码不可为空!");
        } else if (regex.test(value)) {
            validateInfo("password_info", true, "");
            isPassword = true;
        } else {
            validateInfo("password_info", false, "密码为6到17位,必须包含字母和数字,可拥有英文符号!");
        }
    });


    $("#rePassword").blur(function () {
        let value = $(this).val();
        let newPassword = $("#password").val();
        if (isBlank(value)) {
            validateInfo("rePassword_info", false, "重复密码不可为空");
            isRePassword = false;
        } else if (value === newPassword) {
            validateInfo("rePassword_info", true, "");
            isRePassword = true;
        } else {
            validateInfo("rePassword_info", false, "重复密码必须与新密码一致");
            isRePassword = false;

        }
    });
    $("#submit-a").click(function (event) {
        if (isOldPassword && isPassword && isRePassword) {
            event.preventDefault();
            $("#changePassword_form").submit();
        } else {
            alert("请先正确填写表单！");
            return false;
        }
    });

    $("#ul_menu_2").css({"display":""});
    $("#nav-span-2").removeClass("glyphicon-chevron-left").addClass("glyphicon-chevron-down");
});


function validateInfo(boxid, isSuccess, message) {
    var p = $("#" + boxid);
    p.removeClass("text-warning");
    p.removeClass("text-danger");
    p.removeClass("text-success");
    p.empty();
    var icon;
    if (isSuccess) {
        p.addClass("text-success");
        icon = $("<span class='glyphicon glyphicon-ok-circle'></span>");
    } else {
        p.addClass("text-danger");
        icon = $("<span class='glyphicon glyphicon-remove-circle'></span>");
    }
    var msg = $("<span>&nbsp;" + message + "</span>");
    p.append(icon);
    p.append(msg);
}
