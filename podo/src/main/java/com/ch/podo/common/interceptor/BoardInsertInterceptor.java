package com.ch.podo.common.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ch.podo.common.interceptor.BoardInsertInterceptor;
import com.ch.podo.member.model.service.MemberService;
import com.ch.podo.member.model.vo.Member;

public class BoardInsertInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private MemberService memberService;

	private Logger logger = LoggerFactory.getLogger(BoardInsertInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		HttpSession session = request.getSession();

		Member loginUser = (Member) session.getAttribute("loginUser");

		if (loginUser == null) {
			logger.info("비로그인 상태에서 작성하려고 함");
			response.setContentType("text/html; charset=UTF-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('회원이 아니면 접근 불가능한 서비스입니다.');history.back();</script>");
			out.flush();
			return false; // 실행 실패

		} else {
			int bid = loginUser.getId();

			int result = memberService.prohibitionBoard(bid);

			if (result == 1) { // 블랙리스트 회원일 때
				logger.info("블랙리스트인 상태에서 게시물 작성하려 함");
				response.setContentType("text/html; charset=UTF-8");
				PrintWriter out = response.getWriter();
				out.println("<script>alert('블랙리스트 회원은 접근 불가능한 서비스입니다.');history.back();</script>");
				out.flush();
				return false;
			}
			return true;
		}
	}
}
