package com.ch.podo.like.model.service;

import java.util.Map;

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
	
}
