package com.ch.podo;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.board.model.service.BoardService;
import com.ch.podo.board.model.vo.Board;
import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.common.Pagination;
import com.ch.podo.film.model.service.FilmService;
import com.ch.podo.film.model.vo.Film;
import com.ch.podo.review.model.dto.Review;
import com.ch.podo.review.model.service.ReviewService;

@Controller
public class HomeController {
	
	@Autowired
	private FilmService f;
	
	@Autowired
	private ReviewService rs;
	
	@Autowired
	private BoardService bs;
	
	@RequestMapping("home.do")
	public ModelAndView home(ModelAndView mv)throws Exception {
		
		ArrayList<Film> list = f.selectNewFilms();
		
		 //System.out.println("창수의:"+list);

		int listReviewCount = rs.getReviewListCount();
		ArrayList<Review> reviewList = rs.selectReviewListMain();
		//System.out.println("처란의:"+reviewList);

		
		
		ArrayList<Board> boardList = bs.selectboardListHome();
		
		//System.out.println("윤진의"+boardList);

		mv.addObject("list", list).addObject("reviewList", reviewList).addObject("boardList", boardList).setViewName("home");

		return mv;
	}
	
}
