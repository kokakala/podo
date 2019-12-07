package com.ch.podo;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.board.model.service.BoardService;
import com.ch.podo.board.model.vo.Board;
import com.ch.podo.film.model.service.FilmService;
import com.ch.podo.film.model.vo.Film;
import com.ch.podo.like.model.vo.Like;
import com.ch.podo.member.model.vo.Member;
import com.ch.podo.review.model.dto.Review;
import com.ch.podo.review.model.service.ReviewService;

@Controller
public class HomeController {
	
	@Autowired
	private FilmService f;
	
	@Autowired
	private ReviewService r;
	
	@Autowired
	private BoardService bs;
	
	@RequestMapping("home.do")
	public ModelAndView home(ModelAndView mv,HttpSession session,HttpServletRequest request)throws Exception {
		
		ArrayList<Film> list = f.selectNewFilms();
		
		 //System.out.println("창수의:"+list);

		ArrayList<Review> reviewList = r.selectReviewListMain();
		int listReviewCount = r.getReviewListCount();
		int getCommentCount = r.getCommentCount();
		if(session.getAttribute("loginUser")!=null) {
			Member m=(Member)session.getAttribute("loginUser");
			ArrayList<Like> listLike=r.checkLike(m);
			for(int i=0;i<listLike.size();i++) {
				for(int j=0;j<reviewList.size();j++) {
					if(listLike.get(i).getTargetId()==reviewList.get(i).getId()) {
						reviewList.get(i).setLike(m.getId());
					}
				}
			}
			
		}
		
		//System.out.println("처란의:"+reviewList);

		
		
		ArrayList<Board> boardList = bs.selectboardListHome();
		
		//System.out.println("윤진의"+boardList);

		mv.addObject("list", list).addObject("reviewList", reviewList).addObject("boardList", boardList).setViewName("home");

		return mv;
	}
	
}
