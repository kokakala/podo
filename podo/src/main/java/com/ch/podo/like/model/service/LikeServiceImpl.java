package com.ch.podo.like.model.service;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.podo.like.model.dao.LikeDao;
import com.ch.podo.like.model.vo.Like;

@Service("likeService")
public class LikeServiceImpl implements LikeService{
	
	@Autowired
	private LikeDao likeDao;
	
	@Override
	public int insertLikeFilm(Like like) {
		return likeDao.insertLikeFilm(like);
	}

	@Override
	public int deleteLikeFilm(Like like) {
		return likeDao.deleteLikeFilm(like);
	}

	@Override
	public Map<Integer, Like> selectLikedFilmMap(int id) {
		return likeDao.selectLikedFilmMap(id);
	}

	@Override
	public Like selectLikeUser(String userId, String loginUserId) {
		return likeDao.selectLikeUser(userId, loginUserId);
	}

	@Override
	public int insertLikeMem(Like like) {
		return likeDao.insertLikeMem(like);
	}

	@Override
	public int deleteLikeMem(Like like) {
		return likeDao.deleteLikeMem(like);
	}
	
}
