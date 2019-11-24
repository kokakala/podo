package com.ch.podo.board.model.service;

import java.util.ArrayList;

import com.ch.podo.board.model.vo.Board;
import com.ch.podo.board.model.vo.PageInfo;

public interface BoardService {
	
	// 게시판 총 개수 조회
	int getBoardCount();
	
	// 현재 페이지에 보여지는 게시글 리스트 조회
	ArrayList<Board> selectBoardList(PageInfo pi);
	
	// 게시판 작성
	int insertBoard(Board b);
	
	// 게시판 상세 조회
	Board selectBoard(int id);
	
	// 수정 및 삭제하고자 하는 게시판 조회
	Board selectUpdateBoard(int id);
	
	// 게시판 삭제
	int deleteBoard(int id);
	
	// 게시판 수정
	int updateBoard(Board b);
	
	
}
