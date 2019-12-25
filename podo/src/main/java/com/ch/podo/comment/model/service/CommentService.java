package com.ch.podo.comment.model.service;

import java.util.ArrayList;

import com.ch.podo.comment.model.vo.Comment;

public interface CommentService {
	
	// 댓글 리스트
	ArrayList<Comment> selectCommentList(int id);
	
	// 댓글 작성
	int insertComment(Comment c);
	
	// 댓글 수정
	int updateComment(int id, String content);
	
	// 댓글 삭제
	int deleteComment(int id);
}
