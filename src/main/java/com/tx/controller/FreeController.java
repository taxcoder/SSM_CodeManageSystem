package com.tx.controller;

import com.tx.pojo.UploadFile;
import com.tx.service.uploadfile.UploadFileService;
import com.tx.utils.ConstantUtil;
import com.tx.utils.JsonUtil;
import com.tx.utils.PageUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextAttributeEvent;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.util.List;

/**
 * @Author: tanxiang
 * @Date: 2020/4/13
 * @Version 4.0
 */
@Controller
@RequestMapping("/free")
public class FreeController {
    private PageUtil pageUtil;
    private UploadFileService uploadFileService;

    @Autowired
    @Qualifier("fileService")
    public void setUploadFileService(UploadFileService uploadFileService) {
        this.uploadFileService = uploadFileService;
    }

    @RequestMapping("/register")
    public String register(HttpSession httpSession) {
        //跳转到注册页，用户登录状态，销毁session退出
        if (httpSession.getAttribute("user") != null) {
            httpSession.removeAttribute("user");
        }
        return "register";
    }

    //跳转视图
    @RequestMapping("/login")
    public String login(HttpServletRequest request, Model model) {

        if (request.getSession().getAttribute("user") != null) {
            model.addAttribute("result", "您已登录！");
            return "redirect:/home.jsp";
        }
        return "login";
    }

    //退出登录
    @RequestMapping("/loginOut")
    public String loginOut(HttpSession session) {
        session.invalidate();
        return "redirect:/home.jsp";
    }

    //查询数据
    @ResponseBody
    @RequestMapping("/codes/{current}")
    public String codes(Model model, @PathVariable String current, String keyWord, HttpServletRequest request) {
        if ("".equals(keyWord)) {
            keyWord = null;
        }
        String regex = "\\d+";
        if (current == null || "".equals(current) || !current.matches(regex) || Integer.parseInt(current) < 0) {
            return "1";
        }
        pageUtil = new PageUtil();
        //总页数
        pageUtil.setAllCounts(uploadFileService.queryCount(0, keyWord, false));
        //每页显示条数
        pageUtil.setCountPages(ConstantUtil.PAGE_SHOW_COUNT);
        //当前页

        if (Integer.parseInt(current) > pageUtil.getAllPages()) {
            pageUtil.setCurrent(pageUtil.getAllPages());
        }else{
            pageUtil.setCurrent(Integer.parseInt(current));

        }
        //返回的数据
        List<UploadFile> uploadFiles = uploadFileService.queryAllPages(keyWord, pageUtil.getCurrent() - 1, pageUtil.getCountPages(), false);
        return JsonUtil.getJson(uploadFiles);
    }

    //链接跳转
    @RequestMapping("/code")
    public String code(HttpServletRequest request) {
        pageUtil = new PageUtil();
        //总数据数
        pageUtil.setAllCounts(uploadFileService.queryCount(0, null, false));
        //每页显示条数
        pageUtil.setCountPages(ConstantUtil.PAGE_SHOW_COUNT);
        request.setAttribute("allPages", pageUtil.getAllPages());
        request.setAttribute("countPage", ConstantUtil.PAGE_SHOW_COUNT);
        return "codeList";
    }

    //获取总页数
    @ResponseBody
    @RequestMapping("/allPages")
    public String allPages(String keyWord) {
        if (keyWord == "" || "".equals(keyWord)) {
            keyWord = null;
        }
        pageUtil = new PageUtil();
        //总数据数
        pageUtil.setAllCounts(uploadFileService.queryCount(0, keyWord, false));
        //每页显示条数
        pageUtil.setCountPages(ConstantUtil.PAGE_SHOW_COUNT);
        return String.valueOf(pageUtil.getAllPages());
    }

    @RequestMapping("/operationError")
    public String operationError() {
        return "operationError";
    }

    @RequestMapping("/sysError")
    public String sysError() {
        return "sysError";
    }

    @RequestMapping("/notLogin")
    public String notLogin() {
        return "notLogin";
    }

    @RequestMapping("/pageError")
    public String pageError() {
        return "404";
    }
    @RequestMapping("/codeError")
    public String codeError() {
        return "500";
    }
}
