package com.ch.podo.detailFilm.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.podo.detailFilm.model.dao.DetailFilmDao;
import com.ch.podo.detailFilm.model.vo.Actor;
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

	// 롤백 버튼
	@Override
	public int detailFilmRollback(int filmId) {
		return dfDao.detailFilmRollback(filmId);
	}

	// 영화 상세정보 배우 리스트
	@Override
	public ArrayList<Actor> selectActorList(int id) {
		
		return dfDao.selectActorList(id);
	}

	// 배우 검색 리스트 출력
	@Override
	public ArrayList<Actor> searchActorList(String searchName) {
		
		return dfDao.searchActorList(searchName);
	}

	@Override
	public int insertInitDetailFilm(int id, int filmId) {
		return dfDao.insertInitDetailFilm(id, filmId);

	// 배우 등록
	@Override
	public int addActor(int actorId, int id) {
		
		return dfDao.addActor(actorId, id);
	}

}
