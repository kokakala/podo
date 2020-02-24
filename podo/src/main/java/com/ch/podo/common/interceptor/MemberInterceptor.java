package com.ch.podo.common.interceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import com.ch.podo.member.model.service.MemberService;
import com.ch.podo.member.model.vo.Member;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class MemberInterceptor extends HandlerInterceptorAdapter {

	@Autowired
	private MemberService memberService;

	// private Logger logger = LoggerFactory.getLogger(MemberInterceptor.class);

	@Override
	public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

		Member loginUser = (Member) request.getSession().getAttribute("loginUser");
		
		response.setContentType("text/html; charset=UTF-8");
		// PrintWriter 객체를 또 생성하게 되면
		// getwriter() has already been called for this response
		// PrintWriter out = response.getWriter();

		if (loginUser == null) {
			log.info("Member Interceptor");
			response.getWriter().append("<script>alert('접근 권한이 없습니다.');location.href='home.do';</script>");
			// out.println("<script>alert('접근 권한이 없습니다.');history.back();</script>");
			// out.flush();
			return false;
		} else {
			int bid = loginUser.getId();
			int result = memberService.prohibitionBoard(bid);
			
			if (result > 0) { // 블랙리스트 회원일 때
				log.info("Black Member Interceptor");
				response.getWriter().append("<script>alert('블랙멤버는 접근 불가능한 서비스입니다.');history.back();</script>");
				// out.println("<script>alert('블랙멤버는 접근 불가능한 서비스입니다.');history.back();</script>");
				// out.flush();
				return false;
			}
			return true;
		}
	}
	
//	@Override
//	public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler,
//			@Nullable Exception ex) throws Exception {
//		Member loginUser = (Member) request.getSession().getAttribute("loginUser");
//		if (loginUser == null) {
//			log.info("Member postHandle");
//			response.getWriter().append("<script>$('#login-modal').trigger('click');</script>");
//		}
//	}


}
