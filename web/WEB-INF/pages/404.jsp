<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
  <head>
  	<%@ include file="include/include.jsp" %>
    <title>代码管理系统</title>
	<link href="${pageContext.request.contextPath }/static/bootstrap-3.3.7-dist/css/dashboard.css" rel="stylesheet">
  </head>

  <body>

    <jsp:include page="include/header.jsp"/>

    <!-- Begin page content -->
    <div class="container-fluid">
      <div class="row">
        <jsp:include page="include/sidebar.jsp"/>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<div class="text-center">
				<h1 class="text-danger"><span class="glyphicon glyphicon-remove-circle" style="position: relative; top:6px;"></span>&nbsp;404异常</h1>
				<hr>
				<div style="font-size: 20px;">
					<p>您请求的资源不存在，请与管理员联系</p>
					<p>您也可以返回<a href="${pageContext.request.contextPath }/home.jsp">首页</a></p>
				</div>
			</div>
        </div>
      </div>
    </div>
    <jsp:include page="include/footer.jsp"/>
  </body>
</html>
