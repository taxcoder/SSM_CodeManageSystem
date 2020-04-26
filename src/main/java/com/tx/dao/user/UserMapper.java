package com.tx.dao.user;

import com.tx.pojo.User;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
 * @Author: tanxiang
 * @Date: 2020/4/13
 * @Version 4.0
 */
public interface UserMapper {
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
    @Delete("delete from `user` where id=#{id}")
    int deleteUserById(@Param("id") long id);

    /**
     * 修改用户密码
     * @param user 用户密码
     * @return 返回影响的行数
     *
     */
    int updateUser(User user);

    /**
     * 查询单个用户
     * @param username 用户名
     * @return 返回用户信息
     */
    @Select("select * from `user` where username = #{username}")
    User queryUserByName(@Param("username") String username);

    /**
     * 登录验证
     * @param username 用户名
     * @param password 用户密码
     * @return 返回用户信息
     */
    @Select("select * from `user` where username = #{username} and password = #{password}")
    User queryUserLogin(@Param("username") String username,@Param("password") String password);

    /**
     * 查询所有用户
     * @return 返回查询到的用户
     */
    @Select("select * from `user`")
    List<User> queryUserAll();

}
