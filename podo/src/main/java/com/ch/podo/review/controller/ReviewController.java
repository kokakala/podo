package com.ch.podo.review.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.film.model.vo.Film;
import com.ch.podo.member.model.vo.Member;
import com.ch.podo.review.model.dto.Review;
import com.ch.podo.review.model.service.ReviewService;



@Controller
public class ReviewController {
	
	
	@Autowired
	private ReviewService reviewService;

	// 전체리스트 조회 
	@RequestMapping("reviewList.do")
	public ModelAndView reviewList(ModelAndView mv) {
		
		ArrayList<Review> list = reviewService.selectReviewList();
		
		mv.addObject("list",list).setViewName("reviewView/reviewList");
		
		System.out.println("리뷰리스트 : "  + list);
		
		return mv;
		
	}
	
	//글 쓰기 폼 가기
	@RequestMapping("reviewWriteForm.do")
	public ModelAndView reviewWriteView(int loginUserId,int filmId, ModelAndView mv) {
		
		Film f = reviewService.selectFilm(filmId);
		
		Member m = reviewService.selectMember(loginUserId);
		
		
		
		mv.addObject("f",f).addObject("m", m).setViewName("reviewView/reviewWriteForm");
		
		return mv;
	}
	
	// 글 쓰기(별점은 어떻게 가져올지 아직 ..)
	@RequestMapping("reviewWrite.do")
	public String reviewWrite(ModelAndView mv,Review r,Model model) {
		
		int result = reviewService.reviewWrite(r);
		System.out.println(r);
		if(result > 0) { //게시판 작성 성공
			
			return "redirect:reviewList.do";
			
		}else { // 작성 실패
			model.addAttribute("msg","게시판 작성 하기실팽");
			return "error/errorPage";
		}
		
		
		
		
	}

		
	
	
	
	// 글삭제 (아직 조건 안걸음 사용자 아이디 비교해서 그사람이 삭제할수있게끔해놓기)
	@RequestMapping("reviewDelete.do")
	public String reviewDelete(int id, ModelAndView mv) {
		
		
		int result = reviewService.deleteReview(id);
		
		if(result>0) {
			return "redirect:reviewList.do";
		}else {
			return "error/errorPage";
		}
		
	}
	
	
	
	
	// 여기서부터 합친기 본
	
	//글 리뷰 리스트 조회용
	@RequestMapping("ratingDetailReview.do")
	public ModelAndView selectRatingReviewDetailView(int id,ModelAndView mv) {
		
		Review r = reviewService.selectRatingReviewDetailView(id);
		
		System.out.println(r);
		mv.addObject("r",r).setViewName("ratingReview/ratingDetailReview");
		
		

		
		return mv;
	}
	
	// 글 수정 폼으로 가게해주는 리퀘스트매핑
	@RequestMapping("reviewUpdateView.do")
	public ModelAndView boardUpdateView(int id, ModelAndView mv) {
		
		Review r = reviewService.selectUpdateReview(id);
		

		
		
		mv.addObject("r",r).setViewName("ratingReview/ratingUpdateForm");
		return mv;
		
	}
	
	// 수정 하는 리퀘스트매핑
	@RequestMapping("reviewUpdate.do")
	public ModelAndView reviewUpdate(Review r, ModelAndView mv) {
		//레이팅 6개
		int result = reviewService.reviewUpdate(r);
		//id, 레이팅6개 점수 뿌리기
		
		//리뷰 내용 수정
		
		
		if(result>0) {
			mv.addObject("id", r.getRatingReviewId()).setViewName("redirect:ratingDetailReview.do");
		}else {
			mv.addObject("msg", "게시판 수정 실패").setViewName("error/errorPage");
		}
		return mv;
	}
	
	
	

}
