package com.ch.podo.ratingReview.controller;

import org.omg.CORBA.Request;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.ratingReview.model.service.RatingReviewService;
import com.ch.podo.ratingReview.model.vo.RatingReview;
import com.ch.podo.review.model.vo.Review;


@Controller
public class RatingReviewController {
	
	@Autowired
	private RatingReviewService ratingReviewService;
	
	//글 리뷰 리스트 조회용
	@RequestMapping("ratingDetailReview.do")
	public ModelAndView selectRatingReviewDetailView(int id,ModelAndView mv) {
		
		RatingReview rr = ratingReviewService.selectRatingReviewDetailView(id);
		
		mv.addObject("rr",rr).setViewName("ratingReview/ratingDetailReview");
		
		

		
		return mv;
	}
	
	// 글 수정 폼으로 가게해주는 리퀘스트매핑
	@RequestMapping("reviewUpdateView.do")
	public ModelAndView boardUpdateView(int id, ModelAndView mv) {
		
		RatingReview rr = ratingReviewService.selectUpdateReview(id);
		

		
		
		mv.addObject("rr",rr).setViewName("ratingReview/ratingUpdateForm");
		return mv;
		
	}
	
	// 수정 하는 리퀘스트매핑
	@RequestMapping("reviewUpdate.do")
	public ModelAndView reviewUpdate(RatingReview rr, ModelAndView mv) {
		//레이팅 6개
		int result = ratingReviewService.reviewUpdate(rr);
		//id, 레이팅6개 점수 뿌리기
		
		//리뷰 내용 수정
		
		
		if(result>0) {
			mv.addObject("id", rr.getId()).setViewName("redirect:ratingDetailReview.do");
		}else {
			mv.addObject("msg", "게시판 수정 실패").setViewName("error/errorPage");
		}
		return mv;
	}
	

}
