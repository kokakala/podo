package com.ch.podo.common;

import com.ch.podo.board.model.vo.PageInfo;

public class Pagination {
	
	public static PageInfo getPageInfo(int currentPage, int listCount) {
		
		int pageLimit = 5;
		int boardLimit = 10;
		int maxPage = (int)Math.ceil((double)listCount / boardLimit);
		int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
		int endPage = startPage + pageLimit - 1;
		if (endPage > maxPage) {
			endPage = maxPage;
		}
		
		return new PageInfo(currentPage, listCount, pageLimit, maxPage, startPage, endPage, boardLimit);
	}
	
}
