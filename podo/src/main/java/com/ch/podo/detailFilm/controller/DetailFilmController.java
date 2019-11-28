package com.ch.podo.detailFilm.controller;

import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.detailFilm.model.service.DetailFilmService;
import com.ch.podo.detailFilm.model.vo.Actor;
import com.ch.podo.detailFilm.model.vo.DetailFilm;
import com.ch.podo.image.model.vo.Image;
import com.ch.podo.review.model.dto.Review;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;

@Controller
public class DetailFilmController {
	
	@Autowired
	private DetailFilmService dfService;
	
	@RequestMapping("detailFilm.do")
	public ModelAndView selectDetailFilm(int filmId, ModelAndView mv) {
		
		// 영화 상세정보 
		DetailFilm df = dfService.selectDetailFilm(filmId);
		// id,        filmId, titleKor, titleEng, director, actor, trailer, synopsys, trivia, nickName
		// 영화 상세번호, 영화 번호, 영화 제목, 영화 영어제목, 감독,      배우,    예고편,   시놉시스,    트리비아, 글쓴이 닉네임 
		
		// 포스터 이미지
		Image i = dfService.selectFilmImage(df.getId());
		
		// 배우 리스트
		ArrayList<Actor> al = dfService.selectActorList(df.getId());
		
		// 리뷰 리스트
		ArrayList<Review> rl = dfService.selectReivewList(filmId);
		
		mv.addObject("df",df).addObject("rl",rl).addObject("i",i).addObject("al",al).setViewName("detailFilm/detailFilmView");
		return mv; 
	}
	
	// 수정 페이지로 이동
	@RequestMapping("detailFilmUpdate.do")
	public ModelAndView detailFilmUpdateView(int filmId, ModelAndView mv) {
		
		// 영화 상세정보
		DetailFilm df = dfService.selectDetailFilm(filmId);	
		
		// 포스터 이미지
		Image i = dfService.selectFilmImage(df.getId()); 
		
		// 배우 리스트
		ArrayList<Actor> al = dfService.selectActorList(df.getId());
		
		mv.addObject("df",df).addObject("al",al).addObject("i",i).setViewName("detailFilm/detailFilmUpdate");
		
		return mv;
	}
	
	// 배우 검색
	@ResponseBody
	@RequestMapping(value="searchActorList.do", produces="application/json; charset=UTF-8")
	public String selectFilmActor(String searchName) {
		ArrayList<Actor> al = dfService.searchActorList(searchName);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		return gson.toJson(al);
	}
	
	// 배우 등록
	@RequestMapping("addActor.do")
	public ModelAndView addActor(int id, int filmId, int actorId, ModelAndView mv) {
		
		// 배우 등록
		int result = dfService.addActor(actorId, id);
		
		// 영화 업데이트 뷰 한번 더 뿌려주기
		// 영화 상세정보
		DetailFilm df = dfService.selectDetailFilm(filmId);	
		
		// 포스터 이미지
		Image i = dfService.selectFilmImage(df.getId()); 
		
		// 배우 리스트
		ArrayList<Actor> al = dfService.selectActorList(filmId);
		
		mv.addObject("df",df).addObject("al",al).addObject("i",i).setViewName("detailFilm/detailFilmUpdate");
		
		return mv;
	}
	
	// 수정 정보 insert
	@RequestMapping("detailFilmInsert.do")
	public ModelAndView detailFilmInsert(DetailFilm df, int uId, String filmImage, ModelAndView mv) {
		
		// 이미지 저장용 select 한번 더
		int result = dfService.detailFilmInsert(df, uId);
		int result2 = dfService.filmImageInsert(filmImage, df.getId());
		
		// 배우 검색 창 구현 -> 배우 검색 -> 배우 선택해서 확인 -> 배우 번호/ df.detailId랑 tb_film_actor에 insert
		
		mv.addObject("filmId", df.getFilmId()).setViewName("redirect:detailFilm.do");
		
		return mv;

	}
	
	// 영화 디테일 정보 Rollback
	@RequestMapping("detailFilmRollback.do")
	public ModelAndView detailFilmRollback(int filmId, ModelAndView mv) {
											// Detail_film 번호
		int result = dfService.detailFilmRollback(filmId);
		
		DetailFilm df = dfService.selectDetailFilm(filmId);	
		mv.addObject("filmId", df.getFilmId()).setViewName("redirect:detailFilm.do");
		
		return mv;
	}
	
}
