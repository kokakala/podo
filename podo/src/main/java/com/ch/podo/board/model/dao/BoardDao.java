package com.ch.podo.board.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.podo.board.model.vo.Board;
import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.comment.model.vo.Comment;
import com.ch.podo.image.model.vo.Image;
import com.ch.podo.member.model.vo.Member;

@Repository("boardDao")
public class BoardDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	
	public int getBoardCount() {
		return sqlSession.selectOne("boardMapper.getBoardCount");
	}
	
	
	public ArrayList<Board> selectBoardList(PageInfo pi){
		
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		ArrayList<Board> list = (ArrayList)sqlSession.selectList("boardMapper.selectBoardList", null, rowBounds);
		
		return list;		
		
	}
	
	
	public int insertBoard(Board b) {		
		return sqlSession.insert("boardMapper.insertBoard", b);
		
	}
	
	
	public int insertBoardFile(Image i) {
		return sqlSession.insert("boardMapper.insertBoardFile", i);
	}
	
	
	public int updateCount(int id) {
		return sqlSession.update("boardMapper.updateCount", id);
	}
	
	
	public Board selectBoard(int id) {
		return sqlSession.selectOne("boardMapper.selectBoard", id);
	}
	
	
	public int deleteBoard(int id) {
		return sqlSession.update("boardMapper.deleteBoard", id);
	}
	
	
	public int updateBoard(Board b) {
		return sqlSession.update("boardMapper.updateBoard", b);
	}
	
	
	// 댓글
	public ArrayList<Comment> selectCommentList(int id){
		
		return (ArrayList)sqlSession.selectList("boardMapper.selectCommentList", id);
	}
	
	
	public int insertComment(Comment c) {
		return sqlSession.insert("boardMapper.insertComment", c);
	}
	
	
	public ArrayList<Board> selectboardListHome() {
		
		ArrayList<Board> list = (ArrayList)sqlSession.selectList("boardMapper.selectboardListHome");
		
		return list;
	}
	
	
	
	
}
