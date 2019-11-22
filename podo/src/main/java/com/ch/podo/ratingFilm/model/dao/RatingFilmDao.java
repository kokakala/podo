package com.ch.podo.ratingFilm.model.dao;

import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.podo.ratingFilm.model.vo.RatingFilm;

@Repository("ratingFilmDao")
public class RatingFilmDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;

	public int insertRateFilm(RatingFilm rate) {
		return sqlSession.insert("ratingFilmMapper.insertRateFilm", rate);
	}

	public int updateLikeFilm(RatingFilm rate) {
		return sqlSession.update("ratingFilmMapper.updateRateFilm", rate);
	}

	public int deleteRateFilm(RatingFilm rate) {
		return sqlSession.delete("ratingFilmMapper.deleteRateFilm", rate);
	}

	public RatingFilm selectRatingFilm(RatingFilm rate) {
		return sqlSession.selectOne("ratingFilmMapper.selectRatingFilm", rate);
	}

	public Map<Integer, RatingFilm> selectRatedFilm(int id) {
		return (Map)sqlSession.selectMap("ratingFilmMapper.selectRatedFilm", id, "filmId");
	}
	
}
