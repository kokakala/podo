package com.ch.podo.like.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.like.model.service.LikeService;
import com.ch.podo.like.model.vo.Like;

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
	
	@ResponseBody
	@RequestMapping("likeClick.do")
	public int likeClick(Like like, String status) {
		
		int result = 0;
		
		if(status.equals("like")) {
			result = likeService.insertLikeMem(like);
				
		}else {
			result = likeService.deleteLikeMem(like);
		}
		return result;
	}
}
