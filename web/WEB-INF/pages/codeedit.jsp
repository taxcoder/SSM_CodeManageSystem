<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
  <head>
    <%@ include file="include/include.jsp" %>
    <title>代码管理系统</title>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath }/static/bootstrap-3.3.7-dist/css/dashboard.css">
      <link href="${pageContext.request.contextPath}/static/css/sidebar.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.5.0.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/codeEdit.js"></script>
  </head>

  <body>
    <jsp:include page="include/header.jsp"/>

    <!-- Begin page content -->
    <div class="container-fluid">
      <div class="row">
        <jsp:include page="include/sidebar.jsp"/>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
        	<h1 class="page-header">代码上传</h1>
        	<div class="row placeholders">
        		<div class="col-md-8">
		        	<form action="${pageContext.request.contextPath}/file/updateFile" class="form-horizontal" method="POST" id="from_codeEdit">
					  <input type="hidden" name="id" value="${file.id}"/>
					  <div class="form-group">
					    <label for="showName" class="col-sm-2 control-label" id="codeFile">代码文件</label>
					    <div class="col-sm-5">
                            <label for="showName"></label><input type="text" class="form-control" id="showName" name="showName" placeholder="代码名称" value="${file.showName}">
					    </div>
					    <div class="col-sm-5" id="add_showName_p">
					    </div>
					  </div>
					  <div class="form-group">
					    <label for="fileDesc" class="col-sm-2 control-label">代码说明</label>
					    <div class="col-sm-5">
					      <textarea class="form-control" id="fileDesc" name="fileDesc" placeholder="代码说明" rows="5"  style="resize:none;">${file.fileDesc}</textarea>
					    </div>
					    <div class="col-sm-5" id="add_fileDesc_p">
					    </div>
					  </div>
					  <div class="form-group">
					    <div class="col-sm-offset-2 col-sm-5">
					      <a href="#" id="codeEdit_submit" class="btn btn-success btn-block">提交</a>
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
