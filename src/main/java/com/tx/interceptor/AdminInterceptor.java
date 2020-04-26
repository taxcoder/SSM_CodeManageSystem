package com.tx.interceptor;

import com.tx.pojo.User;
import org.springframework.web.servlet.HandlerInterceptor;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * @Author: tanxiang
 * @Date: 2020/4/23
 * @Version 4.0
 */
public class AdminInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        User user = (User) request.getSession().getAttribute("user");

        if (user == null) {
            response.sendRedirect(request.getContextPath() + "/free/notLogin");
            return false;
        }
        if (request.getRequestURL().toString().contains("/admin/adminLogin") || request.getRequestURL().toString().contains("/admin/login") && (user.getRoleId() == 1 || user.getRoleId() == 2)) {
            return true;
        }
        User admin = (User) request.getSession().getAttribute("admin");
        if (admin != null) {
            return true;
        }
        response.sendRedirect(request.getContextPath() + "/free/notRank");
        return false;
    }

    @Override
    public void postHandle(HttpServletRequest request, HttpServletResponse response, Object handler, ModelAndView modelAndView) throws Exception {

    }

    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {

    }
}
