package com.tx.listen;

import javax.servlet.ServletContext;
import javax.servlet.http.*;

/**
 * @Author: tanxiang
 * @Date: 2020/4/15
 * @Version 4.0
 * 获取当前访问人数
 */

public class LoginUserListener implements HttpSessionListener {
    @Override
    public void sessionCreated(HttpSessionEvent httpSessionEvent) {
        /*
            进来一次就会创建一次
            warn:不要使用long类型
         */
        HttpSession session = httpSessionEvent.getSession();
        //存储到全局中
        ServletContext servletContext = session.getServletContext();

        session.getServletContext().setAttribute("count", (int) servletContext.getAttribute("count") + 1);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {
        ServletContext servletContext = httpSessionEvent.getSession().getServletContext();
        int count = (int) servletContext.getAttribute("count");
        if (count > 0) {
            servletContext.setAttribute("count", count - 1);
        }
    }
}
