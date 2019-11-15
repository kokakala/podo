package com.ch.podo.board.model.service;

import java.util.ArrayList;

import com.ch.podo.board.model.vo.Board;
import com.ch.podo.board.model.vo.PageInfo;

public interface BoardService {
	
	// 게시판 총 개수 조회용
	int getBoardCount();
	
	ArrayList<Board> selectList(PageInfo pi);
	
	
	
}
