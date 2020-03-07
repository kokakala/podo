package com.ch.podo.board.controller;

import java.io.File;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.board.model.service.BoardService;
import com.ch.podo.board.model.vo.Board;
import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.common.Image;
import com.ch.podo.common.Pagination;
import com.ch.podo.member.model.vo.Member;
import com.ch.podo.notice.model.service.NoticeService;
import com.ch.podo.notice.model.vo.Notice;
import com.ch.podo.report.model.vo.Report;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;
	
	@Autowired
	private NoticeService noticeService;

	@RequestMapping("blist.do")
	public ModelAndView boardList(ModelAndView mv,
																@RequestParam(value = "currentPage", defaultValue = "1") int currentPage) {
		int listCount = boardService.getBoardCount(); // 게시판 총 개수 조회
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);

		ArrayList<Board> list = boardService.selectBoardList(pi); // 페이지에 보여질 리스트 조회
		Notice notice = noticeService.selectNoticeList();

		mv.addObject("pi", pi)
			.addObject("list", list)
			.addObject("notice", notice)
			.setViewName("board/boardListView");
		return mv;
	}
	
	
	@RequestMapping("binsertForm.do")
	public ModelAndView boardInsertView(HttpSession session, ModelAndView mv) {
		Member member = (Member)session.getAttribute("loginUser");
		mv.addObject("m", member)
			.setViewName("board/boardInsertForm");
		return mv;
	}
	
	// 게시판 작성
	@RequestMapping("binsert.do")
	public ModelAndView insertBoard(HttpServletRequest request, Board board, ModelAndView mv, HttpSession session,
																	@RequestParam(value = "uploadFile", required = false) MultipartFile file) {
		int result = boardService.insertBoard(board);
		if (result > 0) {
			mv.setViewName("redirect:blist.do");
		} else {
			mv.setViewName("redirect:exception.do");
		}
		return mv;
	}
	
	// 수정 및 삭제 할 게시글 상세 조회
	@RequestMapping("boardDetail.do")
	public ModelAndView boardDetail(String id, ModelAndView mv) {
		Board board = boardService.selectBoard(Integer.parseInt(id));
		board.setContent(board.getContent().replaceAll("(\\r\\n|\\n)", "<br>"));
		
		mv.addObject("board", board)
			.setViewName("board/boardDetailView");
		return mv;
		
	}

	@RequestMapping("boardUpdateForm.do")
	public ModelAndView boardUpdateView(String id, ModelAndView mv) {
		Board board = boardService.selectUpdateBoard(Integer.parseInt(id));
		log.info("board : {}", board);

		mv.addObject("board", board)
			.setViewName("board/boardUpdateForm");

		return mv;
	}
	
	@RequestMapping("boardUpdate.do")
	public ModelAndView boardUpdate(Board board, HttpServletRequest request, ModelAndView mv) {
		log.info("board : {}", board);
		
		int result = boardService.updateBoard(board);
		if (result > 0) {
			mv.addObject("board", board).setViewName("redirect:boardDetail.do?id=" + board.getId());
		} else {
			mv.setViewName("redirect:exception.do");
		}
		return mv;
	}
	
	@RequestMapping("boardDelete.do")
	public String boardDelete(String id, HttpServletRequest request, ModelAndView mv, Image image) {

		if (image.getOriginalName() != null) {
			String root = request.getSession().getServletContext().getRealPath("resources");
			String savePath = root + "/boardUploadFiles";
			File file = new File(savePath + "/" + image.getChangeName());
			if (file.exists()) {
				file.delete();
			}
		}
		
		int result = boardService.deleteBoard(Integer.parseInt(id));

		if (result > 0) {
			request.getSession().setAttribute("msg", "게시물이 삭제되었습니다.");
			return "redirect:blist.do";
		} else {
			return "redirect:blist.do";
		}
	}
	
	@RequestMapping("boardReportModal.do")
	public ModelAndView inapproCount(Report report, ModelAndView mv, HttpServletRequest request) {
		
		log.info("report : {}", report);
		if (report.getReportId() == null) {
			log.info("login");
		}

		int result = boardService.insertInappro(report);
		log.info("result : {}", result);
		
		if (result > 0) {
			request.getSession().setAttribute("msg", "정상적으로 신고되었습니다.");
			mv.addObject("id", report.getTargetId())
				.setViewName("redirect:boardDetail.do");
		} else {
			mv.addObject("msg", "신고하는 도중 실패하였습니다.").setViewName("");
		}

		return mv;

	}
	
}
