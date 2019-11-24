package com.ch.podo.review.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.podo.film.model.vo.Film;
import com.ch.podo.member.model.vo.Member;
import com.ch.podo.ratingReview.model.vo.RatingReview;
import com.ch.podo.review.model.dao.ReviewDao;
import com.ch.podo.review.model.dto.Review;



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

	@Override
	public Member selectMember(int loginUserId) {
		
		return reviewDao.selectMember(loginUserId);
	}
	
	// 합친거
	
	@Override
	public Review selectRatingReviewDetailView(int id) {

		return reviewDao.selectRatingReviewDetailView(id);
	}

	@Override
	public Review selectUpdateReview(int id) {
		return reviewDao.selectRatingReviewDetailView(id);
	}


	@Override
	public int reviewUpdate(Review rr) {
		
		return reviewDao.reviewUpdate(rr);
	}

}
