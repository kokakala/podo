package com.ch.podo;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.film.model.service.FilmService;
import com.ch.podo.film.model.vo.Film;

@Controller
public class HomeController {
	
	@Autowired
	private FilmService f;
	
	@RequestMapping("home.do")
	public ModelAndView home(ModelAndView mv)
			throws Exception {
		
		ArrayList<Film> list = f.selectNewFilms();

		mv.addObject("list", list)
			.setViewName("home");

		return mv;
	}
	
}
