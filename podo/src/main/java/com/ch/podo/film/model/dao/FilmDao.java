package com.ch.podo.film.model.dao;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.common.SearchCondition;
import com.ch.podo.film.model.vo.Film;
import com.ch.podo.film.model.vo.Genre;
import com.ch.podo.image.model.vo.Image;

@Repository("filmDao")
public class FilmDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int getListCount() {
		return sqlSession.selectOne("filmMapper.getListCount");
	}

	public int selectKeywordFilmListCount(String keyword, String skeyword) {
		HashMap<String, String> map = new HashMap<>();
		map.put("keyword", keyword);
		map.put("skeyword", skeyword);
		return sqlSession.selectOne("filmMapper.selectKeywordFilmListCount", map);
	}
	
	public ArrayList<Film> selectKeywordFilmList(String keyword, String skeyword, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		HashMap<String, String> map = new HashMap<>();
		map.put("keyword", keyword);
		map.put("skeyword", skeyword);
		
		return (ArrayList)sqlSession.selectList("filmMapper.selectKeywordFilmList", map, rowBounds);
	}

	public ArrayList<Film> selectFilterFilmList(SearchCondition sc, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("filmMapper.selectFilterFilmList", sc, rowBounds);
	}

	public ArrayList<Film> selectFilterFilmMap(Map<String, Object> map) {
		return (ArrayList)sqlSession.selectList("filmMapper.selectFilterFilmMap", map);
	}

	public ArrayList<Genre> selectAllGenreList() {
		return (ArrayList)sqlSession.selectList("filmMapper.selectAllGenreList");
	}
	
	public int getFilmListCount() {
		return sqlSession.selectOne("filmMapper.getFilmListCount");
	}
	
	public ArrayList<Film> selectFilmList(){
		return (ArrayList)sqlSession.selectList("filmMapper.selectFilmList");
	}
	
	public int insertFilm(Film f) {
		return sqlSession.insert("filmMapper.insertFilm", f);
	}

	public Film selectFilm(int id) {
		return sqlSession.selectOne("filmMapper.selectFilm", id);
	}

	public int selectLikedFilmCount(int id) {
		return sqlSession.selectOne("filmMapper.selectLikedFilmCount", id);
	}

	public ArrayList<Film> selectLikedFilmList(int id, PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		return (ArrayList)sqlSession.selectList("filmMapper.selectLikedFilmList", id, rowBounds);
	}

	public ArrayList<Film> selectPreferredGenreFilmList(int id) {
		return (ArrayList)sqlSession.selectList("filmMapper.selectPreferredGenreFilmList", id);
	}

	public ArrayList<String> selectAllCountryList() {
		return (ArrayList)sqlSession.selectList("filmMapper.selectAllCountryList");
	}

	public ArrayList<String> selectAllReleaseYearList() {
		return (ArrayList)sqlSession.selectList("filmMapper.selectAllReleaseYearList");
	}

	public int selectFilterFilmListCount(SearchCondition sc) {
		return sqlSession.selectOne("filmMapper.selectFilterFilmListCount", sc);
	}

	public ArrayList<Film> selectNewFilms() {
		return (ArrayList)sqlSession.selectList("filmMapper.selectNewFilms");
	}

	public int insertInitDetailFilm(int memberId) {
		return sqlSession.insert("filmMapper.insertInitDetailFilm", memberId);
	}

	public int insertFilmImage(Image img) {
		return sqlSession.insert("filmMapper.insertFilmImage", img);
	}
	
	public ArrayList<Film> manyStar(){
		return (ArrayList)sqlSession.selectList("filmMapper.manyStar");
	}

}
