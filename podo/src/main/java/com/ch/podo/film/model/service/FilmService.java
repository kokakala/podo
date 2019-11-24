package com.ch.podo.film.model.service;

import java.util.ArrayList;
import java.util.Map;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.common.SearchCondition;
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
	ArrayList<Film> selectFilterFilmList(SearchCondition sc, PageInfo pi);
	ArrayList<Film> selectFilterFilmMap(Map<String, Object> map);
	
	// 6. 사용자가 좋아요 누른 영화 목록 개수 조회
	int selectLikedFilmCount(int id);

	// 7. 사용자가 좋아요 누른 영화 목록 조회
	ArrayList<Film> selectLikedFilmList(int id, PageInfo pi);
	
	// 8. 좋아요를 기반으로 한 선호 장르 List 데이터 조회
	ArrayList<Film> selectPreferredGenreFilmList(int id);
	
	// 9. 등록된 영화의 국가 목록
	ArrayList<String> selectAllCountryList();
	
	// 10-1. 관리자 영화 게시판 총 갯수 조회용 서비스
	int getFilmListCount();
	
	// 10-2. 현재 페이지에 보여질 영화 리스트 조회용 서비스
	ArrayList<Film> selectFilmList(PageInfo pi);
	
	// 11. 영화 등록하기 서비스
	int insertFilm(Film f);
	
	// 12. 영화 상세보기 서비스
	Film selectFilm(int id);
	
	// 13. 등록된 영화의 연도 목록
	ArrayList<String> selectAllReleaseYearList();
	
	// 14. 필터 검색된 영화 개수
	int selectFilterFilmListCount(SearchCondition sc);
	
	// 15. 최신 등록 영화 조회 서비스
	ArrayList<Film> selectNewFilms();

}
