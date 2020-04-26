<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="include/include.jsp" %>
    <title>代码管理系统</title>
    <link href="${pageContext.request.contextPath }/static/bootstrap-3.3.7-dist/css/dashboard.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath }/static/bootstrap-3.3.7-dist/css/header.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/sidebar.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.5.0.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/changePassword.js"></script>
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
                        <input type="hidden" id="address" value="${pageContext.request.contextPath}"/>
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
</body>
</html>
