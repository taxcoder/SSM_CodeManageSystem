package com.tx.service.user;

import com.tx.dao.user.UserMapper;
import com.tx.pojo.User;

import java.util.List;

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
    public int deleteUserById(long id) {
        return userMapper.deleteUserById(id);
    }

    @Override
    public boolean updateUser(User user) {
        return userMapper.updateUser(user) > 0;
    }

    @Override
    public User queryUserByName(String username) {
        return userMapper.queryUserByName(username);
    }

    @Override
    public User queryUserLogin(String username, String password) {
        return userMapper.queryUserLogin(username,password);
    }

    @Override
    public List<User> queryUserAll() {
        return userMapper.queryUserAll();
    }

}
