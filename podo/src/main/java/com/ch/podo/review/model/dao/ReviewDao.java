package com.ch.podo.review.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.podo.detailFilm.model.vo.DetailFilm;
import com.ch.podo.film.model.vo.Film;
import com.ch.podo.member.model.vo.Member;
import com.ch.podo.ratingReview.model.vo.RatingReview;
import com.ch.podo.review.model.dto.Review;


@Repository("reviewDao")
public class ReviewDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
							 
	public ArrayList<Review> selectReviewList() {
		
		ArrayList<Review> list = (ArrayList)sqlSession.selectList("reviewMapper.selectReviewList");
		
		return list;
	}

	public int deleteReview(int id) {
		
		return sqlSession.update("reviewMapper.deleteReview",id);
	}

	public int reviewWrite(Review r) {
		
		return sqlSession.insert("reviewMapper.reviewWrite",r);
	}

	public Film selectFilm(int filmId) {
		
		Film f = sqlSession.selectOne("reviewMapper.selectFilm", filmId);
		
		System.out.println("f : " + f);
		return f;
	}

	public Member selectMember(int loginUserId) {
		
		Member m = sqlSession.selectOne("reviewMapper.selectMember", loginUserId);
		
		System.out.println("m : " +m);
		return m;
	}
	
	// 합친거
	public Review selectRatingReviewDetailView(int id) {
		
		return sqlSession.selectOne("reviewMapper.selectRatingReviewDetailView",id);
	}


	public int reviewUpdate(Review r) {
	
		return sqlSession.update("reviewMapper.reviewUpdate",r);
	}
	

}
