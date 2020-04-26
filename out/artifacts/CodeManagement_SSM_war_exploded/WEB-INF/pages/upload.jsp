<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="include/include.jsp" %>
    <title>代码管理系统</title>
    <link type="text/css" rel="stylesheet"
          href="${pageContext.request.contextPath }/static/bootstrap-3.3.7-dist/css/dashboard.css">
    <link type="text/css" rel="stylesheet"
          href="${pageContext.request.contextPath }/static/bootstrap-fileinput-master/css/fileinput.css"/>
    <link href="${pageContext.request.contextPath}/static/css/sidebar.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath }/static/bootstrap-3.3.7-dist/css/header.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.5.0.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/upload.js"></script>
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
                    <input type="hidden" id="address" value="${pageContext.request.contextPath}"/>
                    <form action="${pageContext.request.contextPath}/file/code" id="formSubmit" method="POST"
                          enctype="multipart/form-data" autocomplete="off">

                        <div class="form-group">

                            <div class="col-sm-5">
                                <input type="file" class="form-control file" id="codefile" name="codefile"
                                       placeholder="代码文件" data-msg-placeholder="请选择文件" data-show-preview="false"
                                       data-show-upload="false">
                                <input type="hidden" name="fileDesc" value="" id="fileDesc"/>
                            </div>

                            <div class="col-sm-5">
                                <p class="text-warning text-left" id="file-text"
                                   style="font-size: 16px; padding-top: 4px;"><span
                                        class="glyphicon glyphicon-info-sign" id="fileClass">上传文件限定于.zip，.rar文件，文件大小不超过20M</span>
                                </p>
                            </div>


                            <div class="col-sm-5">
                                <label for="intro"></label><textarea class="form-control" id="intro" name="intro"
                                                                     placeholder="代码说明" rows="5"
                                                                     style="resize:none; height: 140px;"></textarea>
                            </div>

                            <div class="col-sm-5">
                                <p class="text-danger text-left"
                                   style="font-size: 16px; padding-top: 4px;" id="not_null"></p>
                            </div>

                            <div class="col-sm-5" id="submit_upload_a">
                                <a href="#" class="btn btn-success btn-block" id="button_submit_file"><b color="white">提交</b></a>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
<jsp:include page="include/footer.jsp"/>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/bootstrap-fileinput-master/js/fileinput.js"></script>
<script type="text/javascript"
        src="${pageContext.request.contextPath}/static/bootstrap-fileinput-master/js/locales/zh.js"></script>

</body>
</html>
