package com.ch.podo.board.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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
import com.ch.podo.image.model.vo.Image;
import com.ch.podo.member.model.vo.Member;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@Controller
public class BoardController {
	
	@Autowired
	private BoardService boardService;

	
	@RequestMapping("blist.do")
	public ModelAndView boardList(ModelAndView mv,
								  @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		
		int listCount = boardService.getBoardCount();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Board> list = boardService.selectBoardList(pi);
		
		mv.addObject("pi", pi).addObject("list", list).setViewName("board/boardListView");
		
		return mv;
		
	}
	
	
	@RequestMapping("binsertForm.do")
	public ModelAndView boardInsertView(HttpSession session, ModelAndView mv) {
		
		Member m = (Member)session.getAttribute("loginUser");
		
		System.out.println("윤진이가담은 객체"+m);
		
		mv.addObject("m", m).setViewName("board/boardInsertForm");
		
		return mv;
		
	}
	
	
	@RequestMapping("binsert.do")
	public int insertBoard(HttpServletRequest request, Model model, ModelAndView mv, Board b, Image i, Member m,
									@RequestParam(value="board-upload-file", required=false) MultipartFile file) {
		
		int result = 0;
		
		// 파일이 존재할 경우
		if(!file.getOriginalFilename().equals("")) {
			
			String renameFileName = saveFile(file, request);
			
			i.setOriginalName(file.getOriginalFilename());
			i.setChangeName(renameFileName);
			
			int result1 = boardService.insertBoard(b);
			int result2 = boardService.insertBoardFile(i);
			
			if(result1 > 0 && result2 > 0) {
				result = 1;
			}else {
				result = 0;
			}
			
		}else {
			
			int result1 = boardService.insertBoard(b);
			
			if(result1 > 0) {
				result = 1;
			}else {
				result = 0;
			}
			
			
		}
		
		return result;
		
	}
	
	
	public String saveFile(MultipartFile file, HttpServletRequest request) {
		
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "/boardUploadFiles";
		
		File folder = new File(savePath);
		
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		String originalFileName = file.getOriginalFilename();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		
		String renameFileName = sdf.format(new Date(System.currentTimeMillis())) + "." + originalFileName.substring(originalFileName.lastIndexOf(".")+1);
		
		String renamePath = savePath + "/" + renameFileName;
		
		try {
			
			file.transferTo(new File(renamePath));
			
		} catch (IllegalStateException | IOException e) {
			
			e.printStackTrace();
			
		}
		
		return renameFileName;
		
	}
	
	
	
	
	
	@RequestMapping("bdetail.do")
	public ModelAndView boardDetail(HttpSession session, int id, ModelAndView mv) {
		Member m = (Member)session.getAttribute("loginUser");
		Board b = boardService.selectBoard(id);
		System.out.println("윤진이가적은!!"+b);
		System.out.println("윤진이가적은!!"+m);
		
		if(b != null) {
			mv.addObject("b", b).addObject("m", m).setViewName("board/boardDetailView");
		}else {
			mv.addObject("alert", "error");
		}
		
		return mv;
		
	}
	
	
	@RequestMapping("bdelete.do")
	public String boardDelete(int id, HttpServletRequest request) {
		
//		Board b = boardService.selectUpdateBoard(id);
				
		int result = boardService.deleteBoard(id);
		
		if(result > 0) {
			return "redirect:blist.do";
		}else {
			return "";
		}
		
	}
	
	
	// 업로드되어있는 파일 삭제용 메소드
	public void deleteFile(String renameFileName, HttpServletRequest request) {
		
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "/boardUploadFiles";
		
		File f = new File(savePath + "/" + renameFileName);
		
		if(f.exists()) {
			f.delete();
		}
		
	}
	
	
	@RequestMapping("bupdateView.do")
	public ModelAndView boardUpdateView(int id, ModelAndView mv) {
		
		Board b = boardService.selectBoard(id);
		
		mv.addObject("b", b).setViewName("board/boardUpdateForm");
		
		return mv;
		
	}
	
	
	@RequestMapping("bupdate.do")
	public ModelAndView boardUpdate(Board b, HttpServletRequest request, ModelAndView mv,
									@RequestParam(value="reloadFile", required=false) MultipartFile file) {
		
		
		
		int result = boardService.updateBoard(b);
		
		if(result > 0) {
			mv.addObject("id", b.getId()).setViewName("redirect:bdetail.do");
		}else {
			mv.addObject("");
		}
		
		return mv;
		
	}
	
	
	// 댓글
	@ResponseBody
	@RequestMapping(value="commentList.do", produces="application/json; charset=UTF-8")
	public String CommentList(int id) {
		
		ArrayList<Comment> cList = boardService.selectCommentList(id);
		
		Gson gson = new GsonBuilder().setDateFormat("yyyy-MM-dd").create();
		
		return gson.toJson(cList);
		
	}
	
	
	@ResponseBody
	@RequestMapping("commentInsert.do")
	public String insertComment(Comment c, ModelAndView mv) {
		
		int result = boardService.insertComment(c);
		
		if(result > 0) {
			return "success";
		}else {
			return "fail";
		}
	}
	

	//처란 메인페이지 리스트관련
	@RequestMapping("boardListHome.do")
	public ModelAndView selectboardListHome(ModelAndView mv) {
		
		ArrayList<Board> list = boardService.selectboardListHome();
		
		mv.addObject("list", list).setViewName("board/boardListHome");
		
		return mv;		
		
	}

	

}
