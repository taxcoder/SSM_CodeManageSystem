<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<nav class="navbar navbar-inverse navbar-fixed-top" style="height: 80px;">
    <div class="container-fluid">
        <div class="navbar-header" style="height: 80px;">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                    aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="${pageContext.request.contextPath}/free/login">
                <img src="${pageContext.request.contextPath }/static/images/logo.png" alt="" width="55px" height="55px">
            </a>
            <a class="navbar-brand" href="${pageContext.request.contextPath }/home.jsp">
                <h2 style="margin:10px;"><span style="color:#02e207;">代码</span>管理系统</h2>
            </a>
        </div>

        <c:choose>
            <c:when test="${empty sessionScope.user}">
                <!-- 登录表单 -->
                <div id="navbar_1" class="navbar-collapse collapse" style="height: 80px;">
                    <ul class="nav navbar-nav navbar-right" style="padding:15px 15px 0 0;">
                        <li>
                            <button id="login-btn" type="button" class="btn btn-success" style="margin: 10px;"><span
                                    class="glyphicon glyphicon-log-in"></span>&nbsp;登录
                            </button>
                        </li>
                        <li>
                            <button id="register-btn" type="button" class="btn btn-info" style="margin: 10px;"><span
                                    class="glyphicon glyphicon-user"></span>&nbsp;注册
                            </button>
                        </li>
                    </ul>
                </div>
            </c:when>
            <c:otherwise>
                <!-- 登录用户信息 -->
                <div id="navbar" class="navbar-collapse collapse" style="height: 80px;">
                    <ul class="nav navbar-nav navbar-right" style="padding:15px 15px 0 0;">
                        <li class="dropdown">
                            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                               aria-haspopup="true" aria-expanded="false"><span style="font-size: 18px;" id="pages_show">
                                <span id="remove-span" class="glyphicon glyphicon-user"></span>&nbsp;${sessionScope.user.username}
                                <span id="remove-suspension" class="glyphicon glyphicon-triangle-left" style="font-size: 14px"></span></a>
                        </li>
                    </ul>
                </div>
                <div id="pages" style="display: none">
                    <div class="glyphicon glyphicon-triangle-top" id="arrow"></div>
                    <div id="hide_area">
                        <a href="${pageContext.request.contextPath}/user/updatePassword"><span
                                class="glyphicon glyphicon-cog changePassword" id="alterPassword">&nbsp;修改密码</span></a>
                        <a href="${pageContext.request.contextPath}/free/loginOut"><span
                                class="glyphicon glyphicon-log-out changePassword" id="loginOut">&nbsp;退出登录</span></a>
                        <a href="${pageContext.request.contextPath}/admin/adminLogin"><span
                                class="glyphicon glyphicon-log-out changePassword" id="adminPage">&nbsp;进入后台</span></a>

                    </div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</nav>
