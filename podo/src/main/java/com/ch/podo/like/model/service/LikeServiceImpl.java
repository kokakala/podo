package com.ch.podo.like.model.service;

import java.util.ArrayList;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.film.model.vo.Film;
import com.ch.podo.like.model.dao.LikeDao;
import com.ch.podo.like.model.vo.Like;
import com.ch.podo.member.model.vo.Member;
import com.ch.podo.review.model.dto.Review;

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

	@Override
	public int myPageLikeFilmListCount(String id) {
		return likeDao.myPageLikeFilmListCount(id);
	}

	
	@Override public ArrayList<Like> myPageSelectLikeFilm(String id, PageInfo pi){
		return likeDao.myPageSelectLikeFilm(id, pi); 
	}

	@Override
	public int myPageLikeUserListCount(String id) {
		return likeDao.myPageLikeUserListCount(id);
	}

	@Override
	public ArrayList<Like> myPageSelectLikeUser(String id, PageInfo pi) {
		return likeDao.myPageSelectLikeUser(id, pi);
	}

	@Override
	public int myPageLikeReviewListCount(String id) {
		return likeDao.myPageLikeReviewListCount(id);
	}

	@Override
	public ArrayList<Like> myPageSelectLikeReview(String id, PageInfo pi) {
		return likeDao.myPageSelectLikeReview(id, pi);
	}

	@Override
	public int insertLikeReview(Like like) {
		
		//int result=0;
		//result = 
		//result =likeDao.updateLikeCount(like);
		
		//return likeDao.insertLikeReview(like);
		return likeDao.insertLikeReview(like);
	}

	@Override
	public int deleteLikeReview(Like like) {
		
		return likeDao.deleteLikeReview(like);
	}

	  

	 
}
