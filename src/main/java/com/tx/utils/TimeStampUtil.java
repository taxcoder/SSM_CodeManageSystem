package com.tx.utils;

import java.sql.Time;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * @Author: tanxiang
 * @Date: 2020/4/24
 * @Version 4.0
 */
public class TimeStampUtil {

    public static String getTimeStamp(Timestamp timestamp) {
        if (timestamp == null) {
            return "暂无数据";
        }
        DateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        return simpleDateFormat.format(new Date(timestamp.getTime()));
    }
}
