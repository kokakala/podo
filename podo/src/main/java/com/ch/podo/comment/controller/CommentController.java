package com.ch.podo.comment.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.ch.podo.comment.model.service.CommentService;
import com.ch.podo.comment.model.vo.Comment;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CommentController {

	@Autowired
	private CommentService commentService;

	// 댓글 조회
	@ResponseBody
	@RequestMapping(value = "commentsList.do", produces = "application/json; charset=UTF-8")
	public String CommentList(int id) {

		ArrayList<Comment> list = commentService.selectCommentList(id);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();

		return gson.toJson(list);

	}

	// 댓글 작성
	@RequestMapping("insertComment.do")
	public String insertComment(Comment comment) {

		int result = commentService.insertComment(comment);

		if (result > 0) {
			return "success";
		} else {
			return "fail";
		}

	}

	// 댓글 수정
	@RequestMapping("updateComment.do")
	public String updateComment(int id, String content) {

		int result = commentService.updateComment(id, content);

		if (result > 0) {
			return "success";
		} else {
			return "fail";
		}

	}

	// 댓글 삭제
	@RequestMapping("deleteComment.do")
	public String deleteComment(int id) {

		int result = commentService.deleteComment(id);

		if (result > 0) {
			return "success";
		} else {
			return "fail";
		}

	}
}