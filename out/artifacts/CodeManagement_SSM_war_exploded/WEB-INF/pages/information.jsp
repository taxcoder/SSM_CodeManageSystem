<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="C" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="include/include.jsp" %>
    <title>代码管理系统</title>
    <link href="${pageContext.request.contextPath }/static/bootstrap-3.3.7-dist/css/dashboard.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath }/static/bootstrap-3.3.7-dist/css/header.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath }/static/bootstrap-3.3.7-dist/css/codeList.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/sidebar.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.5.0.js"></script>
    <style>
        #return-userList {
            width: 80px;
            height: 35px;
            background: #9f9faa;
            color: white;
            border-radius: 5px;
            position: relative;
            right: -48px;
            top: 30px;
        }

        #changeRank {
            width: 80px;
            height: 35px;
            background: #5151fb;
            color: white;
            border-radius: 5px;
            position: relative;
            right: -126px;
            top: 30px;
        }

        #changeRoleName{
            width: 50%;
            float: right;
            min-width: 468px;
            height: 399px;
            border-left: 2px orange dashed;
            display: none;
        }
        #select-option {
            text-align: center;
            height: 25px;
            color: blue;
            background: #f9dddd;
            border-radius: 5px;
            width: 130px;
        }

        #changeRole {
            width: 80px;
            height: 35px;
            background: #ce9e2c;
            color: black;
            border-radius: 5px;
            position: relative;
            right: 6px;
            top: 91px;
        }
    </style>
</head>

<body>
<jsp:include page="admin/header.jsp"/>

<!-- Begin page content -->
<div class="container-fluid">
    <div class="row">
        <jsp:include page="admin/sidebar.jsp"/>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h1 class="page-header">用户信息</h1>
            <div style="min-width: 936px">
                <input type="hidden" id="inputCurrent" value="${current}">
                <input type="hidden" id="roleId" value="${roleId}">
                <input type="hidden" id="userRoleId" value="${user.roleId}">
                <input type="hidden" id="pageAddress" value="${pageContext.request.contextPath}">
                <div style="height: 399px;width: 50%;float: left;min-width: 468px">
                    <h3><p id="userId">用&nbsp;户&nbsp;&nbsp;ID：${user.id}</p></h3>
                    <h3><p id="username">用&nbsp;户&nbsp;&nbsp;名：${user.username}</p></h3>
                    <h3><p id="roleName">角&nbsp;色&nbsp;&nbsp;名：${user.userRoleName}</p></h3>
                    <h3><p id="registerTime">注册时间：<fmt:formatDate value="${user.registerTime}" pattern="yyyy-MM-dd HH:mm:ss"/></p></h3>
                    <h3><p id="changePasswordTime">修改时间：${changePasswordTime}</p></h3>
                    <button id="return-userList">返回</button>
                    <button id="changeRank">修改权限</button>
                </div>
                <div id="changeRoleName">
                    <h2 style="text-align: center;color:red;">用户名</h2>
                    <h3 style="text-align: center;margin: 30px">${user.username}</h3>
                    <div style="text-align: center">
                        <label for="select-option"></label><select style="text-align: center;margin: 10px"
                                                                   id="select-option">
                        <option value="3" selected>普通用户</option>
                        <option value="2">普通管理员</option>
                        <option value="1">高级管理员</option>
                    </select>
                        <p id="result-span">&nbsp;</p>
                    </div>
                    <div style="text-align: center">
                        <button id="changeRole">修改</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="include/footer.jsp"/>
<script>
    $(function () {
        $("#ul_menu_2").css({"display": ""});
        $("#nav-span-2").removeClass("glyphicon-chevron-left").addClass("glyphicon-chevron-down");
        $("#changeRank").click(function () {
            $("#changeRoleName").css({"display":"block"});
        });
        $("#pages_show").hover(function () {
            $("#pages").fadeIn(1100);
        },function () {
            $("#pages").fadeOut(1100);
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
        $("#return-userList").click(function () {
            window.location.href = $("#pageAddress").val()+"/admin/userList/"+$("#inputCurrent").val();
        });
    });
    $("#select-option").change("on",function () {
        let result = $("#result-span");
        if($("#roleId").val() === '1'){
            result.children("span").remove();
            result.append("<span class='glyphicon glyphicon-ok-circle' id='fileClass' style='color:green;'></span>");
        }else{
            result.children("span").remove();
            result.append("<span class='glyphicon glyphicon-remove-sign' id='fileClass' style='color:red;'>您的权限不够</span>");
        }
    });

    $("#changeRole").click(function () {
        let userId = $("#userId");
        if($("#roleId").val() === '1' && parseInt($("#userRoleId").val()) !== 1){
            $.get({
                url: $("#pageAddress").val()+"/admin/updateRank/"+userId.text().substring(userId.text().lastIndexOf("：")+1)+"/"+$("#select-option").val(),
                success:function (data) {
                    if(data === "success"){
                        alert("修改成功！");
                    }else{
                        alert("修改失败！");
                    }
                },
                error:function (data) {
                    alert("出现异常，修改失败!");
                    window.location.replace($("#pageAddress").val()+"/admin/userList/"+$("#inputCurrent").val());
                }
            });
        }else{
            let result = $("#result-span");
            result.children("span").remove();
            result.append("<span class='glyphicon glyphicon-remove-sign' id='fileClass' style='color:red;'>您的权限不够</span>");
        }
    });
</script>
</body>
</html>
