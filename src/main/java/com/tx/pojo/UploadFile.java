package com.tx.pojo;

import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.AllArgsConstructor;

import java.sql.Timestamp;

/**
 * @author tanxiang
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class UploadFile {
    /**
     * id=文件ID
     * userId=用户ID
     * saveName=保存名(UUID)
     * showName=显示名
     * filePath=文件路径
     * fileDesc=文件描述
     * deleteState=删除状态(假删除)
     * uploadTime=上传时间
     * updateTime=修改时间
     * deleteTime=删除时间
     */
    private long id;
    private long userId;
    private String saveName;
    private String showName;
    private String filePath;
    private String fileDesc;
    private boolean deleteState;
    private Timestamp uploadTime;
    private Timestamp updateTime;
    private Timestamp deleteTime;
    private String uploadUser;

    public UploadFile(long id, long userId, String saveName, String showName, String filePath, String fileDesc, boolean deleteState, Timestamp uploadTime, Timestamp updateTime, Timestamp deleteTime) {
        this.id = id;
        this.userId = userId;
        this.saveName = saveName;
        this.showName = showName;
        this.filePath = filePath;
        this.fileDesc = fileDesc;
        this.deleteState = deleteState;
        this.uploadTime = uploadTime;
        this.updateTime = updateTime;
        this.deleteTime = deleteTime;
    }

    public UploadFile(long id, long userId, String showName, String fileDesc, Timestamp updateTime) {
        this.id = id;
        this.userId = userId;
        this.showName = showName;
        this.fileDesc = fileDesc;
        this.updateTime = updateTime;
    }
}
