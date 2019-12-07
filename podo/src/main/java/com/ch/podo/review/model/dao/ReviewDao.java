package com.ch.podo.review.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.comment.model.vo.Comment;
import com.ch.podo.film.model.vo.Film;
import com.ch.podo.like.model.vo.Like;
import com.ch.podo.member.model.vo.Member;
import com.ch.podo.report.model.vo.Report;
import com.ch.podo.review.model.dto.Review;


@Repository("reviewDao")
public class ReviewDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int getReviewListCount() {
		
		return sqlSession.selectOne("reviewMapper.getReviewListCount");
	}
	
	
	public ArrayList<Review> selectReviewList(PageInfo pi) {
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());
		
		ArrayList<Review> list = (ArrayList)sqlSession.selectList("reviewMapper.selectReviewList", null , rowBounds);
		
		return list;
	}

	public int deleteReview(int id) {
		
		return sqlSession.update("reviewMapper.deleteReview",id);
	}

	public int reviewWrite(Review r) {
		
		return sqlSession.insert("reviewMapper.reviewWrite",r);
	}

	public Film selectFilm(int filmId) {
		
		Film f = sqlSession.selectOne("reviewMapper.selectFilm", filmId);
		
		//System.out.println("f : " + f);
		return f;
	}

	public Member selectMember(int loginUserId) {
		
		Member m = sqlSession.selectOne("reviewMapper.selectMember", loginUserId);
		
		//System.out.println("m : " +m);
		return m;
	}
	
	// 합친거
	public Review selectRatingReviewDetailView(int id) {
		
		return sqlSession.selectOne("reviewMapper.selectRatingReviewDetailView",id);
	}


	public int reviewUpdate(Review r) {
	
		return sqlSession.update("reviewMapper.reviewUpdate",r);
	}
	
	
	public int reviewUpdateContent(Review r) {
		
		return sqlSession.update("reviewMapper.reviewUpdateContent",r);
	}
	
	public int myPageReviewListCount(String id) {
		return sqlSession.selectOne("reviewMapper.myPageReviewListCount", id);
	}

	public ArrayList<Review> myPageSelectReviewList(String id, PageInfo pi){
		int offset = (pi.getCurrentPage() -1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		ArrayList<Review> list = (ArrayList)sqlSession.selectList("reviewMapper.myPageSelectReviewList", id, rowBounds);
		
		return list;
	}


	public ArrayList<Review> selectReviewListMain() {
		
		
		ArrayList<Review> list = (ArrayList)sqlSession.selectList("reviewMapper.selectReviewListMain");
		return list;
	}


	public int reviewRating(Review r) {
		
		return sqlSession.insert("reviewMapper.reviewRating",r);
	}


	

	
	public ArrayList<Review> selectAdReviewList(){
		ArrayList<Review> list = (ArrayList)sqlSession.selectList("reviewMapper.selectReviewList");
		return list;
	}
	/*
	public int reivewInsert(DetailFilm df) {
		HashMap map= new HashMap();
		
		map.put("df", df);
		
		return sqlSession.insert("reviewMapper.reivewInsert",map);
	}*/


	public int insertDeclaration(Report rep) {
		
		return sqlSession.insert("reviewMapper.insertDeclaration",rep);
	}


	public Review selectReviewReport(int reviewNo) {
		
		return sqlSession.selectOne("reviewMapper.selectReviewReport", reviewNo);
	}


	public ArrayList<Comment> selectReviewComment(int id) {
		
		return (ArrayList)sqlSession.selectList("reviewMapper.selectReviewComment",id);
		
	}


	public int insertReviewComment(Comment c) {
		
		return sqlSession.insert("reviewMapper.insertReviewComment",c);
	}


	public int insertDeclarationComment(Report rep) {
		
		return sqlSession.insert("reviewMapper.insertDeclarationComment", rep);
	}


	public int deleteReviewComment(int id) {
		
		return sqlSession.update("reviewMapper.deleteReviewComment",id);
	}


	public ArrayList<Like> checkLike(Member m) {
		return (ArrayList)sqlSession.selectList("reviewMapper.checkLike",m);
	}



	/*
	public Review selectReview() {
		
		Review r = sqlSession.selectOne("reviewMapper.selectReview");
		
		System.out.println("r : " + r);
		return r;
	}*/


	public int updateReviewCount(Report rep) {
		return sqlSession.update("reviewMapper.updateReviewCount", rep);
	}


	public int getCommentCount() {
		
		return sqlSession.selectOne("reviewMapper.getCommentCount");
	}
	
	
}
