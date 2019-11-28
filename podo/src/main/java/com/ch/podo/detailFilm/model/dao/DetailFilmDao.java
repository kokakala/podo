package com.ch.podo.detailFilm.model.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.podo.detailFilm.model.vo.Actor;
import com.ch.podo.detailFilm.model.vo.DetailFilm;
import com.ch.podo.image.model.vo.Image;
import com.ch.podo.review.model.dto.Review;

@Repository("dfDao")
public class DetailFilmDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public DetailFilm selectDetailFilm(int filmId) {
		
		DetailFilm df = sqlSession.selectOne("detailFilmmapper.selectDetailFilm", filmId);
		
		return df;
	}
	
	public ArrayList<Review> selectReivewList(int filmId){
		
		ArrayList<Review> list = (ArrayList)sqlSession.selectList("detailFilmmapper.selectReivewList", filmId);
		return list;
	}
	
	// HashMap 수정 필요
	public int detailFilmInsert(DetailFilm df, int uId) {
		HashMap map= new HashMap();
		
		map.put("df", df);
		map.put("uId", uId);
		return sqlSession.insert("detailFilmmapper.insertDetailFilm", map);
	}
	
	// 포스터 이미지 불러오기
	public Image selectFilmImage(int id) {
		
		Image i = sqlSession.selectOne("detailFilmmapper.selectFilmImage", id);
		
		return i;
	}

	// 포스터 이미지 수정
	public int filmImageInsert(String filmImage, int id) {
		
		HashMap map= new HashMap();
		
		map.put("filmImage", filmImage);
		map.put("id", id);
		
		return sqlSession.insert("detailFilmmapper.filmImageInsert", map);
	}
	
	public ArrayList<Actor> selectActorList(int id){
		
		ArrayList<Actor> list = (ArrayList)sqlSession.selectList("detailFilmmapper.selectFilmActor", id);
		return list;
	}
	
	// 상세정보 롤백
	public int detailFilmRollback(int filmId) {
		return sqlSession.update("detailFilmmapper.updateDetailFilm", filmId);	
	}
	
	// 배우 검색
	public ArrayList<Actor> searchActorList(String searchName){
		
		return (ArrayList)sqlSession.selectList("detailFilmmapper.searchActorList", searchName);
	}

	public int insertInitDetailFilm(int id, int filmId) {
		int[] ids = {id, filmId};
		return sqlSession.insert("detailFilmmapper.insertInitDetailFilm", ids);
	}
	
	public int addActor(int actorId, int id) {
		
		HashMap map = new HashMap();
		
		map.put("actorId", actorId);
		map.put("id", id);
		
		return sqlSession.insert("detailFilmmapper.addActor",map);
	}
	
	
}
















