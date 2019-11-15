package com.ch.podo.ratingReview.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.ratingReview.model.service.RatingReviewService;

@Controller
public class RatingReviewController {
	
	
	@Autowired
	private RatingReviewService ratingReviewService;
	
	@RequestMapping("ratingReview.do")
	public ModelAndView ratingReview(ModelAndView mv) {
		
		
		
		return mv;
	}

}
