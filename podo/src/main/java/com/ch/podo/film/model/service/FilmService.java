package com.ch.podo.film.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.film.model.vo.Film;
import com.ch.podo.film.model.vo.Genre;

public interface FilmService {

	// 1. 영화 데이터 전체 개수 조회 서비스
	int getListCount();
	
	// 2. 영화 키워드 검색 결과 개수 조회 서비스
	int selectKeywordFilmListCount(String keyword);

	// 3. 영화 키워드 검색 서비스
	ArrayList<Film> selectKeywordFilmList(String keyword, PageInfo pi);
	
	// 4. 전체 장르 목록 불러오기 서비스
	ArrayList<Genre> selectAllGenreList();
	
	// 5. 영화 필터 검색 서비스
	ArrayList<Film> selectFilterFilmList(Film film);
	ArrayList<Film> selectFilterFilmMap(Map<String, Object> map);
	
	// 6. 사용자가 좋아요 누른 영화 목록 개수 조회
	int selectLikedFilmCount(int id);

	// 7. 사용자가 좋아요 누른 영화 목록 조회
	ArrayList<Film> selectLikedFilmList(int id, PageInfo pi);
	
	// 8. 좋아요를 기반으로 한 선호 장르 List 데이터 조회
	ArrayList<Film> selectPreferredGenreFilmList(int id);
	
	

}
