package com.ch.podo;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;
import java.util.Map.Entry;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.film.model.service.FilmService;
import com.ch.podo.film.model.vo.Film;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class HomeController {
	
	@Autowired
	private FilmService f;
	
	@RequestMapping("home.do")
	public ModelAndView home(ModelAndView mv,HttpSession session,HttpServletRequest request)throws Exception {
		ArrayList<Film> list = f.selectNewFilms();
		mv.addObject("list", list).setViewName("home");
		return mv;
	}

	@RequestMapping(value = "/error/{error_code}.do")
	public ModelAndView error(HttpServletRequest request, @PathVariable String error_code) {
		// root-context.xml
		// web.xml
		// log.info("error_code : " + error_code);
		ModelAndView mv = new ModelAndView("common/error");
		String msg = (String) request.getAttribute("javax.servlet.error.message");

		Map<String, Object> map = new HashMap<String, Object>();
		map.put("STATUS_CODE", request.getAttribute("javax.servlet.error.status_code"));
		map.put("REQUEST_URI", request.getAttribute("javax.servlet.error.request_uri"));
		map.put("EXCEPTION_TYPE", request.getAttribute("javax.servlet.error.exception_type"));
		map.put("EXCEPTION", request.getAttribute("javax.servlet.error.exception"));
		map.put("SERVLET_NAME", request.getAttribute("javax.servlet.error.servlet_name"));
		map.put("ERROR_CODE", error_code);

		try {
			int status_code = Integer.parseInt(error_code);
			switch (status_code) {
			// 400: Client Error
			case 400: msg = "Bad Request"; break;
			case 401: msg = "Unauthorized"; break;
			case 403: msg = "Forbidden"; break;
			case 404: msg = "Not Found"; break;
			case 405: msg = "Method Not Allowed"; break;
			case 406: msg = "Not Acceptable"; break;
			case 407: msg = "Proxy Authentication Required"; break;
			case 408: msg = "Request Timeout"; break;
			case 414: msg = "URL Too Long"; break;
			
			// 500: Server Error
			case 500: msg = "Internal Server Error"; break;
			case 502: msg = "Bad Gateway"; break;
			case 503: msg = "Service Unavailable"; break;
			case 504: msg = "Gateway Timeout"; break;
			case 520: msg = "Unknown Error"; break;
			default: msg = "Unknown Error"; break;
			}
		} catch (NumberFormatException e) {
			map.replace("ERROR_CODE", "ERROR");
			msg = "Unknown Error";
		} finally {
			map.put("MESSAGE", msg);
		}

		// logging
		if (map.isEmpty() == false) {
			Iterator<Entry<String, Object>> iterator = map.entrySet().iterator();
			Entry<String, Object> entry = null;
			while (iterator.hasNext()) {
				entry = iterator.next();
				log.info("key : " + entry.getKey() + ", value : " + entry.getValue());
			}
		}
		
		mv.addObject("error", map);
		return mv;
	}
}
