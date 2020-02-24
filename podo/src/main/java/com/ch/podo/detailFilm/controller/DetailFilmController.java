package com.ch.podo.detailFilm.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.common.Image;
import com.ch.podo.common.PodoRenamePolicy;
import com.ch.podo.detailFilm.model.service.DetailFilmService;
import com.ch.podo.detailFilm.model.vo.Actor;
import com.ch.podo.detailFilm.model.vo.DetailFilm;
import com.ch.podo.review.model.dto.Review;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class DetailFilmController {

	@Autowired
	private DetailFilmService dfService;

	@RequestMapping("detailFilm.do")
	public ModelAndView selectDetailFilm(int filmId, ModelAndView mv) {

		// 영화 상세정보
		DetailFilm detailFilm = dfService.selectDetailFilm(filmId);
		log.info("detail film : {}", detailFilm);
		
		// id, filmId, titleKor, titleEng, director, actor, trailer, synopsys, trivia,
		// nickName
		// 영화 상세번호, 영화 번호, 영화 제목, 영화 영어제목, 감독, 배우, 예고편, 시놉시스, 트리비아, 글쓴이 닉네임
		if (detailFilm.getSynopsys() != null) detailFilm.setSynopsys(detailFilm.getSynopsys().replaceAll("(\\r\\n|\\n)", "<br>"));
		if (detailFilm.getTrivia() != null) detailFilm.setTrivia(detailFilm.getTrivia().replaceAll("(\\r\\n|\\n)", "<br>"));

		// 포스터 이미지
		Image image = dfService.selectFilmImage(detailFilm.getId());

		// 배우 리스트
		ArrayList<Actor> actor = dfService.selectActorList(detailFilm.getId());

		// 리뷰 리스트
		ArrayList<Review> review = dfService.selectReivewList(filmId);

		mv.addObject("df", detailFilm)
			.addObject("reviews", review)
			.addObject("i", image)
			.addObject("al", actor)
			.setViewName("film/detailFilmView");
		
		return mv;
	}

	// 수정 페이지로 이동
	@RequestMapping("detailFilmUpdate.do")
	public ModelAndView detailFilmUpdateView(int filmId, ModelAndView mv) {

		// 영화 상세정보
		DetailFilm detailFilm = dfService.selectDetailFilm(filmId);
		// log.info("df : " + detailFilm);
		
		// 포스터 이미지
		Image image = null;
		// 배우 리스트
		ArrayList<Actor> al = null;
		
		if (detailFilm != null) {
			image = dfService.selectFilmImage(detailFilm.getId());
			al = dfService.selectActorList(detailFilm.getId());
		}

		mv.addObject("df", detailFilm)
			.addObject("al", al)
			.addObject("i", image)
			.setViewName("film/detailFilmUpdate");

		return mv;
	}

	// 배우 검색
	@ResponseBody
	@RequestMapping(value = "searchActorList.do", produces = "application/json; charset=UTF-8")
	public String selectFilmActor(String searchName) {
		ArrayList<Actor> actor = dfService.searchActorList(searchName);

		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		return gson.toJson(actor);
	}

	// 배우 등록
	@RequestMapping("addActor.do")
	public ModelAndView addActor(int id, int filmId, int newActorId, ModelAndView mv) {

		// 배우 등록
//		int result = dfService.addActor(newActorId, id);

		mv.addObject("filmId", filmId)
			.setViewName("redirect:detailFilmUpdate.do");

		return mv;
	}

	// 배우 삭제
	@RequestMapping("deleteActor.do")
	public ModelAndView deleteActor(int id, int filmId, int actorId, ModelAndView mv) {

		// 배우 삭제
//		int result = dfService.deleteActor(actorId, id);
		
		mv.addObject("filmId", filmId)
			.setViewName("redirect:detailFilmUpdate.do");

		return mv;
	}

	// 수정 정보 insert
	@RequestMapping("detailFilmInsert.do")
	public ModelAndView detailFilmInsert(DetailFilm df, int filmId, int userId, String filmImage, ModelAndView mv,
			HttpServletRequest request, @RequestParam(value = "uploadPosterFile", required = false) MultipartFile file) {
//		DetailFilm existsDetailFilm = dfService.existsDetailFilm(filmId);
		
		if (!file.getOriginalFilename().isEmpty() &&
				!file.getOriginalFilename().equals("")) {
			log.info("new film image exists>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>>");
			log.info("image file : {}", file);
			String renameFileName = PodoRenamePolicy.rename(file, request, "/detailFilmImage");
			filmImage = renameFileName;
		}
		
		log.info("detail film doesn't exist");
		int result = dfService.detailFilmInsert(df, userId, filmImage);
		
		if (result > 0) {
			mv.addObject("filmId", filmId)
				.setViewName("redirect:detailFilm.do");
		} else {
//			session.setAttribute("msg", "영화정보 수정 실패");
//			mv.setViewName("redirect:home.do");
			mv.setViewName("redirect:exception.do");
		}
		
		
		/*
		// 배우 목록 조회
		ArrayList<Actor> al = dfService.selectActorList(df.getId());
		String actorIdList = "";

		// 배우 리스트에서 배우 번호만 String으로 한줄로 저장
		if (al.size() != 0) {
			for (int i = 0; i < al.size(); i++) {
				actorIdList += al.get(i).getId();
				// 마지막 인덱스면 , 붙여주지 않음
				if (i != al.size() - 1) {
					// 구분자
					actorIdList += ",";
				}
			}

			// 이미지 저장용 select 한번 더
			int result = dfService.detailFilmInsert(df, uId);
			int result2 = dfService.filmImageInsert(filmImage, df.getId(), df.getFilmId());
			int result3 = dfService.actorInsert(actorIdList);

		} else {
			int result = dfService.detailFilmInsert(df, uId);
			int result2 = dfService.filmImageInsert(filmImage, df.getId(), df.getFilmId());
		}
		*/

		return mv;
	}

	// 영화 디테일 정보 Rollback
	@RequestMapping("detailFilmRollback.do")
	public ModelAndView detailFilmRollback(int filmId, ModelAndView mv) {
		// Detail_film 번호
//		int result = dfService.detailFilmRollback(filmId);

		DetailFilm df = dfService.selectDetailFilm(filmId);
		mv.addObject("filmId", df.getFilmId()).setViewName("redirect:detailFilm.do");

		return mv;
	}

}
