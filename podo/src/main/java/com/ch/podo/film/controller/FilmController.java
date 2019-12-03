package com.ch.podo.film.controller;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.GregorianCalendar;
import java.util.HashMap;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.common.Pagination;
import com.ch.podo.common.PodoRenamePolicy;
import com.ch.podo.common.SearchCondition;
import com.ch.podo.detailFilm.model.vo.DetailFilm;
import com.ch.podo.film.model.service.FilmService; 
import com.ch.podo.film.model.vo.Film;
import com.ch.podo.film.model.vo.Genre;
import com.ch.podo.image.model.vo.Image;
import com.ch.podo.like.model.service.LikeService;
import com.ch.podo.like.model.vo.Like;
import com.ch.podo.member.model.vo.Member;
import com.ch.podo.ratingFilm.model.service.RatingFilmService;
import com.ch.podo.ratingFilm.model.vo.RatingFilm;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonIOException;

import kr.or.kobis.kobisopenapi.consumer.rest.KobisOpenAPIRestService;
import kr.or.kobis.kobisopenapi.consumer.rest.exception.OpenAPIFault;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class FilmController {
	
	@Autowired
	private FilmService filmService;

	@Autowired
	private LikeService likeService;

	@Autowired
	private RatingFilmService ratingFilmService;
	
	/**
	 * 키워드 검색
	 * @param mv
	 * @param keyword
	 * @param currentPage
	 * @return
	 * @author Changsu Im
	 * @throws Exception 
	 * @throws OpenAPIFault 
	 */
	@RequestMapping("skFilm.do")
	public ModelAndView searchKeywordFilm(HttpServletRequest request, ModelAndView mv,
																				String keyword, String skeyword,
																				@RequestParam(value="p", defaultValue = "1") int currentPage)
																						throws OpenAPIFault, Exception {
		// log.info("keyword : " + keyword);
		// log.info("skeyword : " + skeyword);
		// log.info("currentPage : " + currentPage);
		
		int filmCount = filmService.selectKeywordFilmListCount(keyword, skeyword);
		// page는 최대 3페이지, board는 최대 6개 보여지도록 set
		PageInfo pi = Pagination.setPageLimit(currentPage, filmCount, 3, 6);
		// log.info("pi : " + pi);

		ArrayList<Film> list = filmService.selectKeywordFilmList(keyword, skeyword, pi);
		
		// http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=734ea4839ec968cbcd71b13515f7c5ee&targetDt=20191201
		// http://www.kobis.or.kr/kobisopenapi/homepg/board/findTutorial.do
		// 조회일자
		Calendar cal = new GregorianCalendar(Locale.KOREA);
		cal.add(Calendar.DATE, -1); // 오늘날짜로부터 -1
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
		// log.info("yesterday : " + sdf.format(cal.getTime()));
		String targetDt = request.getParameter("targetDt") == null ? sdf.format(cal.getTime()):request.getParameter("targetDt");
		// 결과  ROW 수
		String itemPerPage = request.getParameter("itemPerPage") == null ? "10":request.getParameter("itemPerPage");
		// "Y" : 다양성 영화, "N" : 상업 영화 (default : 전체)
		String multiMovieYn = request.getParameter("multiMovieYn") == null ? "":request.getParameter("multiMovieYn");
		// "K" : 한국 영화, "F" : 외국 영화 (default : 전체)
		String repNationCd = request.getParameter("repNationCd") == null ? "":request.getParameter("repNationCd");
		// "0105000000" 로서 조회된 지역코드
		String wideAreaCd = request.getParameter("wideAreaCd") == null ? "":request.getParameter("wideAreaCd");
		// 키로 서비스 객체 생성
		String key = "734ea4839ec968cbcd71b13515f7c5ee";
		KobisOpenAPIRestService kobisOpenAPIRestService = new KobisOpenAPIRestService(key);
		
		// 일일 박스오피스 서비스 호출
		// (boolean isJson, String targetDt, String itemPerPage, String multiMovieYn, String repNationCd, String wideAreaCd)
		String dailyResponse = kobisOpenAPIRestService.getDailyBoxOffice(true, targetDt, itemPerPage, multiMovieYn, repNationCd, wideAreaCd);
		
		// Json 라이브러리(jackson-databind)를 통해 Handling
		ObjectMapper mapper = new ObjectMapper();
		HashMap<String, Object> dailyResult = mapper.readValue(dailyResponse, HashMap.class);
		mv.addObject("dailyResult", dailyResult);
		// log.info("dailyResult : " + dailyResult);
		
		// KOBIS 오픈 API Rest Client를 통해 코드 서비스 호출 (boolean isJson, String comCode)
		String codeResponse = kobisOpenAPIRestService.getComCodeList(true, "0105000000");
		HashMap<String, Object> codeResult = mapper.readValue(codeResponse, HashMap.class);
		mv.addObject("codeResult", codeResult);
		
		mv.addObject("filmCount", filmCount)
			.addObject("pi", pi)
			.addObject("list", list)
			.addObject("keyword", keyword)
			.addObject("skeyword", skeyword)
			.setViewName("search/searchAll");
		
		return mv;
	}
	
	/**
	 * 필름 페이지 이동
	 * @deprecated
	 * @param model
	 * @return
	 * @author Changsu Im
	 */
	@RequestMapping("goFilm.do")
	public String filmPage(Model model) {
		ArrayList<String> release = filmService.selectAllReleaseYearList();
		ArrayList<String> country = filmService.selectAllCountryList();
		ArrayList<Genre> genre = filmService.selectAllGenreList();
		
		model.addAttribute("release", release)
				 .addAttribute("country", country)
				 .addAttribute("genre", genre);
		
		return "film/filmPage";
	}
	
	/**
	 * 영화 찾기 페이지에서 필터 검색
	 * @param response
	 * @param session
	 * @param film
	 * @throws JsonIOException
	 * @throws IOException
	 * @author Changsu Im
	 */
	@RequestMapping("film.do")
	public ModelAndView searchFilterFilm(HttpServletResponse response, HttpSession session,
																			 SearchCondition sc, ModelAndView mv,
																			 @RequestParam(value="p", defaultValue = "1") int currentPage)
			throws JsonIOException, IOException {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		if (loginUser != null) {
			sc.setUserId(loginUser.getId());
		}
		log.info("sc : " + sc);
		
		// 필터 목록 조회
		ArrayList<String> release = filmService.selectAllReleaseYearList();
		ArrayList<String> country = filmService.selectAllCountryList();
		ArrayList<Genre> genre = filmService.selectAllGenreList();
		
		int listCount = filmService.selectFilterFilmListCount(sc);
		log.info("listCount : " + listCount);
		
		// page는 최대 3페이지, board는 최대 12개 보여지도록 set
		PageInfo pi = Pagination.setPageLimit(currentPage, listCount, 5, 12);
		// 선택한 옵션이 있다면 옵션으로 검색된 목록을 대상으로 페이징 처리
		if (!((sc.getReleaseYear() == null || sc.getReleaseYear().equals("all"))
				  && (sc.getProductionCountry() == null || sc.getProductionCountry().equals("all"))
		 	    && (sc.getGenreId() == null || sc.getGenreId().equals("0"))
		 	    && (sc.getSaw() == null || sc.getSaw().equals("all"))
		 	    && (sc.getOrder() == null || sc.getOrder().equals("all")))) {
			pi = Pagination.setNewPageLimit(currentPage, listCount, pi);
			// logger.info("new pi : " + pi);
		}
		// 옵션으로 검색된 영화 목록
		ArrayList<Film> filmList = filmService.selectFilterFilmList(sc, pi);
		// logger.info("filmList : " + filmList);
		// logger.info("filmList.size() : " + filmList.size());
		
		// 사용자가 좋아요한 영화 목록
		HashMap<Integer, Like> likeMap = new HashMap<>();
		if (loginUser != null) {
			likeMap = (HashMap<Integer, Like>)likeService.selectLikedFilmMap(loginUser.getId());
		}
		
		// 사용자가 평가한 영화 목록
		HashMap<Integer, RatingFilm> ratingMap = new HashMap<>();
		if (loginUser != null) {
			ratingMap = (HashMap<Integer, RatingFilm>)ratingFilmService.selectRatedFilm(loginUser.getId());
		}
		// logger.info("ratingMap : " + ratingMap);
		
		mv.addObject("release", release)
			.addObject("country", country)
			.addObject("genre", genre)
			.addObject("film", filmList)
			.addObject("sc", sc)
			.addObject("pi", pi)
			.addObject("like", likeMap)
			.addObject("rate", ratingMap)
			.setViewName("film/filmPage");
		
		return mv;
	}
	
	/**
	 * @deprecated
	 * @param response
	 * @param session
	 * @param film
	 * @throws JsonIOException
	 * @throws IOException
	 * @author Changsu Im
	 */
	@RequestMapping("sfFilm.do")
	public void sfFilm(HttpServletResponse response, HttpSession session, Film film)
			throws JsonIOException, IOException {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		HashMap<String, Object> map = new HashMap<String, Object>();
		
		// logger.info("film : " + film);
		
		// 옵션으로 검색된 영화 목록
		// ArrayList<Film> filmList = filmService.selectFilterFilmList(film);
		// map.put("film", filmList);
		
		// logger.info("filmList : " + filmList);
		
		// 사용자가 좋아요한 영화 목록
		HashMap<Integer, Like> likeMap = new HashMap<>();
		if (loginUser != null) {
			likeMap = (HashMap<Integer, Like>)likeService.selectLikedFilmMap(loginUser.getId());
		}
		map.put("like", likeMap);
		
		// 사용자가 평가한 영화 목록
		HashMap<Integer, RatingFilm> ratingMap = new HashMap<>();
		if (loginUser != null) {
			ratingMap = (HashMap<Integer, RatingFilm>)ratingFilmService.selectRatedFilm(loginUser.getId());
		}
		map.put("rate", ratingMap);
		
		response.setContentType("application/json; charset=utf-8");
		Gson gson = new Gson();
		gson.toJson(map, response.getWriter());
	}
	
	
	/**
	 * 영화 페이지에서 좋아요 서비스
	 * @param response
	 * @param session
	 * @param fid
	 * @param flag
	 * @throws JsonIOException
	 * @throws IOException
	 * @author Changsu Im
	 */
	@ResponseBody
	@RequestMapping("likeFilm.do")
	public int likeFilm(HttpServletResponse response, HttpSession session,
											 String fid, @RequestParam("flag") int flag)
			throws JsonIOException, IOException {
		Member loginUser = (Member)session.getAttribute("loginUser");
		log.info("loginUser : " + loginUser);
		
		if (loginUser == null) {
			return 0;
		}
		
		Like like = new Like();
		like.setTargetId(Integer.parseInt(fid));
		like.setUserId(loginUser.getId());
		
		if (flag > 0) {
			log.info("like insert 실행");
			return likeService.insertLikeFilm(like);
		} else {
			log.info("like delete 실행");
			return likeService.deleteLikeFilm(like);
		}
		
	}
	
	/**
	 * 영화 페이지에서 봤어요 서비스
	 * @param response
	 * @param session
	 * @param fid
	 * @param flag
	 * @throws JsonIOException
	 * @throws IOException
	 * @author Changsu Im
	 * @since 2019-11-29
	 */
	@ResponseBody
	@RequestMapping("sawFilm.do")
	public int sawFilm(HttpServletResponse response, HttpSession session,
											String fid, @RequestParam("flag") int flag)
					throws JsonIOException, IOException {
		Member loginUser = (Member)session.getAttribute("loginUser");

		if (loginUser == null) {
			return 0;
		}
		
		RatingFilm rate = new RatingFilm();
		rate.setFilmId(Integer.parseInt(fid));
		rate.setUserId(loginUser.getId());
		
		if (flag > 0) {
			log.info("saw insert 실행");
			return ratingFilmService.insertSawFilm(rate);
		} else {
			log.info("saw delete 실행");
			return ratingFilmService.deleteSawFilm(rate);
		}
		
	}
	
	/**
	 * 영화 페이지에서 별점 서비스
	 * @param response
	 * @param session
	 * @param fid
	 * @param star
	 * @throws JsonIOException
	 * @throws IOException
	 * @author Changsu Im
	 */
	@ResponseBody
	@RequestMapping("rateFilm.do")
	public int rateFilm(HttpServletResponse response, HttpSession session, String fid, String star)
			throws JsonIOException, IOException {
		Member mem = (Member)session.getAttribute("loginUser");
		
		RatingFilm rate = new RatingFilm();
		rate.setStar(Integer.parseInt(star));
		rate.setUserId(mem.getId());
		rate.setFilmId(Integer.parseInt(fid));
		
		RatingFilm flag = ratingFilmService.selectRatingFilm(rate);

		// 이미 기존에 있는 별점을 다시 눌렀을 경우 취소되면서 삭제
		if (flag != null && Integer.parseInt(star) == flag.getStar()) {
			log.info("rate delete 실행");
			return ratingFilmService.deleteRateFilm(rate);
		} else {
			// 기존에 별점이 없다면 삽입
			if (flag == null) {
				log.info("rate insert 실행");
				return ratingFilmService.insertRateFilm(rate);
			// 이미 기존에 별점이 있다면 수정
			} else {
				log.info("rate update실행");
				return ratingFilmService.updateLikeFilm(rate);
			}
		}
		
	}
	
	/**
	 * 영화 추천 페이지 이동시 쿼리문으로 추천 영화 불러오기
	 * @param session
	 * @param mv
	 * @param page
	 * @return
	 * @author Changsu Im
	 */
	@RequestMapping("rec.do")
	public ModelAndView rec(HttpSession session, ModelAndView mv,
													@RequestParam(value="page", defaultValue = "1") int page) throws Exception {
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		
		if (loginUser == null) {
			mv.setViewName("film/rec");
			return mv;
		}
		
		ArrayList<Film> list = null;
		int liked = 0;
		if (loginUser != null) {
			list = filmService.selectPreferredGenreFilmList(loginUser.getId());
			liked = filmService.selectLikedFilmCount(loginUser.getId());
		}
		
		// logger.info("list : " + list);
		// logger.info("liked : " + liked);
		
		// 좋아요 누른 영화가 10개 미만일 경우 count만 넘겨줌
		if (liked < 10) {
			mv.addObject("count", liked)
				.setViewName("film/rec");
		} else {
			// 쿼리문으로 추천 영화를 받아서 장르 3개 각각에 ArrayList를 받아줌
			HashMap<String, ArrayList<Film>> map = new HashMap<>();
			ArrayList<Film> rec = new ArrayList<>();
			ArrayList<String> genreId = new ArrayList<>();
			
			for (int i = 0; i < list.size(); i++) {
				if ((i + 1) != list.size()
						&& (list.get(i).getGenreId().equals(list.get(i + 1).getGenreId()))) {
					rec.add(list.get(i));
				} else {
					genreId.add(list.get(i).getGenreId());
					rec.add(list.get(i));
					map.put(list.get(i).getGenreId(), rec);
					rec = new ArrayList<Film>();
				}
			}
			rec = null;
			
			mv.addObject("genre1", map.get(genreId.get(0)))
				.addObject("genre2", map.get(genreId.get(1)))
				.addObject("genre3", map.get(genreId.get(2)))
				.addObject("page", page)
				.addObject("count", liked)
				.setViewName("film/rec");
		}
		
		return mv;
	}
	
	/**
	 * 영화 추천 페이지에서 더보기 누를 경우 다음 RowBounds 불러오기
	 * @deprecated
	 * @param session
	 * @param response
	 * @param page
	 * @throws JsonIOException
	 * @throws IOException
	 * @author Changsu Im
	 */
	@RequestMapping("moreRec.do")
	public void moreRec(HttpSession session, HttpServletResponse response,
											@RequestParam(value="page", defaultValue = "1") int page)
		throws JsonIOException, IOException {
		
		Member loginUser = (Member)session.getAttribute("loginUser");

		HashMap<String, Object> map = new HashMap<>();
		
		// 페이지 계산
		int listCount = 1;
		if (loginUser != null) {
			listCount = filmService.selectLikedFilmCount(loginUser.getId());
		}
		page++;
		PageInfo pi = Pagination.getPageInfo(page, listCount);
		pi.setPageLimit(3);
		pi.setBoardLimit(5);
		
		map.put("page", page);
		
		// RowBounds 포함 좋아요한 영화 목록 조회 AJAX
		ArrayList<Film> list = null;
		if (loginUser != null) {
			list = filmService.selectLikedFilmList(loginUser.getId(), pi);
		}
		map.put("list", list);

		response.setContentType("application/json; charset=utf-8");
		Gson gson = new Gson();
		gson.toJson(map, response.getWriter());
	}
	
	/**
	 * 관리자 페이지에서 전체 영화 목록
	 * @param mv
	 * @param currentPage
	 * @return
	 * @author Changsu Im, Yujeong Choi
	 */
	@RequestMapping("flist.do")
	public ModelAndView filmList(ModelAndView mv) {
		
		ArrayList<Film> list = filmService.selectFilmList();
		
		mv.addObject("list", list).setViewName("admin/filmListView");
		
		return mv;
	}
	
	/**
	 * 영화 등록페이지로 이동
	 * @param mv
	 * @return
	 * @author Changsu Im
	 */
	@RequestMapping("finsertForm.do")
	public ModelAndView finsertForm(ModelAndView mv) {
		
		ArrayList<Genre> genre = filmService.selectAllGenreList();
		mv.addObject("genre", genre)
			.setViewName("admin/filmInsertForm");
		
		return mv;
	}
	
	/**
	 * 실제로 영화 등록하는 기능
	 * @param mv
	 * @param film
	 * @param df
	 * @param img
	 * @param request
	 * @param file
	 * @return
	 * @author Changsu Im
	 */
	@RequestMapping("finsert.do")
	public ModelAndView finsert(ModelAndView mv, Film film, DetailFilm df, Image img,
															HttpServletRequest request, HttpSession session,
															@RequestParam(value = "uploadFile", required = false) MultipartFile file) {
		// logger.info("film : " + film);
		// logger.info("file : " + file);
		
		Member loginUser = (Member)session.getAttribute("loginUser");
		
		if (!file.getOriginalFilename().equals("")) {
			String renameFileName = PodoRenamePolicy.rename(file, request, "/detailFilmImage");
			img.setChangeName(renameFileName);
			log.info("renameFileName : " + renameFileName);
		}
		// logger.info("img : " + img);
		
		int result = filmService.insertFilm(film, loginUser.getId(), img);
		// logger.info("result : " + result);
		
		if (result > 0) {
			mv.setViewName("redirect:flist.do");
		} else {
			mv.setViewName("error/errorPage");
		}
		
		return mv;
	}
	
}
