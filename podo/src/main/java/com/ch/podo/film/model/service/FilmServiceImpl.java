package com.ch.podo.film.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.common.SearchCondition;
import com.ch.podo.film.model.dao.FilmDao;
import com.ch.podo.film.model.vo.Film;
import com.ch.podo.film.model.vo.Genre;
import com.ch.podo.image.model.vo.Image;

@Service("filmService")
public class FilmServiceImpl implements FilmService {
	
	@Autowired
	private FilmDao filmDao;
	
	@Override
	public int getListCount() {
		return filmDao.getListCount();
	}

	@Override
	public int selectKeywordFilmListCount(String keyword) {
		return filmDao.selectKeywordFilmListCount(keyword);
	}

	@Override
	public ArrayList<Film> selectKeywordFilmList(String keyword, PageInfo pi) {
		return filmDao.selectKeywordFilmList(keyword, pi);
	}

	@Override
	public ArrayList<Genre> selectAllGenreList() {
		return filmDao.selectAllGenreList();
	}

	@Override
	public ArrayList<Film> selectFilterFilmList(SearchCondition sc, PageInfo pi) {
		return filmDao.selectFilterFilmList(sc, pi);
	}
	
	@Override
	public ArrayList<Film> selectFilterFilmMap(Map<String, Object> map) {
		return filmDao.selectFilterFilmMap(map);
	}

	@Override
	public int getFilmListCount() {
		return filmDao.getFilmListCount();
	}

	@Override
	public ArrayList<Film> selectFilmList() {
		return filmDao.selectFilmList();
	}
	
	@Override
	public int insertFilm(Film f) {
		return filmDao.insertFilm(f);
	}

	@Override
	public int insertFilmImage(Image img) {
		return filmDao.insertFilmImage(img);
	}

	@Override
	public Film selectFilm(int id) {
			return filmDao.selectFilm(id);
	}

	@Override
	public int selectLikedFilmCount(int id) {
		return filmDao.selectLikedFilmCount(id);
	}

	@Override
	public ArrayList<Film> selectLikedFilmList(int id, PageInfo pi) {
		return filmDao.selectLikedFilmList(id, pi);
	}

	@Override
	public ArrayList<Film> selectPreferredGenreFilmList(int id) {
		return filmDao.selectPreferredGenreFilmList(id);
	}

	@Override
	public ArrayList<String> selectAllCountryList() {
		return filmDao.selectAllCountryList();
	}

	@Override
	public ArrayList<String> selectAllReleaseYearList() {
		return filmDao.selectAllReleaseYearList();
	}

	@Override
	public int selectFilterFilmListCount(SearchCondition sc) {
		return filmDao.selectFilterFilmListCount(sc);
	}

	@Override
	public ArrayList<Film> selectNewFilms() {
		return filmDao.selectNewFilms();
	}

}
