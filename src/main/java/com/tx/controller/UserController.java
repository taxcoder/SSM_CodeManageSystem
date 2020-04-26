package com.tx.controller;

import com.tx.pojo.User;
import com.tx.service.user.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
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
@SuppressWarnings("all")
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
        //管理员后台给用户增加权限
        User userData = new User(user.getUsername(), user.getPassword(), 3, new Timestamp(System.currentTimeMillis()));
        //影响的行数大于0
        if (userService.addUser(userData) > 0) {
            return "redirect:/free/login";
        } else {
            model.addAttribute("error", "0");
            return "redirect:/free/operationError";
        }
    }

    /**
     * 注册时判断是否用户名重名
     *
     * @param username 用户名
     * @return
     */
    @ResponseBody
    @PostMapping("/fight")
    public String userRegister(String username) {
        //存在相同用户名
        if (userService.queryUserByName(username) != null) {
            //返回 1，表示存在相同用户名
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

        if (userDao == null) {
            //用户名或密码错误
            model.addAttribute("error", "1");
            return "redirect:/free/login";
        } else {
            session.setAttribute("user", userDao);
            return "redirect:/home.jsp";
        }
    }

    /**
     * 判断旧密码
     *
     * @param password 旧密码
     * @param request  请求
     * @return 返回信息
     */
    @ResponseBody
    @PostMapping("/judgePassword")
    public String judgePassword(String password, HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");

        if (password == null || "".equals(password)) {
            //为空
            return "-1";

            //通过传递的旧密码判断获取User是否为空
        } else if (userService.queryUserLogin(user.getUsername(), password) == null) {
            //用户名或密码错误
            return "0";
        } else {
            //正确
            return "1";
        }
    }

    /**
     * 修改密码
     *
     * @param password 新密码
     * @param id       用户id
     */
    @PostMapping("/changePassword")
    public String changePassword(String password, HttpServletRequest request, Model model, String id) {
        User user = (User) request.getSession().getAttribute("user");

        if (id == null || "".equals(id) || !id.matches("\\d+")) {
            //修改错误
            model.addAttribute("error", "2");
            //跳转到错误页面
            return "redirect:/free/operationError";
        }

        //修改页面存储的id和当前登录用户的id一致，且修改结果为true
        if (user.getId() == Long.parseLong(id) && userService.updateUser(new User(Long.parseLong(id), password, new Timestamp(System.currentTimeMillis())))) {
                //退出登录，销毁session
                request.getSession().invalidate();
                return "redirect:/free/login";
        }

        model.addAttribute("error", "2");
        return "redirect:/free/operationError";
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
