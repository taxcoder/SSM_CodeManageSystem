<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="include/include.jsp" %>
    <title>代码管理系统</title>
    <link href="${pageContext.request.contextPath }/static/bootstrap-3.3.7-dist/css/dashboard.css" rel="stylesheet">
    <link href="${pageContext.request.contextPath}/static/css/sidebar.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath}/static/js/jquery-3.5.0.js"></script>
    <script>
        let x = 4;
        let sec;
        $(function () {
            sec = $("#Sec");
          let y =  setInterval(function () {
              date();
           },1000);

          function date(){
              x--;
              sec.text(x);
          }

          function end(){
              clearInterval(y);
          }

          setTimeout(end,5000);
          setTimeout(function () {
                window.location.href = "${pageContext.request.contextPath}/file/myFile";
          },5000);
        });
    </script>
</head>

<body>
<jsp:include page="include/header.jsp"/>


<!-- Begin page content -->
<div class="container-fluid">
    <div class="row">
        <jsp:include page="include/sidebar.jsp"/>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
            <div class="text-center">
                <h1 class="text-success"><span class="glyphicon glyphicon-ok-circle"
                                               style="position: relative; top:6px; font-size:150px"></span></h1>
                <h2 id="Sec" style="font-size: 50px"></h2>
                <h2 style="font-size: 18px">3秒后自动返回</h2>
            </div>
        </div>
    </div>
</div>
<jsp:include page="include/footer.jsp"/>
</body>
</html>
