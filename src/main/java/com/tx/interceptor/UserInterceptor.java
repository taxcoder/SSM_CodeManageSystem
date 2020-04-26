package com.tx.interceptor;

import com.tx.pojo.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @Author: tanxiang
 * @Date: 2020/4/18
 * @Version 4.0
 */
public class UserInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        if(request.getRequestURL().toString().contains("/user/login")){
            return true;
        }

        if(request.getRequestURL().toString().contains("/user/register")){
            return true;
        }
        //当前面不满足时，则不需要通过session获取user，减少资源消耗
        User user = (User) request.getSession().getAttribute("user");

        if(user != null){
            return true;
        }
        response.sendRedirect(request.getContextPath()+"/free/notLogin");
        return false;
    }
}
