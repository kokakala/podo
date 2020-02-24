package com.ch.podo.collection.controller;

import java.util.ArrayList;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class CollectionController {
	
//	@Autowired
//	private CollectionService collectionService;
	
	@RequestMapping("myPageSelectCollection")
	public ModelAndView myPageSelectCollection(String tab, String id, ModelAndView mv) {
		ArrayList<?> list = new ArrayList<>();
		log.info("mypage select collection");
		mv.addObject("list", list)
			.addObject("tab", tab)
			.setViewName("member/myPage");
		return mv;
	}

}
