package com.kh.circle.service;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class Pagination {
    private int pageSize = 10;
    private int rangeSize = 10;
    private int curPage = 1;
    private int curRange = 1;
    private int listCount,pageCount,rangeCount;
    private int startPage = 1;
    private int endPage = 1;
    private int startIndex = 0;
    private int prevPage;
    private int nextPage;
	
	public Pagination(int listCount, int curPage) {
		 	setCurPage(curPage);
	        /** 총 게시물 수 **/
	        setListCount(listCount);
	        
	        /** 1. 총 페이지 수 **/
	        setPageCount(listCount);
	        /** 2. 총 블럭(range)수 **/
	        setRangeCount(pageCount);
	        /** 3. 블럭(range) setting **/
	        rangeSetting(curPage);
	        
	        /** DB 질의를 위한 startIndex 설정 **/
	        setStartIndex(curPage);
	    }
	 
	    public void setPageCount(int listCount) {
	        this.pageCount = (int) Math.ceil(listCount*1.0/pageSize);
	    }
	    public void setRangeCount(int pageCount) {
	        this.rangeCount = (int) Math.ceil(pageCount*1.0/rangeSize);
	    }
	    public void rangeSetting(int curPage){
	        
	        setCurRange(curPage);        
	        this.startPage = (curRange - 1) * rangeSize + 1;
	        this.endPage = startPage + rangeSize - 1;
	        
	        if(endPage > pageCount){
	            this.endPage = pageCount;
	        }
	        
	        this.prevPage = curPage - 1;
	        this.nextPage = curPage + 1;
	    }
	    public void setCurRange(int curPage) {
	        this.curRange = (int)((curPage-1)/rangeSize) + 1;
	    }
	    public void setStartIndex(int curPage) {
	        this.startIndex = (curPage-1) * pageSize;
	    }
}
