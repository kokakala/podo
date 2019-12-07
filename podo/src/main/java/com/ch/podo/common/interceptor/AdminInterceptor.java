package com.ch.podo.common.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ch.podo.member.model.vo.Member;

public class AdminInterceptor extends HandlerInterceptorAdapter {
	
	private Logger logger = LoggerFactory.getLogger(AdminInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		HttpSession session = request.getSession();

		Member loginUser = (Member) session.getAttribute("loginUser");

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		int adminNum = loginUser.getAutho();
		
		if (adminNum != 2) { // 일반사용자일 때
			logger.info("일반 사용자가 관리자페이지에 접속하려고 함");
			out.println("<script>alert('접근 불가능한 서비스입니다.');history.back();</script>");
			out.flush();
			return false;
		}
		return true;
		
	
	}

}
