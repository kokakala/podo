package com.ch.podo.board.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

@Controller
public class InfoController {
	
	@RequestMapping("termsofuse.do")
	public ModelAndView termsOfUse(ModelAndView mv) {
		
		mv.setViewName("board/termsOfUseForm");
		
		return mv;
		
	}
	
	
	@RequestMapping("privacyPolicy.do")
	public ModelAndView privacyPolicy(ModelAndView mv) {
		
		mv.setViewName("board/privacyPolicyForm");
		
		return mv;
		
	}
	
	
	@RequestMapping("faq.do")
	public ModelAndView faq(ModelAndView mv) {
		
		mv.setViewName("board/faqForm");
		
		return mv;
		
	}
	

}
