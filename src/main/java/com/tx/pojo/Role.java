package com.tx.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author: tanxiang
 * @Date: 2020/4/13
 * @Version 4.0
 *
 * 使用了lombok
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Role {
    /**
     * id=角色ID
     * roleName=角色名
     */
    private long id;
    private String roleName;

}
