package com.ch.podo.like.model.dao;

import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.podo.like.model.vo.Like;

@Repository("likeDao")
public class LikeDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int insertLikeFilm(Like like) {
		return sqlSession.insert("likeMapper.insertLikeFilm", like);
	}

	public int deleteLikeFilm(Like like) {
		return sqlSession.delete("likeMapper.deleteLikeFilm", like);
	}
	
	public Map<Integer, Like> selectLikedFilmMap(int id) {
		return (Map)sqlSession.selectMap("likeMapper.selectLikedFilmMap", id, "targetId");
	}
	
	public Like selectLikeUser(String userId, String loginUserId) {
		HashMap map = new HashMap();
		map.put("userId", userId);
		map.put("loginUserId", loginUserId);
		
		return sqlSession.selectOne("likeMapper.selectLikeUser", map); 
	}
	
	public int insertLikeMem(Like like) {
		return sqlSession.insert("likeMapper.insertLikeMem", like);
	}
	
	public int deleteLikeMem(Like like) {
		return sqlSession.delete("likeMapper.deleteLikeMem", like);
	}
}
