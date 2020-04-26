<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="include/include.jsp" %>
    <title>代码管理系统</title>
    <link href="${pageContext.request.contextPath }/static/bootstrap-3.3.7-dist/css/dashboard.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath }/static/bootstrap-3.3.7-dist/css/header.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath }/static/bootstrap-3.3.7-dist/css/admin.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/sidebar.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.5.0.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/admin.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/same/Pages-style.js"></script>
</head>

<body>
<jsp:include page="include/header.jsp"/>

<!-- Begin page content -->
<div class="container-fluid">
    <div class="row">
        <jsp:include page="include/sidebar.jsp"/>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <h1 class="page-header">代码管理</h1>
            <div class="row placeholders">
                <div class="col-md-4">
                    <form action="">
                        <div class="input-group">
                            <label>
                                <input type="hidden" id="current" value="1">
                                <input type="hidden" id="current-input" value="${current}">
                                <input type="text" class="form-control" name="keyWord" id="keyWord-input"
                                       placeholder="按关键词查找">
                                <input type=hidden id="countPage" value="${countPage}">
                                <input type=hidden id="requestURI" value="${pageContext.request.requestURI}">
                                <input type=hidden id="address" value="${pageContext.request.contextPath}">
                            </label>
                            <span class="input-group-btn">
					        <button id="submit-select-data" class="btn btn-default" type="button"
                                    style="position:absolute; top: 0;left: 0"><span
                                    class="glyphicon glyphicon-refresh"></span></button>
					      </span>
                        </div><!-- /input-group -->
                    </form>
                </div>
            </div>
            <div class="table-responsive" style="min-height: 450px;max-height: 450px;min-width: 960px">
                <table id="table-append" class="table table-bordered  table-striped">
                    <tr>
                        <th width="5%">序号</th>
                        <th width="20%">代码文件</th>
                        <th width="35%">代码说明</th>
                        <th width="10%">上传者</th>
                        <th width="15%">上传时间</th>
                        <th width="15%">操作</th>
                    </tr>
                    <c:choose>
                        <c:when test="${not empty files}">
                            <c:forEach var="file" items="${files}" varStatus="status">
                                <tr class="success_data">
                                    <td>${(current * 5 - 5) + status.index + 1}</td>
                                    <td>
                                        <a href="${pageContext.request.contextPath}/file/download?n=${file.saveName}">${file.showName}</a>
                                    </td>
                                    <td>${file.fileDesc}</td>
                                    <td>${file.uploadUser}</td>
                                    <td><fmt:formatDate value="${file.uploadTime}" pattern="yyyy-MM-dd HH:mm:ss"/></td>
                                    <td align="center">
                                        <a class="btn btn-default btn-sm btn-success" href="${pageContext.request.contextPath}/file/codeedit/${file.id}" role="button">
                                            <span class="glyphicon glyphicon-edit"></span>&nbsp;修改</a>
                                        <button class="delete-button btn btn-default btn-sm btn-danger" value="${file.id}">
                                            <span class="glyphicon glyphicon-trash"></span>&nbsp;删除
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </c:when>
                        <c:otherwise>
                            <tr class="success_data">
                                <td colspan="6" style="text-align: center">暂无数据</td>
                            </tr>
                        </c:otherwise>
                    </c:choose>

                </table>
                <nav aria-label="Page navigation" class="text-right">
                    <div id="all-pages">
                        总页数：${allPages}页
                    </div>
                    <ul class="pagination">
                        <li id="up-page" class="disabled a1"><a aria-label="Previous"><span
                                aria-hidden="true">&laquo;</span></a></li>
                        <li id="a1" class="active midden-li"><a>1 <span class="sr-only"></span></a></li>
                        <li id="a2" class="midden-li"><a>2</a></li>
                        <li id="a3" class="midden-li"><a>3</a></li>
                        <li id="a4" class="midden-li"><a>4</a></li>
                        <li id="a5" class="midden-li"><a>5</a></li>
                        <li id="down-page">
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
</body>
</html>
