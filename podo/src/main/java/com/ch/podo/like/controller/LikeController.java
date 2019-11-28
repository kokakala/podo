package com.ch.podo.like.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.like.model.service.LikeService;

@Controller
public class LikeController {

	@Autowired
	private LikeService likeService;
	
	@RequestMapping("myPageSelectLike.do")
	public ModelAndView myPageSelectLike(String tab, String id, ModelAndView mv) {
		ArrayList list = new ArrayList();
		System.out.println("라잌");
		mv.addObject("list", list).addObject("tab", tab).setViewName("member/myPage");
		return mv;
	}
}
