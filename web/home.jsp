<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="WEB-INF/pages/include/include.jsp" %>
    <title>代码管理系统</title>
    <link href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/dashboard.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/header.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/sidebar.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.5.0.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/home.js"></script>
</head>

<body>
<jsp:include page="WEB-INF/pages/include/header.jsp"/>

<!-- Begin page content -->
<div class="container-fluid">
    <div class="row">
        <jsp:include page="WEB-INF/pages/include/sidebar.jsp"/>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <input type="hidden" id="result" value="${param.result}"/>
            <input type="hidden" id="address" value="${pageContext.request.contextPath}"/>
            <h1 class="page-header">关于本系统</h1>
            <div>
                <p>
                    本系统针对Web程序设计（JSP）课程的教学和实训所设计开发。
                </p>
                <p>
                    通过对本系统的开发，学生掌握：<br/>
                </p>
                <ul>
                    <li>网站的HTML静态页面模型的制作</li>
                    <li>使用MySQL根据网站需求设计和实现数据库</li>
                    <li>掌握Servlet技术</li>
                    <li>掌握Filter过滤器技术</li>
                    <li>掌握Listener监听器技术</li>
                    <li>掌握JSP技术</li>
                    <li>掌握JSTL和EL</li>
                    <li>JSP的MVC实现</li>
                </ul>
            </div>
        </div>
    </div>
</div>
<jsp:include page="WEB-INF/pages/include/footer.jsp"/>
</body>
<script>
    let result_input;
    $(function () {
        result_input = $("#result");
        if (result_input.val().length !== 0) {
            alert(result_input.val());
            result_input.val("");
        }
        $("#ul_menu_1").css({"display":""});
        $("#nav-span-1").removeClass("glyphicon-chevron-left").addClass("glyphicon-chevron-down");
    });
</script>
</html>
