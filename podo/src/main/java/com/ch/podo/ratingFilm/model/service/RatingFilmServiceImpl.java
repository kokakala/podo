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
	public int updateRateFilm(RatingFilm rate) {
		return ratingFilmDao.updateRateFilm(rate);
	}

	@Override
	public int updateSameRateFilm(RatingFilm rate) {
		return ratingFilmDao.updateSameRateFilm(rate);
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

	@Override
	public int insertSawFilm(RatingFilm rate) {
		return ratingFilmDao.insertSawFilm(rate);
	}

	@Override
	public int deleteSawFilm(RatingFilm rate) {
		return ratingFilmDao.deleteSawFilm(rate);
	}
	
}
