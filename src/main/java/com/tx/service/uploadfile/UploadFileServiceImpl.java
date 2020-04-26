package com.tx.service.uploadfile;

import com.tx.dao.uploadfile.UploadFileMapper;
import com.tx.pojo.UploadFile;

import java.sql.Timestamp;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Author: tanxiang
 * @Date: 2020/4/15
 * @Version 4.0
 */
public class UploadFileServiceImpl implements UploadFileService{
    private UploadFileMapper uploadFileMapper;

    public void setUploadFileMapper(UploadFileMapper uploadFileMapper) {
        this.uploadFileMapper = uploadFileMapper;
    }
    @Override
    public int queryCount(long id,String keyWord,boolean deleteState) {
        Map<String,Object> map = new HashMap<>(6);
        // id用于和user进行关联，获取角色表的角色名
        map.put("id",id);
        map.put("keyWord",keyWord);
        map.put("deleteState",deleteState);
        return uploadFileMapper.queryCount(map);
    }

    @Override
    public List<UploadFile> queryTotalData(String keyWord,int current,int countPages,boolean deleteState) {
        Map<String,Object> map = new HashMap<>(8);
        map.put("keyWord",keyWord);
        map.put("current",current * countPages);
        map.put("countPages",countPages);
        map.put("deleteState",deleteState);
        return uploadFileMapper.queryTotalData(map);
    }

    @Override
    public int addUploadFile(UploadFile uploadFile) {
        return uploadFileMapper.addUploadFile(uploadFile);
    }

    @Override
    public int updateFileDeleteState(long id, boolean deleteState, Timestamp deleteTime,Timestamp updateTime) {
        Map<String,Object> map = new HashMap<>(8);
        map.put("id",id);
        map.put("deleteState",deleteState);
        map.put("deleteTime",deleteTime);
        map.put("updateTime",updateTime);
        return uploadFileMapper.updateFileDeleteState(map);
    }

    @Override
    public int changeUploadFile(UploadFile uploadFile) {
        return uploadFileMapper.changeUploadFile(uploadFile);
    }

    @Override
    public List<UploadFile> queryUserFileById(long id,int current,int countPages,String keyWord,boolean deleteState) {
        Map<String,Object> map = new HashMap<>(8);
        map.put("id",id);
        map.put("current",current * countPages);
        map.put("countPages",countPages);
        map.put("keyWord",keyWord);
        map.put("deleteState",deleteState);
        return uploadFileMapper.queryUserFileById(map);
    }

    @Override
    public UploadFile queryFileByIdOne(long id) {
        return uploadFileMapper.queryFileByIdOne(id);
    }

    @Override
    public int deleteFile(long id) {
        return uploadFileMapper.deleteFile(id);
    }
}
