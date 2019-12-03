package com.ch.podo.review.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.comment.model.vo.Comment;
import com.ch.podo.common.Pagination;
import com.ch.podo.detailFilm.model.vo.DetailFilm;
import com.ch.podo.film.model.vo.Film;
import com.ch.podo.like.model.service.LikeService;
import com.ch.podo.member.model.vo.Member;
import com.ch.podo.report.model.vo.Report;
import com.ch.podo.review.model.dto.Review;
import com.ch.podo.review.model.service.ReviewService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;



@Controller
public class ReviewController {
	
	
	@Autowired
	private ReviewService reviewService;
	@Autowired
	private LikeService likeService;

	// 전체리스트 조회 
	@RequestMapping("reviewList.do")
	public ModelAndView reviewList(ModelAndView mv, PageInfo pi,
							       @RequestParam(value="currentPage",defaultValue = "1") int currentPage) {
		
		int listReviewCount = reviewService.getReviewListCount();
		pi = Pagination.getPageInfo(currentPage, listReviewCount);
		ArrayList<Review> list = reviewService.selectReviewList(pi);
		//System.out.println(pi);
		mv.addObject("list",list).addObject("pi", pi).setViewName("reviewView/reviewList");
		
		System.out.println("리뷰리스트 왜 스포일러체크 널인지 : "  + list);
		
		return mv;
		
	}
	
	//글 쓰기 폼 가기
	@RequestMapping("reviewWriteForm.do")
	public ModelAndView reviewWriteView(String spoilerCheck,int loginUserId,int filmId, ModelAndView mv,HttpSession session) {
		
		Film f = reviewService.selectFilm(filmId);
		System.out.println(f);
		
		//쓴날짜 오기위해 가져오는건데 의미없는듯 r = reviewService.selectReview();
		
//		Member m = reviewService.selectMember(loginUserId);
		Member m=(Member)session.getAttribute("loginUser");
		//System.out.println("m의값"+m);
		
		
		
		mv.addObject("f",f).addObject("m", m).setViewName("reviewView/reviewWriteForm");
		
		return mv;
	}
	
	// 글 쓰기(별점은 어떻게 가져올지 아직 ..)
	@RequestMapping("reviewWrite.do")
	public String reviewWrite(DetailFilm df, ModelAndView mv,Review r,Model model) {

		System.out.println("스포 변경 전 : "+ r.getSpoilerCheck());
		if (r.getSpoilerCheck().equals("0")) {
			r.setSpoilerCheck("Y");
		} else {
			r.setSpoilerCheck("N");
		}
		System.out.println("스포 변경 후 : "+ r.getSpoilerCheck());
		
		//int result = reviewService.reivewInsert(df);
		System.out.println(r);
		int result = reviewService.reviewWrite(r);
		int result2 = reviewService.reviewRating(r);
	
		//mv.addObject("filmId", df.getFilmId()).setViewName("redirect:reviewList.do");
		//return mv;
		
		if( result2>0 && result > 0) { //게시판 작성 성공
			//System.out.println("글스기인데 값이 안잡힘 : "+r);
			
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
		
		System.out.println("글 리뷰 리스트 조회용여기가 나와야 지금의 시작: " + r);
		mv.addObject("r",r).setViewName("ratingReview/ratingDetailReview");
		
		

		
		return mv;
	}
	
	// 글 수정 폼으로 가게해주는 리퀘스트매핑
	@RequestMapping("reviewUpdateView.do")
	public ModelAndView boardUpdateView(int id, ModelAndView mv, HttpSession session) {
		
		Member m=(Member)session.getAttribute("loginUser");
		Review r = reviewService.selectUpdateReview(id);
		System.out.println(r);
		//System.out.println("r값이뭐냐면요?"+r);
		
		mv.addObject("r",r).addObject("m", m).setViewName("ratingReview/ratingUpdateForm");
		return mv;
		
	}
	
	// 수정 하는 리퀘스트매핑
	@RequestMapping("reviewUpdate.do")
	public ModelAndView reviewUpdate(Review r, ModelAndView mv, HttpSession session ) {
		//레이팅 6개
		
		int result = reviewService.reviewUpdate(r);
		//id, 레이팅6개 점수 뿌리기
		int result2 = reviewService.reviewUpdateContent(r);
		//리뷰 내용 수정
		Member m=(Member)session.getAttribute("loginUser");
		
		if(result2 > 0 && result > 0) {
			mv.addObject("id",r.getId()).setViewName("redirect:ratingDetailReview.do");
		}else {
			System.out.println(result);
			System.out.println(result2);
			mv.addObject("msg", "게시판 수정 실패").setViewName("error/errorPage");
		}
		return mv;
	}
	
	
	// 마이페이지 리뷰조회
	@RequestMapping("myPageSelectReview.do")
	public ModelAndView myPageSelectReview(String tab, String id, @RequestParam(value="currentPage", defaultValue="1") int currentPage, ModelAndView mv) {
		int listCount = reviewService.myPageReviewListCount(id);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		ArrayList<Review> reviewList = reviewService.myPageSelectReviewList(id,pi);
		mv.addObject("review", reviewList).addObject("reviewPi", pi).addObject("tab", tab).setViewName("member/myPage");
		return mv;
	}
	
	// 유저페이지 리뷰조회
	@RequestMapping("userPageSelectReview.do")
	public ModelAndView userPageSelectReview(String tab, String id, @RequestParam(value="currentPage", defaultValue="1") int currentPage, ModelAndView mv) {
		int listCount = reviewService.myPageReviewListCount(id);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Review> reviewList = reviewService.myPageSelectReviewList(id,pi);
		mv.addObject("review", reviewList).addObject("reviewPi", pi).addObject("tab", tab).setViewName("member/userPage");
		return mv;
	}

	
	
	// 관리자 리뷰 리스트 조회
	@RequestMapping("adRlist.do")
	public ModelAndView reviewList(ModelAndView mv, 
								  @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		
		ArrayList<Review> list = reviewService.selectAdReviewList();
		
		mv.addObject("list", list)
		  .setViewName("admin/reviewListView");
		
		return mv;
	}
	
	//전체리스트 메인 페이지
	@RequestMapping("reviewListMain.do")
	public ModelAndView reviewList(ModelAndView mv) {
		

		ArrayList<Review> list = reviewService.selectReviewListMain();
		System.out.println(list);
		mv.addObject("list",list).setViewName("reviewView/reviewList");
		
		//System.out.println("리뷰리스트 : "  + list);
		
		return mv;
		
	}
	
	//  리뷰 신고하기
	@RequestMapping("declarationModal.do")
	public ModelAndView insertDeclaration(Review r,Report rep,ModelAndView mv) {
		
		
		//Review r = reviewService.selectReviewReport(reviewNo);
		System.out.println("구하고자하는값은"+rep);
		
		int result = reviewService.insertDeclaration(rep);
		System.out.println("성공할건가"+result);
		if(result>0) { // 성공
			mv.addObject("id",rep.getTargetId()).setViewName("redirect:ratingDetailReview.do");
			
		}else { // 실패
			mv.addObject("msg", "신고하기 실풰").setViewName("error/errorPage");
		}
		
		return mv;
	}
	
	

	// 댓글 신고하기
	@RequestMapping("declarationCommentModal.do")
	public ModelAndView insertDeclarationComment(Review r, Report rep, ModelAndView mv) {

		// Review r = reviewService.selectReviewReport(reviewNo);
		System.out.println("댓글신고" + rep);

		int result = reviewService.insertDeclarationComment(rep);
		System.out.println("성공할건가" + result);
		if (result > 0) { // 성공
			mv.addObject("id", rep.getTargetId()).setViewName("redirect:ratingDetailReview.do");

		} else { // 실패
			mv.addObject("msg", "신고하기 실풰").setViewName("error/errorPage");
		}

		return mv;
	}
	
	
	// 리부 댓글
	
	@ResponseBody
	@RequestMapping(value="reviewCommentList.do", produces="application/json; charset=UTF-8")
	public String reviewCommentList(int id ){
		
		ArrayList<Comment> reviewCommentList = reviewService.selectReviewComment(id);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		
		System.out.println("댓글"+reviewCommentList);
		return gson.toJson(reviewCommentList);
		 
	}
	
	//댓글 등록
	
	@ResponseBody
	@RequestMapping("insertReviewComment.do")
	public String insertReviewComment(Comment c, ModelAndView mv) {
		
		int result = reviewService.insertReviewComment(c);
		
		
		System.out.println(result);
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
	
	// 리뷰 좋아요
	
	
	//리뷰 삭제
	// 글삭제 (아직 조건 안걸음 사용자 아이디 비교해서 그사람이 삭제할수있게끔해놓기)
	@RequestMapping("deleteReviewComment.do")
	public String deleteReviewComment(int id, ModelAndView mv) {
		
		
		int result = reviewService.deleteReviewComment(id);
		
		if(result>0) {
			return "redirect:ratingDetailReview.do";
		}else {
			return "error/errorPage";
		}
		
	}

}