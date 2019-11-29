package com.ch.podo.inquiry.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.inquiry.model.vo.Inquiry;
import com.ch.podo.review.model.dto.Review;

@Repository("inquiryDao")
public class InquiryDao {

	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int insertQuestion(Inquiry inq) {
		return sqlSession.insert("inquiryMapper.insertQuestion", inq);
	}
	
	public int myPageInquiryListCount(String id) {
		return sqlSession.selectOne("inquiryMapper.myPageInquiryListCount", id);
	}
	
	public ArrayList<Inquiry> myPageSelectInquiryList(String id, PageInfo pi) {
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		ArrayList<Inquiry> list = (ArrayList)sqlSession.selectList("inquiryMapper.myPageSelectInquiryList", id, rowBounds);
		return list;
	}
}
