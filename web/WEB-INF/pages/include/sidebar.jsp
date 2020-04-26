<%@ page pageEncoding="UTF-8" %>
<div class="col-sm-3 col-md-2 sidebar">
    <div style="padding:0 0 20px 0; color: white;font-size: 16px;">
        <span class="glyphicon glyphicon-bell"></span>&nbsp;当前在线人数：${applicationScope.count}人
    </div>
    <div class="nav-class">
        <h3 class="nav-h3" id="nav-h3-1">基本操作<span class="glyphicon glyphicon-chevron-left nav-Position" id="nav-span-1"></span></h3>
        <ul class="nav nav-sidebar nar-ul" id="ul_menu_1" style="font-size: 18px;display: none">
            <li class="nav-li"><a href="${pageContext.request.contextPath}/home.jsp" class="a_color"><span
                    class="glyphicon glyphicon-list-alt"></span>&nbsp;首页<span class="sr-only">(current)</span></a></li>
            <li id="nav-li-code" class="nav-li"><a href="${pageContext.request.contextPath}/free/code/1" class="a_color"><span
                    class="glyphicon glyphicon-cog"></span>&nbsp;文件总览</a></li>
            <li class="nav-li"><a href="#" class="a_color"><span
                    class="glyphicon glyphicon-upload"></span>&nbsp;系统通知</a></li>
        </ul>
    </div>
    <div id="nav-h3-code" style="display:block;">
        <h3 class="nav-h3">用户管理<span class="glyphicon glyphicon-chevron-left nav-Position"  id="nav-span-2"></span></h3>
        <ul class="nav nav-sidebar nar-ul" id="ul_menu_2" style="font-size: 18px;display: none">
            <li class="nav-li"><a href="${pageContext.request.contextPath}/user/updatePassword" class="a_color"><span
                    class="glyphicon glyphicon-list-alt"></span>&nbsp;修改密码<span class="sr-only">(current)</span></a></li>
            <li class="nav-li"><a href="#" class="a_color"><span
                    class="glyphicon glyphicon-cog"></span>&nbsp;登录日志</a></li>
            <li class="nav-li"><a href="#" class="a_color"><span
                    class="glyphicon glyphicon-upload"></span>&nbsp;个人信息</a></li>
        </ul>
    </div>
    <div class="nav-class">
        <h3 class="nav-h3">文件管理<span class="glyphicon glyphicon-chevron-left nav-Position"  id="nav-span-3"></span></h3>
        <ul class="nav nav-sidebar nar-ul" id="ul_menu_3" style="font-size: 18px;display: none">
                    <li class="nav-li"><a href="${pageContext.request.contextPath }/user/upload" class="a_color"><span
                            class="glyphicon glyphicon-list-alt"></span>&nbsp;上传文件<span class="sr-only">(current)</span></a></li>
                    <li class="nav-li"><a href="${pageContext.request.contextPath }/file/myFile/1" class="a_color"><span
                            class="glyphicon glyphicon-cog"></span>&nbsp;我的文件</a></li>
                    <li class="nav-li"><a href="${pageContext.request.contextPath }/file/recycleFile/1" class="a_color"><span
                            class="glyphicon glyphicon-upload"></span>&nbsp;回收站</a></li>
        </ul>
    </div>
</div>
<script>

    $(function () {
        let nav =  $(".nav-h3");

        nav.click(function () {
            if($(this).next("ul").is(":visible")){
                $(this).children("span").removeClass("glyphicon glyphicon-chevron-down");
                $(this).children("span").addClass("glyphicon glyphicon-chevron-left");
                $(this).next("ul").slideUp();
            }else{
                $(this).children("span").removeClass("glyphicon glyphicon-chevron-left");
                $(this).children("span").addClass("glyphicon glyphicon-chevron-down");
                $(this).next("ul").slideDown();
            }
        });

        nav.hover(function (){
            $(this).addClass("changeColor");
        },function () {
            $(this).removeClass("changeColor");
        });
    });
</script>
