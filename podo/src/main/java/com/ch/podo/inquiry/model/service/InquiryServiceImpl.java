package com.ch.podo.inquiry.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.inquiry.model.dao.InquiryDao;
import com.ch.podo.inquiry.model.vo.Inquiry;

@Service("inquiryService")
public class InquiryServiceImpl implements InquiryService{

	@Autowired
	private InquiryDao inquiryDao;

	@Override
	public int insertQuestion(Inquiry inq) {
		return inquiryDao.insertQuestion(inq);
	}

	@Override
	public int myPageInquiryListCount(String id) {
		return inquiryDao.myPageInquiryListCount(id);
	}

	@Override
	public  ArrayList<Inquiry> myPageSelectInquiryList(String id, PageInfo pi) {
		return inquiryDao.myPageSelectInquiryList(id, pi);
	}
}
