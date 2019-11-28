package com.ch.podo.board.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.podo.board.model.dao.BoardDao;
import com.ch.podo.board.model.vo.Board;
import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.comment.model.vo.Comment;
import com.ch.podo.image.model.vo.Image;

@Service("boardService")
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDao boardDao;
	
	// 게시판 총 개수
	@Override
	public int getBoardCount() {
		return boardDao.getBoardCount();
	}
	
	// 게시글 리스트
	@Override
	public ArrayList<Board> selectBoardList(PageInfo pi) {
		return boardDao.selectBoardList(pi);
	}

	@Override
	public int insertBoard(Board b) {
		return boardDao.insertBoard(b);
	}
	
	@Override
	public int insertBoardFile(Image i) {
		return boardDao.insertBoardFile(i);
	}
	
	@Override
	public Board selectBoard(int id) {
		
		int result = boardDao.updateCount(id);
		
		if(result > 0) {
			return boardDao.selectBoard(id);
		}else {
			return null;
		}
		
	}

	@Override
	public Board selectUpdateBoard(int id) {
		return boardDao.selectBoard(id);
	}

	@Override
	public int deleteBoard(int id) {
		return boardDao.deleteBoard(id);
	}

	@Override
	public int updateBoard(Board b) {
		return boardDao.updateBoard(b);
	}
		
	@Override
	public ArrayList<Comment> selectCommentList(int id) {
		return boardDao.selectCommentList(id);
	}
	
	@Override
	public int insertComment(Comment c) {
		return boardDao.insertComment(c);
	}
	
	@Override
	public ArrayList<Board> selectboardListHome() {
		
		return boardDao.selectboardListHome();
	}


}
