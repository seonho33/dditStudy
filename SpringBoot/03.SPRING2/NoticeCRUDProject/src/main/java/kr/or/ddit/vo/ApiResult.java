package kr.or.ddit.vo;

import java.util.List;

public class ApiResult {

    private List<AptVO> list;
    private int totalPage;

    public ApiResult(List<AptVO> list, int totalPage) {
        this.list = list;
        this.totalPage = totalPage;
    }

    public List<AptVO> getList() {
        return list;
    }

    public int getTotalPage() {
        return totalPage;
    }
}