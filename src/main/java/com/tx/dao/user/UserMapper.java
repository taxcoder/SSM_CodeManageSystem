package com.tx.dao.user;

import com.tx.pojo.User;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;
import java.util.Map;

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
    @Select("select id,username,password,r_id as roleId,registerTime,changePasswordTime from `user` where username = #{username} and password = #{password}")
    User queryUserLogin(@Param("username") String username,@Param("password") String password);

    /**
     * 管理员登录验证
     * @param username 用户名
     * @param password 用户密码
     * @return 返回用户信息
     */
    @Select("select u.id,username,password,r_id as roleId,registerTime,changePasswordTime,r.roleName as userRoleName from `user` as u,`role` as r where u.r_id = r.id and username = #{username} and password = #{password}")
    User queryAdminLogin(@Param("username") String username,@Param("password") String password);

    /**
     * 查询所有用户
     * @param map 查询条件
     * @return 返回查询到的用户
     */
    List<User> queryUserAll(Map<String,Object> map);

    /**
     * 查询用户总个数
     * @param keyWord 关键字
     * @return 返回用户个数
     */
    int queryUserAllCount(@Param("keyWord") String keyWord);

    /**
     * 删除用户
     * @param id 用户ID
     * @return 返回影响的行数
     */
    @Delete("delete from `user` where id = #{id}")
    int userDelete(@Param("id") long id);

    /**
     * 根据ID查询用户信息
     * @param id 用户ID
     * @return 返回查询的结果
     */
    @Select("select u.id,username,u.r_id as roleId,registerTime,changePasswordTime,r.roleName as userRoleName from `user` as u,`role` as r where u.r_id = r.id and u.id = #{id}")
    User queryUserById(@Param("id") long id);

    /**
     * 修改用户的权限
     * @param id 用户id
     * @param roleId 用户权限
     * @return 返回影响的行数
     */
    @Update("update `user` set r_id = #{roleId} where id = #{id}")
    int updateUserRole(@Param("id") long id,@Param("roleId") long roleId);
}
