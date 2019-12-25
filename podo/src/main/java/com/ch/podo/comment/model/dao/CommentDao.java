package com.ch.podo.comment.model.dao;

import java.util.ArrayList;

import org.springframework.stereotype.Repository;

import com.ch.podo.comment.model.vo.Comment;

@Repository("commentDao")
public class CommentDao {

	public ArrayList<Comment> selectCommentList(int id) {
		return null;
	}

	public int insertComment(Comment c) {
		return 0;
	}

	public int updateComment(int id, String content) {
		return 0;
	}

	public int deleteComment(int id) {
		return 0;
	}

}
