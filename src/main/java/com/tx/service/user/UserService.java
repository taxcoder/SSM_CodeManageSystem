package com.tx.service.user;

import com.tx.pojo.UploadFile;
import com.tx.pojo.User;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @Author: tanxiang
 * @Date: 2020/4/13
 * @Version 4.0
 */
public interface UserService {

    /**
     * 增加用户
     * @param user 用户信息
     * @return 返回影响的行数
     *
     */
    int addUser(User user);

    /**
     * 删除用户
     * @param id 用户ID
     * @return 返回影响的行数
     *
     */
    int deleteUserById(long id);

    /**
     * 修改用户密码
     * @param user 用户密码
     * @return 返回影响的行数
     *
     */
    boolean updateUser(User user);

    /**
     * 查询单个用户
     * @param username 用户名
     * @return 返回用户信息
     */
    User queryUserByName(String username);

    /**
     * 登录验证
     * @param username 用户名
     * @param password 密码
     * @return 返回用户信息
     */
    User queryUserLogin(String username,String password);

    /**
     * 查询所有用户
     * @return 返回查询到的用户
     */
    List<User> queryUserAll();

}
