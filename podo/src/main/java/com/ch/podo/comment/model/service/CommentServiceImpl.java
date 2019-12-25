package com.ch.podo.comment.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.podo.comment.model.dao.CommentDao;
import com.ch.podo.comment.model.vo.Comment;

@Service("commentService")
public class CommentServiceImpl implements CommentService {

	@Autowired
	private CommentDao commentDao;

	@Override
	public ArrayList<Comment> selectCommentList(int id) {
		return commentDao.selectCommentList(id);
	}

	@Override
	public int insertComment(Comment c) {
		return commentDao.insertComment(c);
	}

	@Override
	public int updateComment(int id, String content) {
		return commentDao.updateComment(id, content);
	}

	@Override
	public int deleteComment(int id) {
		return commentDao.deleteComment(id);
	}

}
