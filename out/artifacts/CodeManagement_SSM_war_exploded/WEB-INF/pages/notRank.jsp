<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="include/include.jsp" %>
    <title>代码管理系统</title>
    <link href="${pageContext.request.contextPath }/static/bootstrap-3.3.7-dist/css/dashboard.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/sidebar.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.5.0.js"></script>
</head>

<body>

<jsp:include page="include/header.jsp"/>

<!-- Begin page content -->
<div class="container-fluid">
    <div class="row">
        <jsp:include page="include/sidebar.jsp"/>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="text-center">
                <h1 class="text-danger"><span class="glyphicon glyphicon-remove-circle" style="position: relative; top:6px;"></span>&nbsp;权限错误，您的权限不足！</h1>
                <hr>
            </div>
        </div>
    </div>
</div>
<jsp:include page="include/footer.jsp"/>
<script>
    $("#register-btn").click("on", function () {
        window.location.href = "register";
    });
    $("#login-btn").click("on", function () {
        window.location.href = "login";
    });
</script>
</body>
</html>
