package com.ch.podo.detailFilm.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.podo.common.Image;
import com.ch.podo.detailFilm.model.vo.Actor;
import com.ch.podo.detailFilm.model.vo.DetailFilm;
import com.ch.podo.review.model.dto.Review;

@SuppressWarnings(value = "unchecked")
@Repository("dfDao")
public class DetailFilmDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public DetailFilm selectDetailFilm(int filmId) {
		return sqlSession.selectOne("detailFilmMapper.selectDetailFilm", filmId);
	}

	public ArrayList<Review> selectReivewList(int filmId) {
		return (ArrayList) sqlSession.selectList("detailFilmMapper.selectReivewList", filmId);
	}

	// HashMap 수정 필요
	public int detailFilmInsert(DetailFilm df, int userId) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("df", df);
		map.put("userId", userId);
		return sqlSession.insert("detailFilmMapper.insertDetailFilm", map);
	}

	// 포스터 이미지 불러오기
	public Image selectFilmImage(int id) {
		return sqlSession.selectOne("detailFilmMapper.selectFilmImage", id);
	}

	// 포스터 이미지 수정
	public int filmImageInsert(String filmImage, int id, int filmId) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("filmImage", filmImage);
		map.put("id", id);
		map.put("filmId", filmId);
		return sqlSession.insert("detailFilmMapper.filmImageInsert", map);
	}

	public ArrayList<Actor> selectActorList(int id) {
		return (ArrayList) sqlSession.selectList("detailFilmMapper.selectFilmActor", id);
	}

	// 상세정보 롤백
	public int detailFilmRollback(int filmId) {
		return sqlSession.update("detailFilmMapper.updateDetailFilm", filmId);
	}

	// 배우 검색
	public ArrayList<Actor> searchActorList(String searchName) {
		return (ArrayList) sqlSession.selectList("detailFilmMapper.searchActorList", searchName);
	}

	// 배우 등록
	public int addActor(int newActorId, int id) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("newActorId", newActorId);
		map.put("id", id);
		return sqlSession.insert("detailFilmMapper.addActor", map);
	}

	// 배우 삭제
	public int deleteActor(int actorId, int id) {
		HashMap<String, Object> map = new HashMap<>();
		map.put("actorId", actorId);
		map.put("id", id);
		return sqlSession.insert("detailFilmMapper.deleteActor", map);
	}

	// 배우 수정 등록
	public int actorInsert(String actorIdList) {

		String[] actorList = actorIdList.split(",");
		int[] actorIntList = new int[actorList.length];
		int result = 0;

		// 인트형으로 변환
		for (int i = 0; i < actorList.length; i++) {
			actorIntList[i] = Integer.parseInt(actorList[i]);
		}

		for (int i = 0; i < actorIntList.length; i++) {
			result = sqlSession.insert("detailFilmMapper.wikiAddActor", actorIntList[i]);
		}

		return result;
	}

	public DetailFilm existsDetailFilm(int filmId) {
		return sqlSession.selectOne("detailFilmMapper.existsDetailFilm", filmId);
	}
}
