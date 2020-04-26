<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="include/include.jsp" %>
    <title>代码管理系统</title>

    <!-- CSS -->
    <link href="${pageContext.request.contextPath }/static/bootstrap-3.3.7-dist/css/signin.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/login/snowflake.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.5.0.js"></script>
</head>

<body>
<canvas id="world"></canvas>
<div class="container" id="move">
    <form class="form-signin" action="${pageContext.request.contextPath}/user/login" method="post">
        <h2 class="form-signin-heading" id="user_login">用户登录</h2>
        <div id="login_lose"><span id="connection"><c:if test="${param.error == '1'}">用户名或密码错误</c:if></span></div>
        <label for="username" class="sr-only">用户名</label>
        <input type="text" id="username" name="username" class="form-control" placeholder="用户名" required autocomplete="off">
        <label for="password" class="sr-only">密码</label>
        <input type="password" id="password" name="password" class="form-control" placeholder="密码" required>
        <div style="margin-bottom: 20px;">
            <div style="margin-bottom: 20px;">
                <a href="${pageContext.request.contextPath}/home.jsp"><span class="glyphicon glyphicon-arrow-left"></span><b>回首页</b></a>
                <a href="${pageContext.request.contextPath}/free/register" class="pull-right"><b>注册新用户</b><span class="glyphicon glyphicon-arrow-right"></span></a>
            </div>
            <button class="btn btn-lg btn-primary btn-block" type="submit">登录</button>
        </div>
    </form>
</div> <!-- /container -->
<script src="${pageContext.request.contextPath}/static/js/login.js"></script>
<script src="${pageContext.request.contextPath}/static/login/snowflake.js"></script>
</body>
</html>
