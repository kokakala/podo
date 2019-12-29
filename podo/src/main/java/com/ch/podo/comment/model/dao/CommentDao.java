package com.ch.podo.comment.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.podo.comment.model.vo.Comment;

@Repository("commentDao")
public class CommentDao {
	
	@Autowired
	SqlSessionTemplate session;

	public ArrayList<Comment> selectCommentList(int tid) {
		return (ArrayList)session.selectList("commentMapper.selectCommentList", tid);
	}

	public int insertComment(Comment comment) {
		return session.insert("commentMapper.insertComment", comment);
	}

	public int updateComment(Comment comment) {
		return session.update("commentMapper.updateComment", comment);
	}

	public int deleteComment(Comment comment) {
		return session.update("commentMapper.deleteComment", comment);
	}

}
