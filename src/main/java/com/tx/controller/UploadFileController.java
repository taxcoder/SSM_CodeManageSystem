package com.tx.controller;

import com.tx.pojo.UploadFile;
import com.tx.pojo.User;
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
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.sql.Timestamp;
import java.util.List;
import java.util.Objects;
import java.util.UUID;

/**
 * @Author: tanxiang
 * @Date: 2020/4/15
 * @Version 4.0
 */
@Controller
@RequestMapping("/file")
@SuppressWarnings("all")
public class UploadFileController {
    private User user;
    private UploadFileService uploadFileService;

    @Autowired
    @Qualifier("fileService")
    public void setUploadFileService(UploadFileService uploadFileService) {
        this.uploadFileService = uploadFileService;
    }

    /**
     * 采用file.Transto 来保存上传的文件
     *
     * @RequestParam("codefile")要和表单控件一致
     */

    @RequestMapping("/code")
    public String fileUpload(@RequestParam("codefile") CommonsMultipartFile file, HttpServletRequest request, Model model) throws IOException {
        //上传路径保存设置
        String path = "F:" + File.separator + "Maven项目" + File.separator + "CodeManagement_SSM" + File.separator + "web" + File.separator + "WEB-INF" + File.separator + "upload";
        File realPath = new File(path);
        if (!realPath.exists()) {
            boolean mkdir = realPath.mkdir();
        }
        //用户ID先设置为1
        String fileName = Objects.requireNonNull(file.getOriginalFilename()).substring(file.getOriginalFilename().lastIndexOf("."));
        //设置UUID
        String uuid = UUID.randomUUID().toString().replaceAll("-", "");
        String uuidFileName = uuid + fileName;
        UploadFile uploadFile = new UploadFile(0, 1, uuidFileName, file.getOriginalFilename(), path + File.separator + uuidFileName, request.getParameter("fileDesc"), false, new Timestamp(System.currentTimeMillis()), null, null);
        if (uploadFileService.addUploadFile(uploadFile) > 0) {
            //通过CommonsMultipartFile的方法直接写文件（注意这个时候）
            file.transferTo(new File(realPath + "/" + uuidFileName));
            return "redirect:/user/upload";
        }
        model.addAttribute("error", "2");
        return "redirect:/free/operationError";
    }

    @RequestMapping("/download")
    public String downloads(HttpServletResponse response, HttpServletRequest request,String saveName) throws Exception {
        //要下载的图片地址
        String path = "F:" + File.separator + "Maven项目" + File.separator + "CodeManagement_SSM" + File.separator + "web" + File.separator + "WEB-INF" + File.separator + "upload";

        //1、设置response 响应头
        response.reset(); //设置页面不缓存,清空buffer
        //字符编码
        response.setCharacterEncoding("UTF-8");
        //二进制传输数据
        response.setContentType("multipart/form-data");
        //设置响应头
        response.setHeader("Content-Disposition",
                "attachment;fileName=" + URLEncoder.encode(saveName, "UTF-8"));

        File file = new File(path, saveName);
        //2、 读取文件--输入流
        InputStream input = new FileInputStream(file);
        //3、 写出文件--输出流
        OutputStream out = response.getOutputStream();

        byte[] buff = new byte[1024];
        int index = 0;
        //4、执行 写出操作
        while ((index = input.read(buff)) != -1) {
            out.write(buff, 0, index);
            out.flush();
        }
        out.close();
        input.close();
        return null;
    }

    /**
     * 点击链接进入
     */
    @RequestMapping("/myFile")
    public String myFile(HttpServletRequest request, String keyWord) throws IOException {
        user = (User) request.getSession().getAttribute("user");
        //当前页数  ->  总数据数(关键字)  -> 每页显示数据
        PageUtil pageUtil = new PageUtil(1, uploadFileService.queryCount(user.getId(),keyWord,false), ConstantUtil.PAGE_SHOW_COUNT);

        //在页面显示总页数
        request.setAttribute("allPages", pageUtil.getAllPages());

        //获取每页显示条数，用于进行序号处理
        request.setAttribute("countPage", pageUtil.getCountPages());

        //不用jstl，使用Ajax不走视图解析器（不使用视图解析器）
        return "admin";
    }

    /**
     * 获取查询之后的总页数
     */
    @ResponseBody
    @RequestMapping("/myFilePages")
    public String myFilePages(HttpServletRequest request, String keyWord) throws IOException {
         user = (User) request.getSession().getAttribute("user");
        //当前页数  ->  总数据数(关键字)  -> 每页显示数据
        PageUtil pageUtil = new PageUtil(1, uploadFileService.queryCount(user.getId(),keyWord,false), ConstantUtil.PAGE_SHOW_COUNT);

        //不用jstl，使用Ajax不走视图解析器（不使用视图解析器）
        return String.valueOf(pageUtil.getAllPages());
    }

    @ResponseBody
    @RequestMapping("/RecycleFileAllPages")
    public String allPages(HttpServletRequest request, String keyWord) throws IOException {
        user = (User) request.getSession().getAttribute("user");
        //当前页数  ->  总数据数(关键字)  -> 每页显示数据
        PageUtil pageUtil = new PageUtil(1, uploadFileService.queryCount(user.getId(),keyWord,true), ConstantUtil.PAGE_SHOW_COUNT);

        //不用jstl，使用Ajax不走视图解析器（不使用视图解析器）
        return String.valueOf(pageUtil.getAllPages());
    }


    /**
     * @param request 请求
     * @param current 当前页（restful）
     * @param keyWord 关键字
     * @return 返回查询数据(JSON)
     * @RequestMapping("/myFiles/{current}") restful风格，有利于程序安全，不暴露数据名
     * @ResponseBody 设置不走视图解析器
     */
    @ResponseBody
    @RequestMapping("/myFiles/{current}")
    public String myFiles(HttpServletRequest request, @PathVariable String current, String keyWord) {


        //获取存储在session中的用户数据
        user = (User) request.getSession().getAttribute("user");

        //判断当前页传递使用正常
        if (current == null || "".equals(current) || !(current.matches("\\d+") || Integer.parseInt(current) < 0)) {
            return "1";
        }
        if ("".equals(keyWord)) {
            keyWord = null;
        }

        //当前页数  ->  总数据数(关键字)  -> 每页显示数据
        PageUtil pageUtil = new PageUtil(Integer.parseInt(current), uploadFileService.queryCount(user.getId(),keyWord,false), ConstantUtil.PAGE_SHOW_COUNT);

        if(pageUtil.getCurrent() > pageUtil.getAllPages()){
            pageUtil.setCurrent(pageUtil.getAllPages());
        }

        List<UploadFile> uploadFiles = uploadFileService.queryUserFileById(user.getId(), pageUtil.getCurrent() - 1, pageUtil.getCountPages(), keyWord,false);
        return JsonUtil.getJson(uploadFiles);
    }

    /**
     *跳转视图
     */
    @RequestMapping("/codeedit/{editId}")
    public String codeedit(@PathVariable String editId, Model model) {
        if (editId == null || "".equals(editId) || !(editId.matches("\\d+")) || Long.parseLong(editId) <= 0) {
            model.addAttribute("error", "1");
            return "operationError";
        }

        model.addAttribute("file", uploadFileService.queryFileByIdOne(Long.parseLong(editId)));
        return "codeedit";
    }

    /**
     *跳转视图
     */
    @RequestMapping("/updateFile")
    public String updateFile(String fileDesc, String showName, String id, Model model, HttpServletRequest request) {

        //防止参数未正常传递
        if (id == null || "".equals(id)) {
            model.addAttribute("error", "1");
            return "rediret:/free/operationError";
        }

        UploadFile uploadFile = new UploadFile(Long.parseLong(id), 0, showName, fileDesc, new Timestamp(System.currentTimeMillis()));
        int i = uploadFileService.changeUploadFile(uploadFile);
        if (i > 0) {
            return "redirect:/user/bizzdone";
        } else {
            model.addAttribute("error", "1");
            return "rediret:/free/operationError";
        }
    }
    /**
     * 假删除
     */
    @ResponseBody
    @RequestMapping("/deleteFile/{id}")
    public String updateFile(@PathVariable String id, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        /*
         */
        //防止参数未正常传递
        if (id == null || "".equals(id) || !(id.matches("\\d+")) || Long.parseLong(id) <= 0) {
            return "1";
        }
        if (uploadFileService.updateFileDeleteState(Long.parseLong(id),true,new Timestamp(System.currentTimeMillis()),null) > 0) {
            return "success";
        }
        return "1";
    }

    /**
     *真删除
     */
    @ResponseBody
    @RequestMapping("/deleteFileTrue/{id}")
    public String deleteFileTrue(@PathVariable String id)  {
        /*
         */
        //防止参数未正常传递
        if (id == null || "".equals(id) || !(id.matches("\\d+")) || Long.parseLong(id) <= 0) {
            return  "1";
        }
        if (uploadFileService.deleteFile(Long.parseLong(id)) > 0) {
            return "success";
        }
        return  "1";
    }

    /**
     *撤回
     */
    @ResponseBody
    @RequestMapping("/deleteFileWithdraw/{id}")
    public String deleteFileWithdraw(@PathVariable String id) {

        //防止参数未正常传递
        if (id == null || "".equals(id) || !(id.matches("\\d+")) || Long.parseLong(id) <= 0) {
            return  "1";
        }
        if (uploadFileService.updateFileDeleteState(Long.parseLong(id),false,null,new Timestamp(System.currentTimeMillis())) > 0) {
            return "success";
        }
        return  "1";
    }

    /**
     *回收站，点击链接进入
     */
    @RequestMapping("/recycleFile")
    public String recycleFile(HttpServletRequest request, String keyWord) {

        user = (User) request.getSession().getAttribute("user");
        //当前页数  ->  总数据数(关键字)  -> 每页显示数据
        PageUtil pageUtil = new PageUtil(1, uploadFileService.queryCount(user.getId(),keyWord,true), ConstantUtil.PAGE_SHOW_COUNT);

        //在页面显示总页数
        request.setAttribute("allPages", pageUtil.getAllPages());

        //获取每页显示条数，用于进行序号处理
        request.setAttribute("countPage", pageUtil.getCountPages());

        //不用jstl，使用Ajax不走视图解析器（不使用视图解析器）
        return "recycle";
    }

    /**
     *获取数据
     */
    @ResponseBody
    @RequestMapping("/myRecycleFiles/{current}")
    public String myRecycleFiles( String keyWord, @PathVariable String current,HttpServletRequest request) {
        if(current == null || "".equals(current) || !(current.matches("\\d+")) || Integer.parseInt(current) < 0){
            return  "1";
        }

        if("".equals(keyWord)){
            keyWord = null;
        }

        user = (User) request.getSession().getAttribute("user");

        //当前页数  ->  总数据数(关键字)  -> 每页显示数据
        PageUtil pageUtil = new PageUtil(Integer.parseInt(current), uploadFileService.queryCount(user.getId(),keyWord,true), ConstantUtil.PAGE_SHOW_COUNT);

        if(pageUtil.getCurrent() > pageUtil.getAllPages()){
            pageUtil.setCurrent(pageUtil.getAllPages());
        }

        List<UploadFile> uploadFiles = uploadFileService.queryUserFileById(user.getId(), pageUtil.getCurrent() -1, pageUtil.getCountPages(), keyWord, true);

        return JsonUtil.getJson(uploadFiles);
    }
}


