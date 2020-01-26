package com.ch.podo.common.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class TLSFilter implements Filter {
	private FilterConfig filterConfig;

	public void destroy() {
		if (this.filterConfig != null)
			this.filterConfig = null;
	}

	public void doFilter(ServletRequest request, ServletResponse response, FilterChain filterChain)
			throws IOException, ServletException {
		log.info("--Filter-- : SSL");
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse res = (HttpServletResponse) response;

		String sUri = req.getRequestURI();
		String sProtocol = req.getScheme();
		String sDomain = req.getServerName();
		// String sPort = Integer.toString(req.getServerPort()); // 443변경
		String sQueryString = req.getQueryString();
		
		log.info(sProtocol);
		log.info(sUri);
		
		if (sProtocol.toLowerCase().equals("http")) {
			response.setContentType("text/html");
			// HTTPS 도메인 세팅 및 쿼리스트링 추가
			StringBuilder httpsPath = new StringBuilder("https" + "://" + sDomain + ":443" + sUri);
			if (sQueryString != null && !"".equals(sQueryString)) {
				httpsPath.append("?").append(sQueryString);
			}
			res.setStatus(HttpServletResponse.SC_MOVED_PERMANENTLY);
			res.setHeader("Location", httpsPath.toString());
		}
		filterChain.doFilter(req, res);
	}

	public void init(FilterConfig filterConfig) throws ServletException {
		this.filterConfig = filterConfig;
	}
}
