package com.ch.podo.inquiry.model.dao;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.inquiry.model.vo.Inquiry;

@Repository("inquiryDao")
public class InquiryDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int insertQuestion(Inquiry inq) {
		return sqlSession.insert("inquiryMapper.insertQuestion", inq);
	}
}
