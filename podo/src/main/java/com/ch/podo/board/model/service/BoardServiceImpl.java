package com.ch.podo.board.model.service;

import java.util.ArrayList;

import org.springframework.stereotype.Service;

import com.ch.podo.board.model.vo.Board;
import com.ch.podo.board.model.vo.PageInfo;

@Service("boardService")
public class BoardServiceImpl implements BoardService {

	@Override
	public int getBoardCount() {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public ArrayList<Board> selectList(PageInfo pi) {
		// TODO Auto-generated method stub
		return null;
	}

}
