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
    <script src="${pageContext.request.contextPath}/static/js/codeList.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/home.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/same/Pages-style.js"></script>

</head>

<body>
<jsp:include page="include/header.jsp"/>

<!-- Begin page content -->
<div class="container-fluid">
    <div class="row">
        <jsp:include page="include/sidebar.jsp"/>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h1 class="page-header">代码总览</h1>
            <div class="row placeholders">
                <div class="col-md-4">
                        <div class="input-group">
                            <input type="text" id="keyWord" class="form-control" name="keyWord"
                                   placeholder="按上传者和代码文件查找">
                            <input type=hidden id="countPage" value="${countPage}">
                            <input type=hidden id="current" value="${current}">
                            <input type=hidden id="requestURI" value="${pageContext.request.requestURI}">
                            <input type=hidden id="address" value="${pageContext.request.contextPath}">
                            <span class="input-group-btn">
					        <a id="submit-select-data" class="btn btn-default"><span
                                    class="glyphicon glyphicon-refresh"></span></a>
					      </span>
                        </div><!-- /input-group -->
                </div>
            </div>
            <div class="table-responsive" style="min-height: 334px">
                <table class="table table-bordered  table-striped" id="table_append">
                    <tr>
                        <th width="5%">序号</th>
                        <th width="35%">代码文件</th>
                        <th width="35%">代码说明</th>
                        <th width="10%">上传者</th>
                        <th width="15%">上传时间</th>
                    </tr>
                    <c:choose>
                        <c:when test="${not empty files}">
                            <c:forEach var="file" items="${files}" varStatus="status">
                                <tr class="success_data">
                                    <td>${(current * countPage - countPage) + status.index + 1}</td>
                                    <td><a href="${pageContext.request.contextPath}/file/download?n=${file.saveName}">${file.showName}</a></td>
                                    <td>${file.fileDesc}</td>
                                    <td>${file.uploadUser}</td>
                                    <td><fmt:formatDate value="${file.uploadTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
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
                        <li id="up-page"><a aria-label="Previous"><span
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
    $("#ul_menu_1").css({"display":""});
    $("#nav-span-1").removeClass("glyphicon-chevron-left").addClass("glyphicon-chevron-down");
</script>
</body>
</html>
