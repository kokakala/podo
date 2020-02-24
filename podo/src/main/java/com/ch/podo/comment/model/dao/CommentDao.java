package com.ch.podo.comment.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.podo.comment.model.vo.Comment;

@SuppressWarnings(value = "unchecked")
@Repository("commentDao")
public class CommentDao {
	
	@Autowired
	SqlSessionTemplate session;

	public ArrayList<Comment> selectCommentList(String tid, String type) {
		Map<String, String> map = new HashMap<>();
		map.put("tid", tid);
		map.put("type", type);
		return (ArrayList)session.selectList("commentMapper.selectCommentList", map);
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
