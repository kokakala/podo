package com.ch.podo.board.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.podo.board.model.vo.Board;
import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.comment.model.vo.Comment;
import com.ch.podo.image.model.vo.Image;
import com.ch.podo.member.model.vo.Member;
import com.ch.podo.report.model.vo.Report;

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
	
	public int insertBoard(Board board) {
		return sqlSession.insert("boardMapper.insertBoard", board);
	}
	
	public int updateCount(int id) {
		return sqlSession.update("boardMapper.updateCount", id);
	}
	
	// 게시판 상세 조회
	public Board selectBoard(int id) {
		return sqlSession.selectOne("boardMapper.selectBoard", id);
	}
	
	// 게시판 상세 조회 (파일)
	public Image selectBoardFile(int id) {
		return sqlSession.selectOne("boardMapper.selectBoardFile", id);
	}
	
	
	public int deleteBoard(int id) {
		return sqlSession.update("boardMapper.deleteBoard", id);
	}
	
	
	public int updateBoard(Board b) {
		return sqlSession.update("boardMapper.updateBoard", b);
	}
	
	
	public int updateBoardFile(Image i) {
		return sqlSession.update("boardMapper.updateBoardFile", i);
	}
	
	
	// 댓글
	public ArrayList<Comment> selectCommentList(int id){
		return (ArrayList)sqlSession.selectList("boardMapper.selectCommentList", id);
	}
	
	
	public int insertComment(Comment c) {
		return sqlSession.insert("boardMapper.insertComment", c);
	}
	
	
	public int updateComment(int id, String content) {
		HashMap map = new HashMap<>();
		map.put("id", id);
		map.put("content", content);
		
		
		return sqlSession.update("boardMapper.updateComment", map);
	}
	
	
	public int deleteComment(int id) {
		return sqlSession.update("boardMapper.deleteComment", id);
	}
	
	
	
	public ArrayList<Board> selectboardListHome() {
		
		ArrayList<Board> list = (ArrayList)sqlSession.selectList("boardMapper.selectboardListHome");
		
		return list;
	}
	
	
	public int insertInappro(Report r) {
		return sqlSession.insert("boardMapper.insertInappro", r);
	}
	
	
	
}
