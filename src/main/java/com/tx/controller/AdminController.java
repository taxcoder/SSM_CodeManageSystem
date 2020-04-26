package com.tx.controller;

import com.tx.pojo.User;
import com.tx.service.user.UserService;
import com.tx.utils.ConstantUtil;
import com.tx.utils.JsonUtil;
import com.tx.utils.PageUtil;
import com.tx.utils.TimeStampUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;
import java.util.Objects;

/**
 * @Author: tanxiang
 * @Date: 2020/4/21
 * @Version 4.0
 */
@Controller
@RequestMapping("/admin")
@SuppressWarnings("all")
public class AdminController {
    private UserService userService;

    @Autowired
    @Qualifier("userService")
    public void setUserService(UserService userService) {
        this.userService = userService;
    }

    /**
     * 后台登录
     *
     * @param username 管理员用户名
     * @param password 管理员密码
     */
    @PostMapping("/login")
    public String login(String username, String password, HttpSession session, Model model) {

        User user = (User) session.getAttribute("user");
        User admin = userService.queryAdminLogin(username, password);
        if (username == null || password == null) {
            model.addAttribute("error", "4");
            return "redirect:/free/operationError";
        }else if (username.equals(user.getUsername()) && password.equals(user.getPassword()) && admin != null) {
            session.setAttribute("admin", admin);
            //后台管理首页
            return "redirect:/admin/adminManagement";
        }
        //用户名或密码错误
        model.addAttribute("error", "1");
        return "redirect:/admin/adminLogin";
    }

    @RequestMapping("/adminLogin")
    public String adminLogin(HttpServletRequest request) {
        User user = (User) request.getSession().getAttribute("user");
        if(request.getSession().getAttribute("admin")!=null){
            return "redirect:/admin/adminManagement";
        }
        //当登录角色不为普通用户
        return "adminLogin";
    }

    @RequestMapping("/adminManagement")
    public String userList(Model model, HttpSession session) {
        //跳转到后台首页，显示欢迎信息和隐藏角色ID
        User admin = (User) session.getAttribute("admin");
        model.addAttribute("adminName", admin.getUserRoleName());
        model.addAttribute("roleId", admin.getRoleId());
        return "adminManagement";
    }

    @RequestMapping("/loginOut")
    public String loginOut(HttpSession session) {
        //注销后台登录用户，不注销前台已登录用户
        session.removeAttribute("admin");
        return "redirect:/home.jsp";
    }

    @RequestMapping("/userList/{current}")
    public String userList(Model model, @RequestParam(value = "k",required = false) String keyWord, @PathVariable String current) {
        if(current == null || "".equals(current) || !current.matches("\\d+") ||Integer.parseInt(current) <= 0){
            current = "1";
        }
        if("".equals(keyWord)){
            keyWord = null;
        }
        PageUtil pageUtil = new PageUtil();
        pageUtil.setAllCounts(userService.queryUserAllCount(keyWord));
        pageUtil.setCountPages(ConstantUtil.PAGE_SHOW_COUNT);
        pageUtil.setCurrent(Integer.parseInt(current));
        model.addAttribute("current",pageUtil.getCurrent());
        model.addAttribute("allPages", pageUtil.getAllPages());
        model.addAttribute("countPage", pageUtil.getCountPages());
        List<User> userList = userService.queryUserAll(keyWord, pageUtil.getCurrent() -1, ConstantUtil.PAGE_SHOW_COUNT);
        model.addAttribute("users",userList);
        return "userList";
    }

    @ResponseBody
    @RequestMapping("/userListFirst/{current}")
    public String userListFirst(String keyWord, @PathVariable String current) {
        if ("".equals(keyWord)) {
            keyWord = null;
        }
        if (current == null || "".equals(current) || !current.matches("\\d+")) {
            return "1";
        }
        PageUtil pageUtil = new PageUtil();
        pageUtil.setCountPages(ConstantUtil.PAGE_SHOW_COUNT);
        pageUtil.setAllCounts(userService.queryUserAllCount(keyWord));
        pageUtil.setCurrent(Integer.parseInt(current));
        return JsonUtil.getJson(userService.queryUserAll(keyWord, pageUtil.getCurrent() - 1, ConstantUtil.PAGE_SHOW_COUNT));
    }

    @ResponseBody
    @RequestMapping("/allPages")
    public String allPage(String keyWord) {
        if ("".equals(keyWord)) {
            keyWord = null;
        }
        PageUtil pageUtil = new PageUtil(1, userService.queryUserAllCount(keyWord), ConstantUtil.PAGE_SHOW_COUNT);

        return String.valueOf(pageUtil.getAllPages());
    }

    @ResponseBody
    @RequestMapping("/delete/{id}/{roleId}")
    public String userDelete(@PathVariable String id, @PathVariable String roleId,HttpSession session){
        if(id == null || "".equals(id) || !id.matches("\\d+") || Long.parseLong(id) <= 0){
            return "1";
        }
        if(roleId == null || "".equals(roleId) || !roleId.matches("\\d+") || Long.parseLong(roleId) <=0){
            return "1";
        }
        User admin = (User) session.getAttribute("admin");
        if(admin.getRoleId() == 1){
            if(userService.userDelete(Long.parseLong(id)) > 0){
                return "success";
            }
        }else if(admin.getRoleId() == 2 && Long.parseLong(roleId) != 1 && admin.getId() != Long.parseLong(id)){
            if(userService.userDelete(Long.parseLong(id)) > 0){
                return "success";
            }
        }else{
            return "2";
        }

        return "1";
    }

    @RequestMapping("/information/{id}/{current}")
    public String information(@PathVariable String current, @PathVariable String id, Model model, HttpServletResponse response,HttpServletRequest request){
        if(current == null || "".equals(current) || !current.matches("\\d+")){
            //当前页，返回用户列表使用
            try {
                response.sendRedirect(request.getContextPath()+"/free/operationError");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }

        if(id == null || "".equals(id) || !id.matches("\\d+")){
            //id
            try {
                response.sendRedirect(request.getContextPath()+"/free/operationError");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
        User user = userService.queryUserById(Long.parseLong(Objects.requireNonNull(id)));
        User admin = (User) request.getSession().getAttribute("admin");
        model.addAttribute("user",user);
        model.addAttribute("roleId",admin.getRoleId());
        model.addAttribute("changePasswordTime",TimeStampUtil.getTimeStamp(user.getChangePasswordTime()));
        model.addAttribute("current",current);
        return "information";
    }

    @ResponseBody
    @GetMapping("/updateRank/{id}/{roleId}")
    public String updateRank(@PathVariable String id, @PathVariable String roleId){
        if(id == null || "".equals(id) || !id.matches("\\d+") || Long.parseLong(id) <= 0){
            return null;
        }
        if(roleId == null || "".equals(roleId) || !roleId.matches("\\d+") || Long.parseLong(roleId) <= 0){
            return null;
        }
        if(userService.updateUserRole(Long.parseLong(id), Long.parseLong(roleId)) > 0){
            return "success";
        }
        return null;
    }
}
