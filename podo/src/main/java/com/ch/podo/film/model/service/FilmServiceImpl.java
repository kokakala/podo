package com.ch.podo.film.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.podo.film.model.dao.FilmDao;
import com.ch.podo.film.model.vo.Film;

@Service("filmService")
public class FilmServiceImpl implements FilmService {
	
	@Autowired
	private FilmDao filmDao;
	
	@Override
	public ArrayList<Film> selectKeywordFilmList(String keyword) {
		return filmDao.selectKeywordFilmList(keyword);
	}

	@Override
	public ArrayList<Film> selectFilterFilmList(Film film) {
		return filmDao.selectFilterFilmList(film);
	}
	
}
