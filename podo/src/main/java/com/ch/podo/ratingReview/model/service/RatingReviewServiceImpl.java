package com.ch.podo.ratingReview.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.podo.ratingReview.model.dao.RatingReviewDao;
import com.ch.podo.ratingReview.model.vo.RatingReview;


@Service("ratingReviewService")
public class RatingReviewServiceImpl implements RatingReviewService {
	
	@Autowired
	private RatingReviewDao ratingReviewDao;

	
	/*
	 * @Override public RatingReview selectRatingReviewDetailView(int id) {
	 * 
	 * return ratingReviewDao.selectRatingReviewDetailView(id); }
	 * 
	 * @Override public RatingReview selectUpdateReview(int id) { return
	 * ratingReviewDao.selectRatingReviewDetailView(id); }
	 * 
	 * @Override public int reviewUpdate(RatingReview rr) {
	 * 
	 * return ratingReviewDao.reviewUpdate(rr);
	 * 
	 * 
	 * }
	 */
	  
}
