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
	public ModelAndView addActor(int id, int filmId, int newActorId, ModelAndView mv) {
		
		// 배우 등록
		System.out.println("newActor 컨트롤러 :" + newActorId);
		int result = dfService.addActor(newActorId, id);
		
		mv.addObject("filmId",filmId).setViewName("redirect:detailFilmUpdate.do");
		
		return mv;
	}
	
	// 수정 정보 insert
	@RequestMapping("detailFilmInsert.do")
	public ModelAndView detailFilmInsert(DetailFilm df, int uId, String filmImage, ModelAndView mv) {
		
		// 배우 리스트 한번 쫙 빼기
		ArrayList<Actor> al = dfService.selectActorList(df.getId());
		String actorIdList = "";
		
		// 배우 리스트에서 배우 번호만 String으로 한줄로 저장
		for(int i=0; i<al.size(); i++) {
			
			actorIdList += al.get(i).getId();
    		
    		// 마지막 인덱스면 , 붙여주지 않음
    		if (i != al.size()-1){
    			// 구분자
    			actorIdList += ",";
    		}
		}
		
		// 이미지 저장용 select 한번 더
		int result = dfService.detailFilmInsert(df, uId);
		int result2 = dfService.filmImageInsert(filmImage, df.getId());
		int result3 = dfService.actorInsert(actorIdList);
		
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
