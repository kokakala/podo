package com.ch.podo.ratingFilm.model.service;

import java.util.Map;

import com.ch.podo.ratingFilm.model.vo.RatingFilm;

public interface RatingFilmService {
	
	// 1. 영화 별점 평가 추가 서비스
	int insertRateFilm(RatingFilm rate);
	
	// 2. 영화 별점 평가 수정 서비스
	int updateLikeFilm(RatingFilm rate);
	
	// 3. 영화 별점 평가 삭제 서비스
	int deleteRateFilm(RatingFilm rate);
	
	// 4. 영화 별점 평가 조회 서비스
	RatingFilm selectRatingFilm(RatingFilm rate);
	
	// 5. 로그인된 사용자의 기존 평가 정보 조회 서비스
	Map<Integer, RatingFilm> selectRatedFilm(int id);
	
	// 6. 영화 봤어요 서비스
	int insertSawFilm(RatingFilm rate);
	
	// 7. 영화 봤어요 취소 서비스
	int deleteSawFilm(RatingFilm rate);
	
}
