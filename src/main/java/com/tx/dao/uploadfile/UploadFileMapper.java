package com.tx.dao.uploadfile;

import com.tx.pojo.UploadFile;
import org.apache.ibatis.annotations.Delete;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

/**
 * @Author: tanxiang
 * @Date: 2020/4/15
 * @Version 4.0
 */
public interface UploadFileMapper {

    /**
     * 查询总数据数
     * @param map 包含了查询条件
     * @return 返回总数据数
     */
    int queryCount(Map<String,Object> map);

    /**
     * 返回分页的数据
     * @param map 携带信息的map
     * @return 返回分页的数据
     */
    List<UploadFile> queryAllPages(Map<String,Object> map);

    /**
     * 上传一个文件
     * @param uploadFile 上传文件的全部信息
     * @return 返回影响的行数
     */
    int addUploadFile(UploadFile uploadFile);

    /**
     * 删除或撤回一个文件
     * @param map 文件操作信息
     * @return 返回影响的行数
     */
    int updateFileDeleteState(Map<String,Object> map);
    /**
     * 修改一个文件的信息
     * @param uploadFile 需要修改的文件信息
     * @return 返回影响的行数
     */
    int changeUploadFile(UploadFile uploadFile);

    /**
     * 根据用户ID用户文件查找
     * @param map 用户ID和分页数据
     * @return 返回用户的文件
     */
    List<UploadFile> queryUserFileById(Map<String,Object> map);

    /**
     * 根据ID查询文件
     * @param id 文件ID
     * @return 返回文件
     */
    @Select("select id,showName,fileDesc from `uploadfile` where id = #{id}")
    UploadFile queryFileByIdOne(@Param("id") long id);

    /**
     * 删除数据
     * @param id 文件ID
     * @return 返回删除结果
     */
    @Delete("delete from `uploadfile` where id = #{id}")
    int deleteFile(@Param("id") long id);
}
