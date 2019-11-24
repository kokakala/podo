package com.ch.podo.detailFilm.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.podo.detailFilm.model.dao.DetailFilmDao;
import com.ch.podo.detailFilm.model.vo.DetailFilm;
import com.ch.podo.image.model.vo.Image;
import com.ch.podo.review.model.dto.Review;

@Service("dfService")
public class DetailFilmServiceImpl implements DetailFilmService{
	
	@Autowired
	private DetailFilmDao dfDao;
	
	// 영화 상세 정보
	@Override
	public DetailFilm selectDetailFilm(int filmId) {
		return dfDao.selectDetailFilm(filmId);
	}

	// 영화 리뷰리스트
	@Override
	public ArrayList<Review> selectReivewList(int filmId) {
		return dfDao.selectReivewList(filmId);
	}

	// 영화 상세정보 추가 입력
	@Override
	public int detailFilmInsert(DetailFilm df, int uId) {

		return dfDao.detailFilmInsert(df, uId);
	}
	
	// 영화 상세정보 추가 입력, 포스터
	@Override
	public int filmImageInsert(String filmImage, int id) {
		
		return dfDao.filmImageInsert(filmImage, id);
	}
	
	// 영화 상세정보 영화 포스터 불러오기
	@Override
	public Image selectFilmImage(int id) {
		return dfDao.selectFilmImage(id);
	}

	@Override
	public int detailFilmRollback(int filmId) {
		return dfDao.detailFilmRollback(filmId);
	}

}
