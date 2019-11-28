package com.ch.podo.inquiry.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.inquiry.model.service.InquiryService;
import com.ch.podo.inquiry.model.vo.Inquiry;

@Controller
public class InquiryController {
	@Autowired
	private InquiryService inquiryService;
	
	@RequestMapping("insertQuestion.do")
	public ModelAndView insertQuestion(Inquiry inq, ModelAndView mv) {
		
		int result = inquiryService.insertQuestion(inq);
		
		if(result > 0) {	// 업데이트 성공
			mv.addObject("msg", "문의 등록 성공").setViewName("member/myPage");
		}else {
			mv.addObject("msg", "문의 등록 실패").setViewName("member/myPage");
		}
		
		return mv;
	}
	
	@RequestMapping("myPageSelectQuestion.do")
	public ModelAndView myPageSelectQuestion(String tab, String id, ModelAndView mv) {
		ArrayList list = new ArrayList();
		System.out.println("문의");
		mv.addObject("list", list).addObject("tab", tab).setViewName("member/myPage");
		return mv;
	}
}
