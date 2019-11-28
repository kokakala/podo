package com.ch.podo.review.model.service;

import java.util.ArrayList;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.detailFilm.model.vo.DetailFilm;
import com.ch.podo.film.model.vo.Film;
import com.ch.podo.member.model.vo.Member;
import com.ch.podo.review.model.dto.Review;


public interface ReviewService {
	
	// 총 리뷰 갯수 조회용 서비스
	int getReviewListCount(); 
		
	//영화 리뷰 보기
	ArrayList<Review> selectReviewList(PageInfo pi);
	
	//관리자 영화 리뷰 리스트
	ArrayList<Review> selectAdReviewList();	
	
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

	// 리뷰 내용 수정
	int reviewUpdateContent(Review r);
	
	// 마이페이지 _리뷰리스트 카운트
	int myPageReviewListCount(String id);
	
	// 마이페이지_리뷰리스트 조회
	ArrayList<Review> myPageSelectReviewList(String id, PageInfo pi);
	
	// 영화페이지 메인에 올것
	ArrayList<Review> selectReviewListMain();

	// 그래프 점수입력할때
	int reviewRating(Review r);


	// 영화 상세자료, 유저아이디
	//int reivewInsert(DetailFilm df);
	
	// 리뷰 조회용 +@
	//Review	selectReview();
	
}
