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
	public ArrayList<Comment> selectCommentList(int tid) {
		return commentDao.selectCommentList(tid);
	}

	@Override
	public int insertComment(Comment comment) {
		return commentDao.insertComment(comment);
	}

	@Override
	public int updateComment(Comment comment) {
		return commentDao.updateComment(comment);
	}

	@Override
	public int deleteComment(Comment comment) {
		return commentDao.deleteComment(comment);
	}

}
