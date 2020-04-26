<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="include/include.jsp" %>
    <title>代码管理系统</title>
    <link href="${pageContext.request.contextPath }/static/bootstrap-3.3.7-dist/css/dashboard.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath }/static/bootstrap-3.3.7-dist/css/header.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.5.0.js"></script>
</head>

<body>

<jsp:include page="include/header.jsp"/>

<!-- Begin page content -->
<div class="container-fluid">
    <div class="row">
        <jsp:include page="include/sidebar.jsp"/>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h1 class="page-header">修改密码</h1>
            <div class="row placeholders">
                <div class="col-md-8">
                    <form id="changePassword_form" class="form-horizontal"
                          action="${pageContext.request.contextPath }/user/changePassword" method="post">
                        <input type="hidden" name="id" value="${sessionScope.user.id}"/>
                        <div class="form-group">
                            <label for="oldPassword" class="col-sm-2 control-label">原密码</label>
                            <div class="col-sm-5">
                                <input type="password" class="form-control" name="oldPassword" id="oldPassword"
                                       placeholder="原密码">
                                <input type="hidden" id="oldPassword_resource" value="">
                            </div>
                            <div class="col-sm-5">
                                <p id="oldPassword_info" class="text-warning text-left"
                                   style="font-size: 16px; padding-top: 4px;"><span
                                        class="glyphicon glyphicon-info-sign"></span>&nbsp;请输入您原有的密码</p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="password" class="col-sm-2 control-label">新密码</label>
                            <div class="col-sm-5">
                                <input type="password" class="form-control" name="password" id="password"
                                       placeholder="新密码">
                            </div>
                            <div class="col-sm-5">
                                <p id="password_info" class="text-warning text-left"
                                   style="font-size: 16px; padding-top: 4px; min-width: 570px"><span
                                        class="glyphicon glyphicon-info-sign"></span>&nbsp;请输入您要修改的密码</p>
                            </div>
                        </div>
                        <div class="form-group">
                            <label for="rePassword" class="col-sm-2 control-label">确认密码</label>
                            <div class="col-sm-5">
                                <input type="password" class="form-control" name="rePassword" id="rePassword"
                                       placeholder="确认密码">
                            </div>
                            <div class="col-sm-5">
                                <p id="rePassword_info" class="text-warning text-left"
                                   style="font-size: 16px; padding-top: 4px; min-width: 400px"><span
                                        class="glyphicon glyphicon-info-sign"></span>&nbsp;请重复输入您要修改的密码以确认正确</p>
                            </div>
                        </div>

                        <div class="form-group">
                            <div class="col-sm-offset-2 col-sm-5">
                                <button id="submit-a" type="button" class="btn btn-success btn-block">提交修改</button>
                            </div>
                        </div>
                    </form>
                </div>
            </div>

        </div>
    </div>
</div>
<jsp:include page="include/footer.jsp"/>
<script type="text/javascript">
    $(function () {
        let oldPassword = $("#oldPassword");
        let resource = $("#oldPassword_resource");
        let isOldPassword = false, isPassword = false, isRePassword = false;

        oldPassword.blur(function () {
            $.post({
                url: "${pageContext.request.contextPath}/user/judgePassword",
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
                    window.location.href = "${pageContext.request.contextPath}/free/sysError";
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

    $("#register-btn").click("on", function () {
        window.location.href = "${pageContext.request.contextPath}/free/register";
    });
    $("#login-btn").click("on", function () {
        window.location.href = "${pageContext.request.contextPath}/free/login";
    });

    $("#pages_show").hover(function () {
        $("#pages").fadeIn(1100);
    }, function () {
        $("#pages").fadeOut(1100);
    });
</script>

</body>
</html>
