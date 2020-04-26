package com.tx.service.uploadfile;

import com.tx.pojo.UploadFile;

import java.sql.Timestamp;
import java.util.List;

/**
 * @Author: tanxiang
 * @Date: 2020/4/15
 * @Version 4.0
 */
public interface UploadFileService {

    /**
     * 查询总数据数
     * @param id 用户ID
     * @param keyWord 关键字
     * @param deleteState 删除状态
     * @return 返回总数据数
     */
    int queryCount(long id,String keyWord,boolean deleteState);

    /**
     * 查询所有数据并分页
     * @param keyWord 文件显示名
     * @param current 当前页
     * @param countPages 每页显示数据
     * @param deleteState 删除状态
     * @return 返回分完页的数据
     */
    List<UploadFile> queryTotalData(String keyWord,int current,int countPages,boolean deleteState);

    /**
     * 上传一个文件
     * @param uploadFile 上传文件的全部信息
     * @return 返回影响的行数
     */
    int addUploadFile(UploadFile uploadFile);

    /**
     * 删除一个文件
     * @param id 删除文件的ID
     * @param deleteState 删除状态
     * @param deleteTime 删除时间
     * @param updateTime 修改时间
     * @return 返回影响的行数
     */
    int updateFileDeleteState(long id, boolean deleteState, Timestamp deleteTime,Timestamp updateTime);

    /**
     * 修改一个文件的信息
     * @param uploadFile 需要修改的文件信息
     * @return 返回影响的行数
     */
    int changeUploadFile(UploadFile uploadFile);

    /**
     * 根据用户ID文件查找
     * @param id 用户ID
     * @param current 当前页
     * @param countPages 每页条数
     * @param keyWord 关键词
     * @param deleteState 删除状态
     * @return 返回用户的文件
     */
    List<UploadFile> queryUserFileById(long id,int current,int countPages,String keyWord,boolean deleteState);

    /**
     * 根据ID查询文件
     * @param id 文件ID
     * @return 返回文件
     */
    UploadFile queryFileByIdOne(long id);

    /**
     * 删除数据
     * @param id 文件ID
     * @return 返回删除结果
     */
    int deleteFile(long id);
}
