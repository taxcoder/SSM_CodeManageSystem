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
            <a class="navbar-brand">
                <img src="${pageContext.request.contextPath }/static/images/logo.png" alt="" width="55px" height="55px">
            </a>
            <a class="navbar-brand" href="${pageContext.request.contextPath }/admin/adminManagement">
                <h2 style="margin:10px;"><span style="color:#02e207;">代码</span>管理系统<span style="color:#3f92ea;">(后台)</span></h2>
            </a>
        </div>
        <!-- 登录用户信息 -->
        <div id="navbar" class="navbar-collapse collapse" style="height: 80px;">
            <ul class="nav navbar-nav navbar-right" style="padding:15px 15px 0 0;">
                <li class="dropdown">
                    <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button"
                       aria-haspopup="true" aria-expanded="false"><span style="font-size: 18px;" id="pages_show">
                                <span id="remove-span"
                                      class="glyphicon glyphicon-user"></span>&nbsp;${sessionScope.user.username}
                                <span id="remove-suspension" class="glyphicon glyphicon-triangle-left"
                                      style="font-size: 14px"></span></a>
                </li>
            </ul>
        </div>
        <div id="pages" style="display: none;">
            <div class="glyphicon glyphicon-triangle-top" id="arrow-back"></div>
            <div id="hide_area" style="height: 50px">
                <a href="${pageContext.request.contextPath}/admin/loginOut"><span
                        class="glyphicon glyphicon-log-out changePassword" style="position:absolute; top: 16px; right: 16px;height: 30px">&nbsp;退出后台</span></a>
            </div>
        </div>
    </div>
</nav>