package com.ch.podo.ratingReview.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.podo.ratingReview.model.vo.RatingReview;
import com.ch.podo.review.model.vo.Review;

@Repository("ratingReviewDao")
public class RatingReviewDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;


	public RatingReview selectRatingReviewDetailView(int id) {
		
		return sqlSession.selectOne("ratingReviewMapper.selectRatingReviewDetailView",id);
	}


	public int reviewUpdate(RatingReview rr) {
	
		return sqlSession.update("ratingReviewMapper.reviewUpdate",rr);
	}



	
}
