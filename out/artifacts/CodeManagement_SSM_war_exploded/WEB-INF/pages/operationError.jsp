<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>业务异常</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/bootstrap-3.3.7-dist/css/bootstrap.css">
    <link href="${pageContext.request.contextPath}/static/css/sidebar.css" rel="stylesheet">
    <style>
        body {
            background-color: #a6e1ec;
            height: 100%;

        }

        .error_div {
            position: relative;
            min-width: 320px;
            width: 320px;
            height: 250px;
            top: 190px;
            right: -620px;
        }

        #Tips {
            position: relative;
            text-align: center;
            width: 320px;
            height: 25px;
            font-weight: bold;
            font-size: 20px;
            top: 25px;
        }

        #resource {
            position: relative;
            width: 320px;
            height: 35px;
            top: 115px;
        }

        .glyphicon-remove-circle {
            color: red;
            font-size: 120px;

        }

        .label_lose {
            font-size: 50px;
            font-weight: bold;
            position: relative;
            top: -40px;
        }

        #again_register {
            top: 445px;
            right: 215px;
        }

        #return {
            float: right;
        }
    </style>
</head>
<body>
<div class="error_div">
    <div id="nesting_register">
        <span class="glyphicon glyphicon-remove-circle"><label class="label_lose">
        <c:choose>
            <c:when test="${param.error == '4'}">
                登录异常
            </c:when>
            <c:when test="${param.error == '3'}">
                删除失败
            </c:when>
            <c:when test="${param.error == '2'}">
                上传失败
            </c:when>
            <c:when test="${param.error == '1'}">
                修改失败
            </c:when>
            <c:when test="${param.error == '0'}">
                注册失败
            </c:when>
            <c:otherwise>
                业务异常
            </c:otherwise>
        </c:choose>
        </label></span>
    </div>
    <div id="Tips">
        <c:choose>
            <c:when test="${param.error == '4'}">
                登录
            </c:when>
            <c:when test="${param.error == '3'}">
                删除
            </c:when>
            <c:when test="${param.error == '2'}">
                上传
            </c:when>
            <c:when test="${param.error == '1'}">
                修改
            </c:when>
            <c:when test="${param.error == '0'}">
                注册
            </c:when>
            <c:otherwise>
               业务
            </c:otherwise>
        </c:choose>
        出现异常，请稍后再试！
    </div>
    <div id="resource">

        <c:choose>
            <c:when test="${param.error == '4'}">
                <a href="${pageContext.request.contextPath}/admin/adminLogin" class="btn btn-primary" id="again_register">
                    重新登录
                </a>
            </c:when>
            <c:when test="${param.rror == '3'}">
                <a href="${pageContext.request.contextPath}/file/myFile" class="btn btn-primary" id="again_register">
                    个人文件
                </a>
            </c:when>
            <c:when test="${param.error == '2'}">
                <a href="${pageContext.request.contextPath}/free/upload" class="btn btn-primary" id="again_register">
                    重新上传
                </a>
            </c:when>
            <c:when test="${param.error == '1'}">
                <a href="${pageContext.request.contextPath}/free/changePassword" class="btn btn-primary" id="again_register">
                    重新修改
                </a>
            </c:when>
            <c:when test="${param.error == '0'}">
                <a href="${pageContext.request.contextPath}/free/register" class="btn btn-primary" id="again_register">
                    重新注册
                </a>
            </c:when>
            <c:otherwise>
                <a href="${pageContext.request.contextPath}/free/login" class="btn btn-primary" id="again_register">
                    重新登录
                </a>
            </c:otherwise>
        </c:choose>

        <a href="${pageContext.request.contextPath}/home.jsp" class="btn btn-success" id="return">返回首页</a>
    </div>
</div>
</body>
</html>
