package com.ch.podo.common;

import com.ch.podo.board.model.vo.PageInfo;

public class Pagination {
	
	/**
	 * @param currentPage
	 * @param listCount
	 * @return
	 * @author Changsu Im
	 */
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
	
	/**
	 * method to set a pageLimit and a boardLimit
	 * @param currentPage
	 * @param listCount
	 * @param page
	 * @param board
	 * @return new PageInfo
	 * @author Changsu Im
	 * @since 2019-11-24
	 */
	public static PageInfo setPageLimit(int currentPage, int listCount, int page, int board) {
		
		int pageLimit = page;
		int boardLimit = board;
		int maxPage = (int)Math.ceil((double)listCount / boardLimit);
		int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
		int endPage = startPage + pageLimit - 1;
		if (endPage > maxPage) {
			endPage = maxPage;
		}

		return new PageInfo(currentPage, listCount, pageLimit, maxPage, startPage, endPage, boardLimit);
	}
	
}
