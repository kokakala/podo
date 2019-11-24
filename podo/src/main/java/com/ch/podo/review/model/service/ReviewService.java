package com.ch.podo.review.model.service;

import java.util.ArrayList;

import com.ch.podo.film.model.vo.Film;
import com.ch.podo.member.model.vo.Member;
import com.ch.podo.ratingReview.model.vo.RatingReview;
import com.ch.podo.review.model.dto.Review;


public interface ReviewService {
	
	//영화 리뷰 보기
	ArrayList<Review> selectReviewList();
	
	//영화 리뷰 삭제
	int deleteReview(int id);
	
	//영화 리뷰 작성
	int reviewWrite(Review r);
	
	//영화 제목 가져오는거
	Film selectFilm(int filmId);
	
	//유저 가져오는거
	Member selectMember(int loginUserId);
	
	// 영화 방사형그래프 상세리뷰 보기
	Review selectRatingReviewDetailView(int id);

	// 리뷰 수정 조회용 서비스
	Review selectUpdateReview(int id);
	
	// 리뷰 6개 점수 수정용 서비스
	int reviewUpdate(Review r);
}
