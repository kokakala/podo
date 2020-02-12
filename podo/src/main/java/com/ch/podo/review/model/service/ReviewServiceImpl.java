package com.ch.podo.review.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.comment.model.vo.Comment;
import com.ch.podo.film.model.vo.Film;
import com.ch.podo.like.model.vo.Like;
import com.ch.podo.member.model.vo.Member;
import com.ch.podo.report.model.vo.Report;
import com.ch.podo.review.model.dao.ReviewDao;
import com.ch.podo.review.model.dto.Review;



@Service("reviewService")
public class ReviewServiceImpl implements ReviewService{
	
	@Autowired
	private ReviewDao reviewDao;
	
	@Override
	public int getReviewListCount() {
		return reviewDao.getReviewListCount();
	}
	
	@Override
	public ArrayList<Review> selectReviewList(PageInfo pi) {
		return reviewDao.selectReviewList(pi);
	}

	@Override
	public int deleteReview(int id) {
		return reviewDao.deleteReview(id);
	}
	
	@Override
	public int reviewWrite(Review review) {
		return reviewDao.reviewWrite(review);
	}

	@Override
	public Film selectFilm(int filmId) {
		return reviewDao.selectFilm(filmId);
	}

	@Override
	public Member selectMember(int loginUserId) {
		return reviewDao.selectMember(loginUserId);
	}
	
	@Override
	public Review selectRatingReviewDetailView(int id) {
		return reviewDao.selectRatingReviewDetailView(id);
	}

	@Override
	public Review selectUpdateReview(int id) {
		return reviewDao.selectRatingReviewDetailView(id);
	}

	@Override
	public int reviewUpdate(Review review) {
		return reviewDao.reviewUpdate(review);
	}
	
	@Override
	public int reviewUpdateContent(Review review) {
		return reviewDao.reviewUpdateContent(review);
	}

	@Override
	public int myPageReviewListCount(String id) {
		return reviewDao.myPageReviewListCount(id);
	}

	@Override
	public ArrayList<Review> myPageSelectReviewList(String id, PageInfo pi) {
		return reviewDao.myPageSelectReviewList(id, pi);
	}

	@Override
	public ArrayList<Review> selectReviewListMain() {
		return reviewDao.selectReviewListMain();
	}

	@Override
	public int reviewRating(Review review) {
		return reviewDao.reviewRating(review);
	}

	@Override
	public ArrayList<Review> selectAdReviewList() {
		return reviewDao.selectAdReviewList();
	}

	@Override
	public int insertDeclaration(Report report) {
		
		int result = 0;
		result = reviewDao.insertDeclaration(report);
		result = reviewDao.updateReviewCount(report);
		
		return result;
	}

	@Override
	public Review selectReviewReport(int reviewNo) {
		return reviewDao.selectReviewReport(reviewNo);
	}

	@Override
	public ArrayList<Comment> selectReviewComment(int id) {
		return reviewDao.selectReviewComment(id);
	}

	@Override
	public int insertReviewComment(Comment comment) {
		return reviewDao.insertReviewComment(comment);
	}

	@Override
	public int insertDeclarationComment(Report rep) {
		return reviewDao.insertDeclarationComment(rep);
	}

	@Override
	public int deleteReviewComment(int id) {
		return reviewDao.deleteReviewComment(id);
	}

	@Override
	public ArrayList<Like> checkLike(Member member) {
		return reviewDao.checkLike(member);
	}

	@Override
	public int getCommentCount() {
		return reviewDao.getCommentCount();
	}

}
