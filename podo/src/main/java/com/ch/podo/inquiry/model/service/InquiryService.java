package com.ch.podo.inquiry.model.service;

import java.util.ArrayList;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.inquiry.model.vo.Inquiry;

public interface InquiryService {

	// 1. 문의 등록
	int insertQuestion(Inquiry inq);
	
	// 2_1. 문의 갯수 조회 (페이징처리)
	int myPageInquiryListCount(String id);
	
	// 2_2. 문의 리스트 조회
	ArrayList<Inquiry> myPageSelectInquiryList(String id, PageInfo pi);
	
	// 3. DB제보
	int dbInquiryInsert(String content, String userId);
	
	// 4. 관리자 문의 리스트 조회
	ArrayList<Inquiry> selectInquiryList();

}
