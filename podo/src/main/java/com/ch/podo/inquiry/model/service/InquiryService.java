package com.ch.podo.inquiry.model.service;

import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.inquiry.model.vo.Inquiry;

public interface InquiryService {

	// 1. 문의 등록
	int insertQuestion(Inquiry inq);
}
