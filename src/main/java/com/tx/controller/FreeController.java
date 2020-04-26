package com.tx.controller;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * @Author: tanxiang
 * @Date: 2020/4/13
 * @Version 4.0
 */
@Controller
@RequestMapping("/free")
@SuppressWarnings("all")
public class FreeController {
    private PageUtil pageUtil;
    private UploadFileService uploadFileService;

    @Autowired
    @Qualifier("fileService")
    public void setUploadFileService(UploadFileService uploadFileService) {
        this.uploadFileService = uploadFileService;
    }

    @RequestMapping("/register")
    public String register(HttpSession session) {
        //不允许登录状态下进入注册页面
        if (session.getAttribute("user") != null) {
            session.invalidate();
        }
        return "register";
    }

    /**
     *   跳转视图
     */
    @RequestMapping("/login")
    public String login(HttpServletRequest request, Model model) {

        //已登录
        if (request.getSession().getAttribute("user") != null) {
            model.addAttribute("result", "您已登录！");
            return "redirect:/home.jsp";
        }
        return "login";
    }

    /**
     * 退出登录
     */
    @RequestMapping("/loginOut")
    public String loginOut(HttpSession session) {
        session.invalidate();
        return "redirect:/home.jsp";
    }

    /**
     *查询数据
     */
    @ResponseBody
    @RequestMapping("/codes/{current}")
    public String codes(Model model, @PathVariable String current, String keyWord, HttpServletRequest request) {
        pageUtil = new PageUtil();

        if ("".equals(keyWord)) {
            keyWord = null;
        }
        if (current == null || "".equals(current) || !current.matches("\\d+")) {
            return "1";
        }
        //总页数
        pageUtil.setAllCounts(uploadFileService.queryCount(0, keyWord, false));
        //每页显示条数
        pageUtil.setCountPages(ConstantUtil.PAGE_SHOW_COUNT);

        //当前页,必须在总页数、每页显示条数之下
         pageUtil.setCurrent(Integer.parseInt(current));

        //返回的数据
        return JsonUtil.getJson(uploadFileService.queryTotalData(keyWord, pageUtil.getCurrent() - 1, pageUtil.getCountPages(), false));
    }

    /**
     *   链接跳转,传递总页数和每页显示条数
     */
    @RequestMapping("/code/{current}")
    public String code(Model model, @PathVariable String current,@RequestParam(value = "k",required = false) String keyWord) {
        PageUtil pageUtil = new PageUtil();
        if("".equals(keyWord)){
            keyWord = null;
        }
        if(current == null || "".equals(current) || !current.matches("\\d+") ||Integer.parseInt(current) <= 0){
            current = "1";
        }
        //总数据数
        pageUtil.setAllCounts(uploadFileService.queryCount(0,keyWord,false));

        //每页显示数据
        pageUtil.setCountPages(ConstantUtil.PAGE_SHOW_COUNT);
        //当前页
        pageUtil.setCurrent(Integer.parseInt(current));
       //总页数
        model.addAttribute("allPages",pageUtil.getAllPages());
        //每页显示条数
        model.addAttribute("countPage",pageUtil.getCountPages());
        //分页后的总数据
        model.addAttribute("files",uploadFileService.queryTotalData(keyWord,
                pageUtil.getCurrent() - 1,pageUtil.getCountPages(),false));
        model.addAttribute("current",pageUtil.getCurrent());
        return "codeList";
    }

    /**
     *  获取总页数
     */
    @ResponseBody
    @RequestMapping("/allPages")
    public String allPages(String keyWord) {
        if ("".equals(keyWord)) {
            keyWord = null;
        }
        pageUtil = new PageUtil();
        int number = uploadFileService.queryCount(0, keyWord, false);
        //总数据数
        pageUtil.setAllCounts(number);
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

    @RequestMapping("/notRank")
    public String notRank() {
        return "notRank";
    }

}
