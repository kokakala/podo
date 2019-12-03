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
		
		int listCount = boardService.getBoardCount(); // 게시판 총 개수 조회
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Board> list = boardService.selectBoardList(pi); // 페이지에 보여질 리스트 조회
		
		mv.addObject("pi", pi).addObject("list", list).setViewName("board/boardListView");
		
		return mv;
		
	}
	
	
	@RequestMapping("binsertForm.do")
	public ModelAndView boardInsertView(HttpSession session, ModelAndView mv) {
		
		Member m = (Member)session.getAttribute("loginUser");
		
		mv.addObject("m", m).setViewName("board/boardInsertForm");
		
		return mv;
		
	}
	
	
	// 게시판 작성
	@RequestMapping("binsert.do")
	public String insertBoard(HttpServletRequest request, Board b, Image i, ModelAndView mv, HttpSession session, 
								@RequestParam(value="board-upload-file", required=false) MultipartFile file) {
		
		if(!file.getOriginalFilename().equals("")) { // 파일이 존재할 경우
			
			Image img = saveFile(file, request, i);
			
			b.setPath(img.getPath());
			b.setOriginalName(img.getOriginalName());
			b.setChangeName(img.getChangeName());
						
			i.setPath(img.getPath());
			i.setOriginalName(img.getOriginalName());
			i.setChangeName(img.getChangeName());
			
			int result = boardService.insertBoard(b);
			int result2 = boardService.insertBoardFile(i);
			
			if(result > 0 && result2 > 0) {
				return "redirect:blist.do";
			}else {
				
			}
			
		}else {
			
			int result = boardService.insertBoard(b);
			
			if(result > 0) {
				return "redirect:blist.do";
			}
			
		}
		
		return null;
		
	}
	
	
	public Image saveFile(MultipartFile file, HttpServletRequest request, Image i) {
		
		String root = request.getSession().getServletContext().getRealPath("resources");
		String savePath = root + "/boardUploadFiles";
		
		File folder = new File(savePath);
		
		if(!folder.exists()) {
			folder.mkdirs();
		}
		
		String originalFileName = file.getOriginalFilename();
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		
		String renameFileName = sdf.format(new Date(System.currentTimeMillis())) + "." + originalFileName.substring(originalFileName.lastIndexOf(".") + 1);
				
		String renamePath = savePath + "/" + renameFileName;
		
		i.setPath(renamePath);
		i.setOriginalName(originalFileName);
		i.setChangeName(renameFileName);
		
		try {
			file.transferTo(new File(renamePath));
		} catch (IllegalStateException | IOException e) {
			e.printStackTrace();
		}
		
		return i;
		
	}
	
	
	// 수정 및 삭제 할 게시글 상세 조회
	@RequestMapping("bdetail.do")
	public ModelAndView boardDetail(int id, ModelAndView mv) {
		
		Board b = boardService.selectBoard(id);
		Image i = boardService.selectBoardFile(id);
		
		if(i != null) {
			
			mv.addObject("b", b).addObject("i", i).setViewName("board/boardDetailView");
			
		}else{
			mv.addObject("b", b).setViewName("board/boardDetailView");
		}
		
		return mv;
		
	}
	
	
	// 게시글 삭제
	@RequestMapping("bdelete.do")
	public String boardDelete(int id, HttpServletRequest request, ModelAndView mv, Image i) {
		
		Board b = boardService.selectUpdateBoard(id);
		
		if(i.getOriginalName() != null) {
			deleteFile(i.getChangeName(), request);
		}
		
		int result = boardService.deleteBoard(id);
		
		if(result > 0) {
			return "redirect:blist.do";
		}else {
			return "redirect:blist.do";
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
		
		Board b = boardService.selectUpdateBoard(id);
		Image i = boardService.selectUpdateBoardFile(id);
		
		System.out.println("i : " + i);
		System.out.println("b : " + b);
		mv.addObject("b", b).addObject("i", i).setViewName("board/boardUpdateForm");
		
		return mv;
		
	}
	
	
	@RequestMapping("bupdate.do")
	public ModelAndView boardUpdate(Board b, Image i, HttpServletRequest request, ModelAndView mv,
			@RequestParam(value = "board-upload-file", required = false) MultipartFile file) {
		
		System.out.println(i);
		if(!i.getOriginalName().equals("")) {
			
			deleteFile(i.getChangeName(), request);
			
			Image img = saveFile(file, request, i);			
			
			int result1 = boardService.updateBoard(b);
			int result2 = boardService.updateBoardFile(i);
			
			i.setPath(img.getPath());
			i.setOriginalName(img.getOriginalName());
			i.setChangeName(img.getChangeName());
			
			if (result1 > 0 && result2 > 0) {
				mv.addObject("id", b.getId()).setViewName("redirect:bdetail.do");
			}

		} else {

			int result1 = boardService.updateBoard(b);

			if (result1 > 0) {
				mv.addObject("id", b.getId()).setViewName("redirect:bdetail.do");
			}

		}

		return mv;

	}
	
	// ----------------------------- 정말 모르겠다...
	
	
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
