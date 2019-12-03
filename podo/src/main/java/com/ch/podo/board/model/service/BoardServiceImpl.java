package com.ch.podo.board.model.service;

import java.sql.SQLException;
import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.datasource.DataSourceTransactionManager;
import org.springframework.stereotype.Service;
import org.springframework.transaction.TransactionDefinition;
import org.springframework.transaction.TransactionStatus;
import org.springframework.transaction.support.DefaultTransactionDefinition;

import com.ch.podo.board.model.dao.BoardDao;
import com.ch.podo.board.model.vo.Board;
import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.comment.model.vo.Comment;
import com.ch.podo.image.model.vo.Image;

@Service("boardService")
public class BoardServiceImpl implements BoardService {
	
	@Autowired
	private BoardDao boardDao;
	
//	@Autowired
//	private DataSourceTransactionManager transactionManager;
	
	
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
	
	// 게시글 작성
	@Override
	public int insertBoard(Board b) {
		
		return boardDao.insertBoard(b);
		
		/*
		 * DefaultTransactionDefinition def = new DefaultTransactionDefinition();
		 * def.setPropagationBehavior(TransactionDefinition.PROPAGATION_REQUIRED);
		 * 
		 * TransactionStatus status = transactionManager.getTransaction(def);
		 * 
		 * try { sqlSession.getConnection().setAutoCommit(false); } catch (SQLException
		 * e) { e.printStackTrace(); }
		 */
				
	}
	
	
	// 게시글 첨부파일
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
	public Image selectBoardFile(int id) {
		return boardDao.selectBoardFile(id);
	}
	

	@Override
	public Board selectUpdateBoard(int id) {
		return boardDao.selectBoard(id);
	}
	
	@Override
	public Image selectUpdateBoardFile(int id) {
		return boardDao.selectBoardFile(id);
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
	public int updateBoardFile(Image i) {
		return boardDao.updateBoardFile(i);
	}
	
	// 댓글
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
