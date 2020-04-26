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
    <script src="${pageContext.request.contextPath}/static/js/recycle.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/same/Pages-style.js"></script>

</head>

<body>
<jsp:include page="include/header.jsp"/>

<!-- Begin page content -->
<div class="container-fluid">
    <div class="row">
        <jsp:include page="include/sidebar.jsp"/>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h1 class="page-header">回收站</h1>
            <div class="row placeholders">
                <div class="col-md-4">
                        <div class="input-group">
                            <input type="hidden" id="current-recycle" value="1">
                            <input type="text" id="keyWord-Data" class="form-control" name="keyWord"
                                   placeholder="按关键字查找">
                            <input type=hidden id="countPage" value="${countPage}">
                            <input type=hidden id="current" value="${current}">
                            <input type=hidden id="requestURI" value="${pageContext.request.requestURI}">
                            <input type=hidden id="address" value="${pageContext.request.contextPath}">
                            <span class="input-group-btn">
					        <a id="submit-data" class="btn btn-default"><span class="glyphicon glyphicon-refresh"></span></a>
					      </span>
                        </div><!-- /input-group -->
                </div>
            </div>
            <div class="table-responsive" style="min-height: 334px">
                <table class="table table-bordered  table-striped" id="table_append">
                    <tr>
                        <th width="5%">序号</th>
                        <th width="30%">代码文件</th>
                        <th width="30%">代码说明</th>
                        <th width="15%">删除时间</th>
                        <th width="15%">操作</th>
                    </tr>
                    <c:choose>
                        <c:when test="${not empty recycles}">
                            <c:forEach var="recycle" items="${recycles}" varStatus="status">
                                <tr class="success_data">
                                    <td>${(current * 5 - 5) + status.index + 1}</td>
                                    <td>${recycle.showName}</td>
                                    <td>${recycle.fileDesc}</td>
                                    <td><fmt:formatDate value="${recycle.deleteTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    <td align="center" class="button-click">
                                    <a class="btn btn-default btn-sm btn-success" href="${pageContext.request.contextPath}/file/deleteFileWithdraw/${recycle.id}" role="button">
                                        <span class='glyphicon glyphicon-edit'></span>&nbsp;撤回</a>
                                    <button class="delete-button btn btn-default btn-sm btn-danger" value="${recycle.id}">
                                        <span  class="glyphicon glyphicon-trash"></span>&nbsp;删除</button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr class="success_data">
                                <td colspan="5" style="text-align: center">暂无数据</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>
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

</script>
</body>
</html>
