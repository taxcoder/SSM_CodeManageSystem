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
    <script src="${pageContext.request.contextPath}/static/js/home.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/userList.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/same/Pages-style.js"></script>

</head>

<body>
<jsp:include page="admin/header.jsp"/>

<!-- Begin page content -->
<div class="container-fluid">
    <div class="row">
        <jsp:include page="admin/sidebar.jsp"/>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h1 class="page-header">代码总览</h1>
            <div class="row placeholders">
                <div class="col-md-4">
                        <div class="input-group">
                            <input type="text" id="keyWord" class="form-control" name="keyWord"
                                   placeholder="按用户名进行查找">
                            <input type=hidden id="countPage" value="${countPage}">
                            <input type=hidden id="currentUserList" value="1">
                            <input type=hidden id="informationCurrent" value="${current}">
                            <input type=hidden id="requestURI" value="${pageContext.request.requestURI}">
                            <input type=hidden id="address" value="${pageContext.request.contextPath}">
                            <span class="input-group-btn">
					        <a id="submit-select-data" class="btn btn-default" href=""><span
                                    class="glyphicon glyphicon-refresh"></span></a>
					      </span>
                        </div><!-- /input-group -->
                </div>
            </div>
            <div class="table-responsive" style="min-height: 334px;min-width: 940px">
                <table class="table table-bordered  table-striped" id="table_append">
                    <tr>
                        <th width="5%">序号</th>
                        <th width="25%">用户名</th>
                        <th width="10%">角色</th>
                        <th width="15%">注册时间</th>
                        <th width="15%">操作</th>
                    </tr>
                        <c:forEach var="user" items="${users}" varStatus="status">
                            <tr class="success_data">
                            <td>${(current * countPage - countPage) + status.index + 1}</td>
                            <td><a class="click-a">${user.username}</a></td>
                            <td >${user.userRoleName}</td>
                            <td><fmt:formatDate value="${user.registerTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                            <td align="center">
                                <button class="btn btn-default btn-sm btn-success return-file" value="${user.id}">
                                    <span class="glyphicon glyphicon-edit"></span>&nbsp;查看
                                </button>
                                <button class="delete-button btn btn-default btn-sm btn-danger" value="${user.id}/${user.roleId}">
                                    <span class="glyphicon glyphicon-trash"></span>&nbsp;删除
                                </button>
                            </td>
                    </tr>
                        </c:forEach>

                </table>
                <nav aria-label="Page navigation" class="text-right">
                    <div id="all-pages">
                        总页数：${allPages}页
                    </div>
                    <ul class="pagination">
                        <li class="" id="up-page"><a aria-label="Previous"><span
                                aria-hidden="true">&laquo;</span></a></li>
                        <li id="a1" class="active midden-li"><a class="midden-a">1</a></li>
                        <li id="a2" class="midden-li"><a class="midden-a">2</a></li>
                        <li id="a3" class="midden-li"><a class="midden-a">3</a></li>
                        <li id="a4" class="midden-li"><a class="midden-a">4</a></li>
                        <li id="a5" class="midden-li"><a class="midden-a">5</a></li>
                        <li class="midden-a" id="down-page">
                            <a aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </ul>
                </nav>
            </div>
        </div>
    </div>
</div>
<jsp:include page="include/footer.jsp"/>
<script>
    $(function () {
        let current_a = $(".pagination .midden-li").find("a");
        for (let i=0;i<current_a.length;++i){
            if(current_a.eq(i).text() === $("#informationCurrent").val()){
                current_a.eq(i).parent().removeClass("active").addClass("active").siblings().removeClass("active");
            }
        }
        $(".nav-h3").click(function () {
            if ($(this).next("ul").is(":visible")) {
                $(this).children("span").removeClass("glyphicon glyphicon-chevron-down");
                $(this).children("span").addClass("glyphicon glyphicon-chevron-left");
                $(this).next("ul").slideUp();
            } else {
                $(this).children("span").removeClass("glyphicon glyphicon-chevron-left");
                $(this).children("span").addClass("glyphicon glyphicon-chevron-down");
                $(this).next("ul").slideDown();
            }
        });
        $("#ul_menu_2").css({"display": ""});
        $("#nav-span-2").removeClass("glyphicon-chevron-left").addClass("glyphicon-chevron-down");
        if (keyword.val().length === 0) {
            submit_data.addClass("disabled").css({"background": "gray"});
        } else {
            submit_data.removeClass("disabled").css({'background': 'white'});
        }
    });
</script>
</body>
</html>
