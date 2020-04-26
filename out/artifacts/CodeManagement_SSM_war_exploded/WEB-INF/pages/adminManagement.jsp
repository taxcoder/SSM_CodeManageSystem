<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="include/include.jsp" %>
    <title>后台管理</title>
    <link href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/dashboard.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/header.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/sidebar.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.5.0.js"></script>
</head>

<body>

<jsp:include page="admin/header.jsp"/>

<!-- Begin page content -->
<div class="container-fluid">
    <div class="row">
        <jsp:include page="admin/sidebar.jsp"/>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <input type="hidden" id="result" value="${roleId}"/>
            <div style="font-size: 40px;color: orange;text-align: center;position:relative;top: 300px">
                ${adminName},欢迎访问后台
            </div>
        </div>
    </div>
</div>
<jsp:include page="include/footer.jsp"/>
</body>
<script>
    let result_input;
    $(function () {
        result_input = $("#result");
        $("#register-btn").click("on", function () {
            window.location.href = "free/register";
        });
        $("#login-btn").click("on", function () {
            window.location.href = "free/login";
        });

        $("#pages_show").hover(function () {
            $("#pages").fadeIn(1100);
        }, function () {
            $("#pages").fadeOut(1100);
        });
    });

    $(".nav-h3").click(function () {
        if($(this).next("ul").is(":visible")){
            $(this).children("span").removeClass("glyphicon glyphicon-chevron-down");
            $(this).children("span").addClass("glyphicon glyphicon-chevron-left");
            $(this).next("ul").slideUp();
        }else{
            $(this).children("span").removeClass("glyphicon glyphicon-chevron-left");
            $(this).children("span").addClass("glyphicon glyphicon-chevron-down");
            $(this).next("ul").slideDown();
        }
    });
</script>
</html>
