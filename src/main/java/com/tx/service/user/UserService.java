package com.tx.service.user;

import com.tx.pojo.User;
import org.apache.ibatis.annotations.Param;

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
     * @param keyWord 关键字
     * @param current 当前页
     * @param pageCount 每页数据
     * @return 返回查询到的用户
     */
    List<User> queryUserAll(String keyWord,int current,int pageCount);

    /**
     * 管理员登录验证
     * @param username 用户名
     * @param password 用户密码
     * @return 返回用户信息
     */
    User queryAdminLogin(@Param("username") String username,@Param("password") String password);

    /**
     * 查询用户总个数
     * @param keyWord 关键字
     * @return 返回用户个数
     */
    int queryUserAllCount(String keyWord);

    /**
     * 删除用户
     * @param id 用户ID
     * @return 返回影响的行数
     */
    int userDelete(long id);

    /**
     * 根据ID查询用户信息
     * @param id 用户ID
     * @return 返回查询的结果
     */
    User queryUserById(long id);

    /**
     * 修改用户的权限
     * @param id 用户id
     * @param roleId 用户权限
     * @return 返回影响的行数
     */
    int updateUserRole(@Param("id") long id,@Param("roleId") long roleId);

}
