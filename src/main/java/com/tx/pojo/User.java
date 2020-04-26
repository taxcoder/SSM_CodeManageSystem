package com.tx.pojo;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.io.Serializable;
import java.sql.Timestamp;


/**
 * @author tanxiang
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class User implements Serializable {
    /**
     * id=ID
     * username=用户名
     * password=密码
     * roleId=角色ID
     * registerTime=注册时间
     * updateTime=修改时间
     */
	private long id;
	private String username;
	private String password;
	private long roleId;
	private Timestamp registerTime;
	private Timestamp changePasswordTime;
	private String userRoleName;
    /**
     * 登录和修改密码
     */
    public User(long id, String password,Timestamp changePasswordTime) {
        this.id = id;
        this.password = password;
        this.changePasswordTime = changePasswordTime;
    }
    /**
     * 注册
     */
    public User(String username, String password, long roleId, Timestamp registerTime) {
        this.username = username;
        this.password = password;
        this.roleId = roleId;
        this.registerTime = registerTime;
    }
}
