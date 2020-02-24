package com.ch.podo.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ch.podo.board.model.service.BoardService;
import com.ch.podo.board.model.vo.Board;
import com.ch.podo.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class BoardInterceptor extends HandlerInterceptorAdapter {
	
	@Autowired
	private BoardService boardService;
	
	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		response.setContentType("text/html; charset=UTF-8");
		
		Member loginUser = (Member)request.getSession().getAttribute("loginUser");
		Integer boardId = Integer.parseInt(request.getParameter("id"));
		Board board = boardService.selectBoard(boardId);
		
		if (loginUser == null || loginUser.getId() != board.getMemberId()) {
			response.getWriter().append("<script>alert('게시글 작성자만 접근할 수 있습니다.');history.back();</script>");
			return false;
		}
		
		return true;
	}
}
