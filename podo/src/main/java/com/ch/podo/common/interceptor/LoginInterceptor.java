package com.ch.podo.common.interceptor;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.ui.ModelMap;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

public class LoginInterceptor extends HandlerInterceptorAdapter {
	
	private Logger logger = LoggerFactory.getLogger(MemberInterceptor.class);
	
//	@Override
//	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
//		HttpSession session = request.getSession();
//		
//		// URL로 접근시 invalidate
//		if (session.getAttribute("loginUser") != null) {
//			session.invalidate();
//			// logger.info("loginUser != null");
//		}
//		// logger.info("login preHandle");
//		return true;
//	}
	
	@Override
	public void postHandle(HttpServletRequest request, HttpServletResponse response,
														Object handler, ModelAndView mv) throws Exception {
		
		// logger.info("login postHandle");
		ModelMap modelMap = mv.getModelMap();
		
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();
		
		if (modelMap.get("loginFail") != null) {
			logger.info("로그인 실패");
			
			
			
			out.println("<script>alert('아이디와 비밀번호가 일치하지 않습니다.');</script>");
			out.flush();
		}
	}
	
}
