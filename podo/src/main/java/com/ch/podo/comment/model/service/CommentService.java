package com.ch.podo.comment.model.service;

import java.util.ArrayList;

import com.ch.podo.comment.model.vo.Comment;

public interface CommentService {
	
	ArrayList<Comment> selectCommentList(int tid);
	
	int insertComment(Comment comment);
	
	int updateComment(Comment comment);
	
	int deleteComment(Comment comment);
}
