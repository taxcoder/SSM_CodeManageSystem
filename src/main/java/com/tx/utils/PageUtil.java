package com.tx.utils;

import com.tx.pojo.UploadFile;
import lombok.ToString;

import java.util.List;

/**
 * @Author: tanxiang
 * @Date: 2020/4/15
 * @Version 4.0
 */
@ToString
public class PageUtil {
    /**
     * 当前页=current
     * 总页数=allPages
     * 总数据数=allCounts
     * 每页条数=countPages
     */
    private int current;
    private int allPages;
    private int allCounts;
    private int countPages;

    public PageUtil() {

    }

    public PageUtil(int current, int allCounts, int countPages) {
        this.current = current;
        this.allCounts = allCounts;
        this.countPages = countPages;
    }

    public int getCurrent() {
        return current;
    }

    public void setCurrent(int current) {
        this.current = current;
    }

    public int getAllPages() {
        if (allCounts < countPages) {
            return 1;
        } else if ((double) allCounts / countPages - (int) (allCounts / countPages) == 0) {
            return allCounts / countPages;
        } else {
            return allCounts / countPages + 1;
        }
    }

    public int getAllCounts() {
        return allCounts;
    }

    public void setAllCounts(int allCounts) {
        this.allCounts = allCounts;
    }

    public int getCountPages() {
        return countPages;
    }

    public void setCountPages(int countPages) {
        this.countPages = countPages;
    }

}
