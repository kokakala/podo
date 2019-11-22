package com.ch.podo.ratingReview.model.service;

import com.ch.podo.ratingReview.model.vo.RatingReview;
import com.ch.podo.review.model.vo.Review;

public interface RatingReviewService {
	
	// 영화 방사형그래프 상세리뷰 보기
	RatingReview selectRatingReviewDetailView(int id);

	// 리뷰 수정 조회용 서비스
	RatingReview selectUpdateReview(int id);
	
	// 리뷰 6개 점수 수정용 서비스
	int reviewUpdate(RatingReview rr);
	


}
