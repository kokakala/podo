package com.ch.podo.board.model.service;

import java.util.ArrayList;

import com.ch.podo.board.model.vo.Board;
import com.ch.podo.board.model.vo.PageInfo;

public interface BoardService {
	
	// 게시판 총 개수 조회용
	int getBoardCount();
	
	// 현재 페이지에 보여지는 게시글 리스트 조회용
	ArrayList<Board> selectBoardList(PageInfo pi);
	
	// 게시판 작성
	int insertBoard(Board b);
	
	
}
