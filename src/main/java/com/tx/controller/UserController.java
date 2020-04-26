package com.tx.controller;

import com.tx.pojo.User;
import com.tx.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.*;
import java.sql.Timestamp;

/**
 * @Author: tanxiang
 * @Date: 2020/4/13
 * @Version 4.0
 * <p>
 * 密码需要加密：未加密状态
 */
@Controller
@RequestMapping("/user")
public class UserController {

    private UserService userService;

    /**
     * @Autowired 自动注入，省略<property name="" ref="">的操作
     * @Qualifier("userService") 起别名，括号内的别名也可以访问，解决ID相同时出现的问题
     */
    @Autowired
    @Qualifier("userService")
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    /**
     * @ResponseBody 不走视图解析器
     * @PostMapping 访问路径，以Post的方式
     */

    @PostMapping("/register")
    public String register(User user, Model model) {
        User userData;
        if (user.getId() != 0) {
            //管理不会退出登录，所以可以携带ID
            userData = new User(user.getUsername(), user.getPassword(), 0, new Timestamp(System.currentTimeMillis()));
        } else {
            userData = new User(user.getUsername(), user.getPassword(), 1, new Timestamp(System.currentTimeMillis()));
        }
        if (userService.addUser(userData) > 0) {
            return "redirect:/free/login";
        } else {
            model.addAttribute("error", "0");
            return "redirect:/free/operationError";
        }
    }

    @ResponseBody
    @PostMapping("/fight")
    public String userRegister(String username) {
        User user = userService.queryUserByName(username);
        if (user != null) {
            return "1";
        } else {
            return "0";
        }
    }

    //登录操作
    @PostMapping("/login")
    public String login(String username, String password, HttpSession session, Model model, HttpServletRequest request) {

        //登录判断
        User userDao = userService.queryUserLogin(username, password);

        //应用
        ServletContext servletContext = session.getServletContext();

        if (userDao == null) {
            //用户名或密码错误
            model.addAttribute("error", "1");
            return "redirect:/free/login";
        } else {
            session.setAttribute("user", userDao);
            return "redirect:/home.jsp";
        }
    }

    @ResponseBody
    @PostMapping("/judgePassword")
    public String judgePassword(String password, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");

        //修改密码
        User userDao = userService.queryUserLogin(user.getUsername(), password);

        //为空
        if (password == null || "".equals(password)) {
            return "-1";
        } else if (userDao == null) {
            //用户名或密码错误
            return "0";
        } else {
            //正确
            return "1";
        }
    }

    @PostMapping("/changePassword")
    public String changePassword(String password, HttpServletRequest request, Model model, String id) {
        User user = (User) request.getSession().getAttribute("user");
        /**
         *  修改错误:2
         *  上传错误：1
         *  其他：注册错误
         */

        if (id == null || "".equals(id)) {
            model.addAttribute("error", "2");
            return "redirect:/free/operationError";
        } else if (!(id.matches("\\d+") && Long.parseLong(id) > 0)) {
            model.addAttribute("error", "2");
            return "redirect:/free/operationError";
        }

        if (user.getId() == Long.parseLong(id)) {

            boolean result = userService.updateUser(new User(Long.parseLong(id), password, new Timestamp(System.currentTimeMillis())));
            //退出登录，销毁session
            request.getSession().invalidate();
            return "redirect:/free/login";
        } else {
            model.addAttribute("error", "2");
            return "redirect:/free/operationError";
        }
    }

    //跳转视图
    @RequestMapping("/updatePassword")
    public String changePassword() {
        return "change_password";
    }

    //跳转视图
    @RequestMapping("/upload")
    public String upload() {
        return "upload";
    }

    //跳转视图
    @RequestMapping("/bizzdone")
    public String bizzdone() {
        return "bizzdone";
    }

}
