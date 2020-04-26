<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="include/include.jsp" %>
    <title>代码管理系统</title>
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.5.0.js"></script>
    <link href="${pageContext.request.contextPath }/static/bootstrap-3.3.7-dist/css/register.css" rel="stylesheet">
    <link href='https://fonts.useso.com/css?family=Lato:300,400,700' rel='stylesheet' type='text/css'>
    <script src="${pageContext.request.contextPath}/static/js/register.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/Bubble.js"></script>
</head>

<body>
<div class='soda'></div>
<div class="container" id="register_only">
    <div id="errormsg-box_one"></div>
    <div id="errormsg-box_two"></div>
    <div id="errormsg-box_three"></div>
    <form class="form-signin" id="register-form" method="post" action="${pageContext.request.contextPath}/user/register">
        <h2 class="form-signin-heading" id="Mobile">用户注册</h2>
        <input type="hidden" id="contextPath" value="${pageContext.request.contextPath}">
        <input type="hidden" id="ajax_username" value="${param.rt}">
        <label for="username" class="sr-only">用户名</label>
        <input type="text" id="username" name="username" class="form-control" placeholder="用户名" required autofocus autocomplete="off"/>
        <label for="password" class="sr-only">密码</label>
        <input type="password" id="password" name="password" class="form-control" placeholder="密码" required/>
        <label for="repassword" class="sr-only">重复密码</label>
        <input type="password" id="repassword" name="repassword" class="form-control" placeholder="重复密码" required/>
        <div style="margin-bottom: 20px;">
            <a href="${pageContext.request.contextPath}/home.jsp"><font color="white"><span class="glyphicon glyphicon-arrow-left">回首页</span></font></a>
            <a href="${pageContext.request.contextPath}/free/login" class="pull-right"><font color="white"><span class="glyphicon glyphicon-arrow">已注册，去登录</span><span class="glyphicon glyphicon-arrow-right"></span></font></a>
        </div>
        <a id="register" class="btn btn-lg btn-primary btn-block glyphicon glyphicon-arrow" href="#">注册</a>
    </form>
</div> <!-- /container -->
</body>

</html>

