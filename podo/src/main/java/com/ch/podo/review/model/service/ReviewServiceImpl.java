package com.ch.podo.review.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.podo.film.model.vo.Film;
import com.ch.podo.review.model.dao.ReviewDao;
import com.ch.podo.review.model.vo.Review;

@Service("reviewService")
public class ReviewServiceImpl implements ReviewService{
	
	@Autowired
	private ReviewDao reviewDao;
	
	@Override
	public ArrayList<Review> selectReviewList() {
		
		return reviewDao.selectReviewList();
	}

	@Override
	public int deleteReview(int id) {
		
		return reviewDao.deleteReview(id);
	}
	
	@Override
	public int reviewWrite(Review r) {
		
		return reviewDao.reviewWrite(r);
	}

	@Override
	public Film selectFilm(int filmId) {
		
		return reviewDao.selectFilm(filmId);
	}

}
