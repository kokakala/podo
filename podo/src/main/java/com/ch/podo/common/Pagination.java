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
	 * pageLimit과 boardLimit을 새로 받기 위한 메서드
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
	
	/**
	 * pageLimit과 boardLimit을 유지한 채로 새로운 리스트(listCount)를 받아서 페이징 처리를 하기 위한 메서드
	 * @param currentPage
	 * @param listCount
	 * @param pi
	 * @return
	 * @author Changsu Im
	 * @since 2019-11-25
	 */
	public static PageInfo setNewPageLimit(int currentPage, int listCount, PageInfo pi) {
		
		int pageLimit = pi.getPageLimit();
		int boardLimit = pi.getBoardLimit();
		int maxPage = (int)Math.ceil((double)listCount / boardLimit);
		int startPage = (currentPage - 1) / pageLimit * pageLimit + 1;
		int endPage = startPage + pageLimit - 1;
		if (endPage > maxPage) {
			endPage = maxPage;
		}
		
		return new PageInfo(currentPage, listCount, pageLimit, maxPage, startPage, endPage, boardLimit);
	}
	
}
