package com.tx.service.user;

import com.tx.dao.user.UserMapper;
import com.tx.pojo.User;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author: tanxiang
 * @Date: 2020/4/13
 * @Version 4.0
 */
public class UserServiceImpl implements UserService {

    private UserMapper userMapper;

    public void setUserMapper(UserMapper userMapper) {
        this.userMapper = userMapper;
    }

    @Override
    public int addUser(User user) {
        return userMapper.addUser(user);
    }

    @Override
    public boolean updateUser(User user) {
        return userMapper.updateUser(user) > 0;
    }

    @Override
    public User queryUserByName(String username) {
        //注册时判断用户名是否重复，根据用户名进行查找
        return userMapper.queryUserByName(username);
    }

    @Override
    public User queryUserLogin(String username, String password) {
        return userMapper.queryUserLogin(username,password);
    }

    @Override
    public List<User> queryUserAll(String keyWord,int current,int pageCount) {
        Map<String,Object> map = new HashMap<>(6);
        map.put("keyWord",keyWord);
        map.put("current",current * pageCount);
        map.put("pageCount",pageCount);
        return userMapper.queryUserAll(map);
    }

    @Override
    public User queryAdminLogin(String username, String password) {
        return userMapper.queryAdminLogin(username,password);
    }

    @Override
    public int queryUserAllCount(String keyWord) {
        return userMapper.queryUserAllCount(keyWord);
    }

    @Override
    public int userDelete(long id) {
        return userMapper.userDelete(id);
    }

    @Override
    public User queryUserById(long id) {
        return userMapper.queryUserById(id);
    }

    @Override
    public int updateUserRole(long id, long roleId) {
        return userMapper.updateUserRole(id,roleId);
    }

}
