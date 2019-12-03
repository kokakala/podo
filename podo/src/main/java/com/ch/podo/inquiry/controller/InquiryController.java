package com.ch.podo.inquiry.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.common.Pagination;
import com.ch.podo.inquiry.model.service.InquiryService;
import com.ch.podo.inquiry.model.vo.Inquiry;

@Controller
public class InquiryController {
	@Autowired
	private InquiryService inquiryService;
	
	@RequestMapping("insertQuestion.do")
	public ModelAndView insertQuestion(Inquiry inq, ModelAndView mv) {
		String id = String.valueOf(inq.getUserId());
		int result = inquiryService.insertQuestion(inq);
		
		if(result > 0) {	// 업데이트 성공
			mv.setViewName("redirect:myPage.do?id="+id);
		}else {
			mv.addObject("msg", "문의 등록 실패").setViewName("member/myPage");
		}
		
		return mv;
	}
	
	@RequestMapping("myPageSelectQuestion.do")
	public ModelAndView myPageSelectQuestion(String tab, String id, ModelAndView mv, @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		int listCount = inquiryService.myPageInquiryListCount(id);
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Inquiry> inquiryList = inquiryService.myPageSelectInquiryList(id,pi);
		mv.addObject("inquiry", inquiryList).addObject("inquiryPi", pi).addObject("tab", tab).setViewName("member/myPage");
		
		return mv;
	}
	
	@ResponseBody
	@RequestMapping("dbInquiryInsert.do")
	public String dbInquiryInsert(String content, String userId) {
		System.out.println("컨트" + content);
		System.out.println("컨트아이디" +userId);
		int result = inquiryService.dbInquiryInsert(content, userId);
		
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
}
