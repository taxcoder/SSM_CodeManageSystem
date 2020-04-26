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
                                <input type="text" class="form-control" name="keyWord" id="keyWord" placeholder="按关键词查找">
                                <input type=hidden id="countPage" value="${requestScope.countPage}">
                                <input type=hidden id="address" value="${pageContext.request.contextPath}">
                                <input type=hidden id="currentPage" value="">
                            </label>
                            <span class="input-group-btn">
					        <button id="submit-select-data" class="btn btn-default" type="button" style="position:absolute; top: 0;left: 0"><span class="glyphicon glyphicon-refresh"></span></button>
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

				</table>
				<nav aria-label="Page navigation" class="text-right">
                    <div id="all-pages">
                        总页数：${requestScope.allPages}页
                    </div>
				  <ul class="pagination">
				    <li id="up-page" class="disabled a1"><a href="#" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
    				<li id="a1" class="active midden-li"><a href="#">1 <span class="sr-only"></span></a></li>
				    <li id="a2" class="midden-li"><a href="#">2</a></li>
				    <li id="a3" class="midden-li"><a href="#">3</a></li>
				    <li id="a4" class="midden-li"><a href="#">4</a></li>
				    <li id="a5" class="midden-li"><a href="#">5</a></li>
				    <li id="down-page">
				      <a href="#" aria-label="Next">
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
            $(".remove-link").click(function(){
                let url = $(this).attr("href");
                let form = $("<form method='POST'></form>");
                form.attr("action", url);
                let hidden = $("<input type='hidden' name='_method' value='DELETE'/>");
                form.append(hidden);
                form.submit();
                return false;
            });
        });
	</script>
  </body>
</html>
