<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <title>input</title>
    <script src="${pageContext.request.contextPath }/static/js/jquery-3.5.0.js" type="text/javascript"></script>
  </head>
  
  <body>
  	<a href="${pageContext.request.contextPath }/less06/user">新增用户</a>
    <table>
    	<tr>
    		<th>序号</th>
    		<th>用户名</th>
    		<th>密码</th>
    		<th>角色</th>
    		<th>注册时间</th>
    		<th>操作</th>
    	</tr>
    	<c:choose>
    		<c:when test="${not empty userlist }">
    			<c:forEach items="${userlist }" var="user" varStatus="status">
    				<tr>
    					<td>${status.index + 1 }</td>
    					<td>${user.username}</td>
    					<td>${user.password}</td>
    					<td>${user.role}</td>
    					<td>${user.registerTime}</td>
    					<td>
    						<a href="${pageContext.request.contextPath }/less06/user/${user.id }">修改</a> |
    						<a href="#" url="${pageContext.request.contextPath }/less06/user/${user.id }" class="remove-link">删除</a>
    					</td>
    				</tr>
    			</c:forEach>
    		</c:when>
    		<c:otherwise>
    			<tr>
    				<td colspan="5">暂无数据</td>
    			</tr>
    		</c:otherwise>
    	</c:choose>
    </table>
  </body>
  <script type="text/javascript">
  $(function () {
      $(".remove-link").click(function(){
          let url = $(this).attr("url");
          let form = $("<form method='POST'></form>");
          let hidden = $("<input type='hidden' name='_method' value='DELETE'/>");
          form.append(hidden);
          form.attr("action",url);
          form.submit();
      });
  });

  </script>
</html>
