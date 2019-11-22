package com.ch.podo.ratingFilm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.ratingFilm.model.service.RatingFilmService;
import com.ch.podo.ratingFilm.model.vo.RatingFilm;

@Controller
public class RatingFilmController {
	

	@Autowired
	private RatingFilmService ratingFilmService;
	
	@RequestMapping("star.do")
	public ModelAndView selectRatingFilm(RatingFilm rate,ModelAndView mv) {
		
		RatingFilm rf = ratingFilmService.selectRatingFilm(rate);
		
		mv.addObject("rf",rf).setViewName("ratingReview/star");
		
		System.out.println(rf);
		
		return mv;
		
	}

	
	
}
