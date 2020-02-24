package com.ch.podo.review.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
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
import com.ch.podo.like.model.vo.Like;
import com.ch.podo.member.model.vo.Member;
import com.ch.podo.report.model.vo.Report;
import com.ch.podo.review.model.dto.Review;
import com.ch.podo.review.model.service.ReviewService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class ReviewController {

	@Autowired
	private ReviewService reviewService;

	// 전체리스트 조회
	@RequestMapping("reviewList.do")
	public ModelAndView reviewList(ModelAndView mv, PageInfo pi,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage) {

		int listReviewCount = reviewService.getReviewListCount();
		pi = Pagination.getPageInfo(currentPage, listReviewCount);
		ArrayList<Review> list = reviewService.selectReviewList(pi);
		for (Review review : list) {
			review.setContent(review.getContent().replaceAll("(\\r\\n|\\n)", "<br>"));
		}
		mv.addObject("list", list).addObject("pi", pi).setViewName("review/reviewList");

		return mv;

	}

	@RequestMapping("reviewWriteForm.do")
	public ModelAndView reviewWriteView(int filmId, ModelAndView mv) {
		Film film = reviewService.selectFilm(filmId);
		mv.addObject("f", film).setViewName("review/reviewWriteForm");
		return mv;
	}

	@RequestMapping("reviewWrite.do")
	public String reviewWrite(DetailFilm df, Review review) {

		if (review.getSpoilerCheck() != null) { // 체크값이 널이 아닐때
			if (review.getSpoilerCheck().equals("0")) {
				review.setSpoilerCheck("Y");
			} else {
				review.setSpoilerCheck("N");
			}
		} else {
			review.setSpoilerCheck("N");
		}

		int result1 = reviewService.reviewWrite(review);
		int result2 = reviewService.reviewRating(review);

		if (result1 > 0 && result2 > 0) { // 게시판 작성 성공
			return "redirect:reviewList.do";
		} else { // 작성 실패
			return "redirect:exception.do";
		}

	}

	// 글삭제 (아직 조건 안걸음 사용자 아이디 비교해서 그사람이 삭제할수있게끔해놓기)
	@RequestMapping("reviewDelete.do")
	public String reviewDelete(int id, ModelAndView mv) {
		int result = reviewService.deleteReview(id);

		if (result > 0) {
			return "redirect:reviewList.do";
		} else {
			return "redirect:exception.do";
		}

	}

	// 글 리뷰 리스트 조회용
	@RequestMapping("reviewDetail.do")
	public ModelAndView selectRatingReviewDetailView(@RequestParam(value = "id") String id, ModelAndView mv, HttpSession session, HttpServletRequest request) {
		
		Review review = reviewService.selectRatingReviewDetailView(Integer.parseInt(id));
		review.setContent(review.getContent().replaceAll("(\\r\\n|\\n)", "<br>"));

		if (session.getAttribute("loginUser") != null) {
			Member member = (Member) session.getAttribute("loginUser");
			ArrayList<Like> list = reviewService.checkLike(member);
			for (Like like : list) {
				if (like.getTargetId() == Integer.parseInt(id)) {
					request.setAttribute("likeReivew", like.getTargetId());
				}
			}
		}
		
		// log.info(review.toString());
		mv.addObject("r", review)
			.setViewName("review/reviewDetail");

		return mv;
	}

	// 글 수정 폼으로 가게해주는 리퀘스트매핑
	@RequestMapping("reviewUpdateForm.do")
	public ModelAndView boardUpdateView(String id, ModelAndView mv, HttpSession session) {
		
		// log.info("id : " + id);
		
		Member member = (Member) session.getAttribute("loginUser");
		Review review = reviewService.selectUpdateReview(Integer.parseInt(id));

		mv.addObject("r", review)
			.addObject("m", member)
			.setViewName("review/reviewUpdateForm");
		
		return mv;

	}

	// 수정 하는 리퀘스트매핑
	@RequestMapping("reviewUpdate.do")
	public ModelAndView reviewUpdate(Review review, ModelAndView mv, HttpSession session) {
		if (review.getSpoilerCheck() != null) {
			if (review.getSpoilerCheck().equals("N")) {
				review.setSpoilerCheck("Y");
			} else {
				review.setSpoilerCheck("N");
			}
		} else {
			review.setSpoilerCheck("N");
		}

		int result1 = reviewService.reviewUpdate(review);
		int result2 = reviewService.reviewUpdateContent(review);
		// Member member = (Member) session.getAttribute("loginUser");

		if (result1 > 0 && result2 > 0) {
			mv.addObject("id", review.getId())
				.setViewName("redirect:reviewDetail.do");
		} else {
			mv.setViewName("redirect:exception.do");
		}
		return mv;
	}

	// 마이페이지 리뷰조회
	@RequestMapping("myPageSelectReview.do")
	public ModelAndView myPageSelectReview(String tab, String id,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage, ModelAndView mv) {
		int listCount = reviewService.myPageReviewListCount(id);

		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		ArrayList<Review> reviewList = reviewService.myPageSelectReviewList(id, pi);
		mv.addObject("review", reviewList).addObject("reviewPi", pi).addObject("tab", tab).setViewName("member/myPage");
		return mv;
	}

	// 유저페이지 리뷰조회
	@RequestMapping("userPageSelectReview.do")
	public ModelAndView userPageSelectReview(String tab, String id,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage, ModelAndView mv) {
		int listCount = reviewService.myPageReviewListCount(id);
		log.info("listCount : {}", listCount);
		log.info("tab : {}", tab);
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);

		ArrayList<Review> reviewList = reviewService.myPageSelectReviewList(id, pi);
//		log.info("reviewList : {}", reviewList);
		
		mv.addObject("review", reviewList)
			.addObject("reviewPi", pi)
			.addObject("tab", tab)
			.setViewName("member/userPage");
		
		return mv;
	}

	// 관리자 리뷰 리스트 조회
	@RequestMapping("adRlist.do")
	public ModelAndView reviewList(ModelAndView mv,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage) {
		ArrayList<Review> list = reviewService.selectAdReviewList();
		mv.addObject("list", list).setViewName("admin/reviewListView");
		return mv;
	}

	// 전체리스트 메인 페이지
	@RequestMapping("reviewListMain.do")
	public ModelAndView reviewList(ModelAndView mv) {

		ArrayList<Review> list = reviewService.selectReviewListMain();
		mv.addObject("list", list).setViewName("review/reviewList");
		return mv;

	}

	// 리뷰 신고하기
	@RequestMapping(value = "declarationModal.do")
	public String insertDeclaration(Report report, Model model, HttpServletRequest request, HttpServletResponse response)
			throws IOException {
		
		log.info("report : {}", report);
		if (report.getContent() == 0) {
			response.getWriter().write("<script>alert('신고내용을 선택해주세요!');history.back();</script>");
			return null;
		}
		
		int result = reviewService.insertDeclaration(report);
		log.info("result : {}", result);
		if (result > 0) { // 성공
			model.addAttribute("id", report.getTargetId());
			request.getSession().setAttribute("msg", "신고가 완료되었습니다.");
			return "redirect:reviewDetail.do";
		} else { // 실패
			return "redirect:exception.do";
		}
	}

	// 리뷰 댓글
	// 댓글 신고하기
	@RequestMapping("declarationCommentModal.do")
	public ModelAndView insertDeclarationComment(Review r, Report rep, ModelAndView mv) {

		int result = reviewService.insertDeclarationComment(rep);
		log.info("result : {}", result);

		if (result > 0) { // 성공
			mv.addObject("id", rep.getTargetId()).setViewName("redirect:reviewDetail.do");
		} else { // 실패
			mv.setViewName("redirect:exception.do");
		}

		return mv;
	}
	
	@ResponseBody
	@RequestMapping(value = "reviewCommentList.do", produces = "application/json; charset=UTF-8")
	public String reviewCommentList(int id) {
		ArrayList<Comment> reviewCommentList = reviewService.selectReviewComment(id);
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		return gson.toJson(reviewCommentList);
	}

	// 댓글 등록
	@ResponseBody
	@RequestMapping("insertReviewComment.do")
	public String insertReviewComment(Comment comment, HttpServletRequest request) {
		// log.info("comment : " + comment);
		int result = reviewService.insertReviewComment(comment);
		// log.info("result : " + result);
		if (result > 0) {
			return "success";
		} else {
			return "fail";
		}
	}

	// 리뷰 삭제
	// 글삭제 (아직 조건 안걸음 사용자 아이디 비교해서 그사람이 삭제할수있게끔해놓기)
	@RequestMapping("deleteReviewComment.do")
	public String deleteReviewComment(int id, ModelAndView mv, HttpServletRequest request) {

		int result = reviewService.deleteReviewComment(id);
		if (result > 0) {
			request.getSession().setAttribute("msg", "댓글을 성공적으로 삭제했습니다.");
			return "redirect:reviewDetail.do";
		} else {
			return "redirect:exception.do";
		}

	}

}