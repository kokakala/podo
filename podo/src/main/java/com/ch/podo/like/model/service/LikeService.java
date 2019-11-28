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
	
}
