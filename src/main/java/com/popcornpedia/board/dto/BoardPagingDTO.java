package com.popcornpedia.board.dto;

import org.springframework.stereotype.Component;

@Component("boardPagingDTO")
public class BoardPagingDTO {
	private int nowPage; // 현재페이지
	private int startPage; // 시작페이지
	private int endPage; // 끝페이지
	private int total; // 게시글 총 개수
	private int cntPerPage; // 페이지당 글 수
	private int lastPage; // 마지막페이지
	private int start; // 페이지 시작글번호
	private int end; // 페이지 마지막글번호
	
	public int getNowPage() {
		return nowPage;
	}
	public void setNowPage(int nowPage) {
		this.nowPage = nowPage;
	}
	public int getStartPage() {
		return startPage;
	}
	public void setStartPage(int startPage) {
		this.startPage = startPage;
	}
	public int getEndPage() {
		return endPage;
	}
	public void setEndPage(int endPage) {
		this.endPage = endPage;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	public int getCntPerPage() {
		return cntPerPage;
	}
	public void setCntPerPage(int cntPerPage) {
		this.cntPerPage = cntPerPage;
	}
	public int getLastPage() {
		return lastPage;
	}
	public void setLastPage(int lastPage) {
		this.lastPage = lastPage;
	}
	public int getStart() {
		return start;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public int getEnd() {
		return end;
	}
	public void setEnd(int end) {
		this.end = end;
	}
}
