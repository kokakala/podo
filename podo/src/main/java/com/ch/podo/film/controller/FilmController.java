package com.ch.podo.film.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.film.model.service.FilmService;
import com.ch.podo.film.model.vo.Film;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;

@Controller
public class FilmController {
	
	@Autowired
	private FilmService filmService;
	
	@RequestMapping("skFilm.do")
	public ModelAndView searchKeywordFilm(ModelAndView mv, String keyword) {
		
		System.out.println("keyword : " + keyword);
		ArrayList<Film> list = filmService.selectKeywordFilmList(keyword);
		System.out.println("list : " + list);
		mv.addObject("list", list);
		mv.setViewName("search/searchAll");
		
		return mv;
	}
	
	@RequestMapping("film.do")
	public String filmPage() {
		return "film/filmPage";
	}
	
	@RequestMapping("sfFilm.do")
	public void searchFilterFilm(HttpServletResponse response, Film film) throws JsonIOException, IOException {
		System.out.println("film : " + film);
		ArrayList<Film> list = filmService.selectFilterFilmList(film);
		System.out.println("list : " + list);
		
		response.setContentType("application/json; charset=utf-8");
		Gson gson = new Gson();
		gson.toJson(list, response.getWriter());
	}
}
