package com.ch.podo.like.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.like.model.vo.Like;

public interface LikeService {
	
	
	// 1. 영화 좋아요 서비스
	int insertLikeFilm(Like like);
	
	// 2. 영화 좋아요 취소 서비스
	int deleteLikeFilm(Like like);

	// 3. 사용자가 좋아요 누른 영화 목록 조회
	Map<Integer, Like> selectLikedFilmMap(int id);
	
	// 4. 로그인한 유저가 다른 유저페이지 들어갈때 (로그인유저가 다른유저 좋아요 한 여부 조회)
	Like selectLikeUser(String userId, String loginUserId);
	
	// 5. 회원 좋아요 
	int insertLikeMem(Like like);
	
	// 6. 회원 좋아요 취소
	int deleteLikeMem(Like like);
	
	// 7_1. 마이페이지_ 영화좋아요 리스트 카운트
	int myPageLikeFilmListCount(String id);
	
	// 7_2. 마이페이지_ 영화좋아요 조회 
	ArrayList<Like> myPageSelectLikeFilm(String id,PageInfo pi);
	 
	// 8_1. 마이페이지_유저좋아요 리스트 카운트
	int myPageLikeUserListCount(String id);
	
	// 8_2. 마이페이지_유저좋아요 조회
	ArrayList<Like> myPageSelectLikeUser(String id, PageInfo pi);
	
	// 9_1. 마이페이지_리뷰좋아요 리스트 카운트
	int myPageLikeReviewListCount(String id);
	
	// 8_2. 마이페이지_리뷰좋아요 조회
	ArrayList<Like> myPageSelectLikeReview(String id, PageInfo pi);

	// 리뷰 좋아요 
	int insertLikeReview(Like like);
	
	// 리뷰 좋아요 취소
	int deleteLikeReview(Like like);
	
}
