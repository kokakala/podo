package com.ch.podo.like.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.common.Pagination;
import com.ch.podo.like.model.service.LikeService;
import com.ch.podo.like.model.vo.Like;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class LikeController {

	@Autowired
	private LikeService likeService;
	
	@ResponseBody
	@RequestMapping("likeMember.do")
	public int likeMember(Like like, String flag) {
		log.info("like member : {}", like);
		int result = 0;
		
		if (Integer.parseInt(flag) > 0) {
			log.info("like member insert 실행");
			result = likeService.insertLikeMem(like);
		} else {
			log.info("like member insert 실행");
			result = likeService.deleteLikeMem(like);
		}
		
		return result;
	}

	// 리뷰 좋아요
	@ResponseBody
	@RequestMapping("likeReview.do")
	public void likeReview(Like like, String flag, HttpServletResponse response)
			throws JsonIOException, IOException {
		int result = 0;
		log.info("like review : {}", like);

		if (Integer.parseInt(flag) > 0) {
			log.info("like review insert 실행");
			result = likeService.insertLikeReview(like);
		} else {
			log.info("like review insert 실행");
			result = likeService.deleteLikeReview(like);
		}
		log.info("result : {}", result);
		
		Gson gson = new Gson();
		gson.toJson(result, response.getWriter());
	}

	@RequestMapping("myPageSelectLikeFilm.do")
	public ModelAndView myPageSelectLikeFilm(String tab, String id, ModelAndView mv,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage) {

		int FilmlistCount = likeService.myPageLikeFilmListCount(id);
		PageInfo filmPi = Pagination.setPageLimit(currentPage, FilmlistCount, 5, 12);
		ArrayList<Like> likeFilmList = likeService.myPageSelectLikeFilm(id, filmPi);
		
		mv.addObject("likeFilmList", likeFilmList)
			.addObject("FilmlistCount", FilmlistCount)
			.addObject("filmPi", filmPi)
			.addObject("tab", tab)
			.setViewName("member/myPage");
		return mv;
	}

	@RequestMapping("myPageSelectLikeUser.do")
	public ModelAndView myPageSelectLikeUser(String tab, String id, ModelAndView mv,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage) {

		int UserlistCount = likeService.myPageLikeUserListCount(id);
		PageInfo userPi = Pagination.getPageInfo(currentPage, UserlistCount);
		ArrayList<Like> likeUserList = likeService.myPageSelectLikeUser(id, userPi);
		
		mv.addObject("likeUserList", likeUserList)
			.addObject("UserlistCount", UserlistCount)
			.addObject("userPi", userPi)
			.addObject("tab", tab)
			.setViewName("member/myPage");
		return mv;
	}

	@RequestMapping("myPageSelectLikeReview.do")
	public ModelAndView myPageSelectLikeReview(String tab, String id, ModelAndView mv,
			@RequestParam(name = "currentPage", value = "currentPage", defaultValue = "1") int currentPage) {

		int reviewlistCount = likeService.myPageLikeReviewListCount(id);
		PageInfo reviewPi = Pagination.getPageInfo(currentPage, reviewlistCount);
		ArrayList<Like> likeReviewList = likeService.myPageSelectLikeReview(id, reviewPi);
		// log.info(likeReviewList.toString());
		
		mv.addObject("likeReviewList", likeReviewList)
			.addObject("ReviewlistCount", reviewlistCount)
			.addObject("reviewlikePi", reviewPi)
			.addObject("tab", tab)
			.setViewName("member/myPage");
		
		return mv;
	}

	@RequestMapping("userPageSelectLikeReview.do")
	public ModelAndView userPageSelectLikeReview(String tab, String id, String loginUserId, ModelAndView mv,
			@RequestParam(name = "currentPage", value = "currentPage", defaultValue = "1") int currentPage) {

		Like likeUser = likeService.selectLikeUser(id, loginUserId); // 유저페이지 조회 시 라이크 여부
		int reviewlistCount = likeService.myPageLikeReviewListCount(id);
		PageInfo reviewPi = Pagination.getPageInfo(currentPage, reviewlistCount);
		ArrayList<Like> likeReviewList = likeService.myPageSelectLikeReview(id, reviewPi);
		
		mv.addObject("likeUser", likeUser)
			.addObject("likeReviewList", likeReviewList)
			.addObject("ReviewlistCount", reviewlistCount)
			.addObject("reviewlikePi", reviewPi)
			.addObject("tab", tab)
			.setViewName("member/userPage");
		
		return mv;
	}

	@RequestMapping("userPageSelectLikeFilm.do")
	public ModelAndView userPageSelectLikeFilm(String tab, String id, String loginUserId, ModelAndView mv,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage) {

		Like likeUser = likeService.selectLikeUser(id, loginUserId); // 유저페이지 조회 시 라이크 여부
		int filmlistCount = likeService.myPageLikeFilmListCount(id);
		PageInfo filmPi = Pagination.setPageLimit(currentPage, filmlistCount, 5, 12);
		ArrayList<Like> likeFilmList = likeService.myPageSelectLikeFilm(id, filmPi);

		mv.addObject("likeUser", likeUser)
			.addObject("likeFilmList", likeFilmList)
			.addObject("FilmlistCount", filmlistCount)
			.addObject("filmPi", filmPi)
			.addObject("tab", tab)
			.setViewName("member/userPage");
		return mv;
	}

	@RequestMapping("userPageSelectLikeUser.do")
	public ModelAndView userPageSelectLikeUser(String tab, String id, String loginUserId, ModelAndView mv,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage) {

		Like likeUser = likeService.selectLikeUser(id, loginUserId);	// 유저페이지 조회 시 라이크 여부
		int UserlistCount = likeService.myPageLikeUserListCount(id);
		PageInfo userPi = Pagination.getPageInfo(currentPage, UserlistCount);
		ArrayList<Like> likeUserList = likeService.myPageSelectLikeUser(id, userPi);
		
		mv.addObject("likeUser", likeUser)
			.addObject("likeUserList", likeUserList)
			.addObject("UserlistCount", UserlistCount)
			.addObject("userPi", userPi)
			.addObject("tab", tab)
			.setViewName("member/userPage");
		return mv;
	}

}
