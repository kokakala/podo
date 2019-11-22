package com.ch.podo.ratingFilm.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.podo.ratingFilm.model.dao.RatingFilmDao;
import com.ch.podo.ratingFilm.model.vo.RatingFilm;

@Service("ratingFilmService")
public class RatingFilmServiceImpl implements RatingFilmService {
	
	@Autowired
	private RatingFilmDao ratingFilmDao;

	@Override
	public int insertRateFilm(RatingFilm rate) {
		return ratingFilmDao.insertRateFilm(rate);
	}

	@Override
	public int updateLikeFilm(RatingFilm rate) {
		return ratingFilmDao.updateLikeFilm(rate);
	}

	@Override
	public int deleteRateFilm(RatingFilm rate) {
		return ratingFilmDao.deleteRateFilm(rate);
	}

	@Override
	public RatingFilm selectRatingFilm(RatingFilm rate) {
		return ratingFilmDao.selectRatingFilm(rate);
	}

	@Override
	public Map<Integer, RatingFilm> selectRatedFilm(int id) {
		return ratingFilmDao.selectRatedFilm(id);
	}
	
}
