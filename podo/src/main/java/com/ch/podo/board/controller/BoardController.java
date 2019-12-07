package com.ch.podo.board.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.board.model.service.BoardService;
import com.ch.podo.board.model.vo.Board;
import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.comment.model.vo.Comment;
import com.ch.podo.common.Pagination;
import com.ch.podo.common.PodoRenamePolicy;
import com.ch.podo.image.model.vo.Image;
import com.ch.podo.member.model.vo.Member;
import com.ch.podo.notice.model.service.NoticeService;
import com.ch.podo.notice.model.vo.Notice;
import com.ch.podo.report.model.vo.Report;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonIOException;

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
		Member m = (Member)session.getAttribute("loginUser");
		mv.addObject("m", m)
			.setViewName("board/boardInsertForm");
		return mv;
	}
	
	// 게시판 작성
	@RequestMapping("binsert.do")
	public ModelAndView insertBoard(HttpServletRequest request, Board board, ModelAndView mv, HttpSession session, 
																	@RequestParam(value = "board-upload-file", required = false) MultipartFile file) {
		
		if (!file.getOriginalFilename().equals("")) {
			String renameFileName = PodoRenamePolicy.rename(file, request, "/boardUploadFiles");
			board.setImageName(renameFileName);
			// log.info("renameFileName : " + renameFileName);
		}
		
		int result = boardService.insertBoard(board);
		if (result > 0) {
			mv.setViewName("redirect:blist.do");
		} else {
			mv.setViewName("error/errorPage");
		}
		return mv;
	}
	
	// 수정 및 삭제 할 게시글 상세 조회
	@RequestMapping("bdetail.do")
	public ModelAndView boardDetail(int id, ModelAndView mv) {
		Board board = boardService.selectBoard(id);
		board.setContent(board.getContent().replaceAll("(\\r\\n|\\n)", "<br>"));
		// log.info("board : " + board);
		
		mv.addObject("board", board)
			.setViewName("board/boardDetailView");
		return mv;
		
	}

	@RequestMapping("bupdateView.do")
	public ModelAndView boardUpdateView(String id, ModelAndView mv) {
		Board board = boardService.selectUpdateBoard(Integer.parseInt(id));
		// log.info("board : " + board);

		mv.addObject("board", board)
			.setViewName("board/boardUpdateForm");

		return mv;
	}
	
	@RequestMapping("bupdate.do")
	public ModelAndView boardUpdate(Board board, HttpServletRequest request, ModelAndView mv,
			@RequestParam(value = "board-upload-file", required = false) MultipartFile file) {

		if (!file.getOriginalFilename().equals("")) {
			String renameFileName = PodoRenamePolicy.rename(file, request, "/boardUploadFiles");
			board.setImageName(renameFileName);
			// log.info("renameFileName : " + renameFileName);
		}

		int result = boardService.updateBoard(board);
		if (result > 0) {
			mv.addObject("board", board).setViewName("redirect:blist.do?id=" + board.getId());
		} else {
			mv.setViewName("error/errorPage");
		}
		return mv;
	}
	
	@RequestMapping("bdelete.do")
	public String boardDelete(int id, HttpServletRequest request, ModelAndView mv, Image i) {

		if (i.getOriginalName() != null) {
			String root = request.getSession().getServletContext().getRealPath("resources");
			String savePath = root + "/boardUploadFiles";
			File f = new File(savePath + "/" + i.getChangeName());
			if (f.exists()) {
				f.delete();
				// log.info("Delete File!");
				// 수정 전 파일들은 삭제할 수 없음 -> 시간없으니 생략
			}
		}
		
		int result = boardService.deleteBoard(id);

		if (result > 0) {
			return "redirect:blist.do";
		} else {
			return "redirect:blist.do";
		}
	}
	
	
	// 댓글
	
	// 댓글 리스트
	@ResponseBody
	@RequestMapping(value="commentsList.do", produces="application/json; charset=UTF-8")
	public String CommentList(int id) {
		
		ArrayList<Comment> list = boardService.selectCommentList(id);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		
		return gson.toJson(list);
		
	}
	
	
	// 댓글 작성
	@RequestMapping("insertComment.do")
	public String insertComment(Comment c) {
		
		int result = boardService.insertComment(c);
		
		if (result > 0) {
			return "success";
		} else {
			return "fail";
		}
		
	}
	
	
	// 댓글 수정
	@RequestMapping("updateComment.do")
	public String updateComment(int id, String content) {
		
		int result = boardService.updateComment(id, content);
		
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
		
	}
	
	
	// 댓글 삭제
	@RequestMapping("deleteComment.do")
	public String deleteComment(int id) {
		
		int result = boardService.deleteComment(id);
		
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
		
	}
	
	

	// 처란 메인페이지 리스트관련
	@RequestMapping("boardListHome.do")
	public ModelAndView selectboardListHome(ModelAndView mv) {
		ArrayList<Board> list = boardService.selectboardListHome();
		mv.addObject("list", list).setViewName("board/boardListHome");
		return mv;
		
	}
	
	
	// ----- 신고 -----
	@ResponseBody
	@RequestMapping("bReportModal.do")
	public ModelAndView inapproCount(Board b, Report r, ModelAndView mv) {
		
		int result = boardService.insertInappro(r);
		
		if(result > 0) {
			mv.addObject("id", r.getTargetId()).setViewName("redirect:bdetail.do");
		}else {
			mv.addObject("msg", "신고하기 실패").setViewName("");
		}
		
		return mv;
		
	}
	
	
	// ----- 좋아요 -----
	

}
