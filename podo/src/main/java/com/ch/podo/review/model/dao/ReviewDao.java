package com.ch.podo.review.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.podo.detailFilm.model.vo.DetailFilm;
import com.ch.podo.film.model.vo.Film;
import com.ch.podo.review.model.vo.Review;

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
	
	

}
