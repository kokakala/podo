package com.ch.podo.board.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.podo.board.model.dao.BoardDao;
import com.ch.podo.board.model.vo.Board;
import com.ch.podo.board.model.vo.PageInfo;

@Service("boardService")
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDao boardDao;

	@Override
	public int getBoardCount() {
		return boardDao.getBoardCount();
	}

	@Override
	public ArrayList<Board> selectBoardList(PageInfo pi) {
		return boardDao.selectBoardList(pi);
	}

	@Override
	public int insertBoard(Board b) {
		return 0;
	}
	
	

}
