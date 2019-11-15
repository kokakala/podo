package com.ch.podo.film.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.podo.film.model.vo.Film;

@Repository("filmDao")
public class FilmDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public ArrayList<Film> selectKeywordFilmList(String keyword) {
		return (ArrayList)sqlSession.selectList("filmMapper.selectKeywordFilmList", keyword);
	}

	public ArrayList<Film> selectFilterFilmList(Film film) {
		return (ArrayList)sqlSession.selectList("filmMapper.selectFilterFilmList", film);
	}

}
