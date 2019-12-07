package com.ch.podo.notice.controller;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;
import org.springsource.loaded.Log;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.common.Pagination;
import com.ch.podo.common.PodoRenamePolicy;
import com.ch.podo.member.model.vo.Member;
import com.ch.podo.notice.model.service.NoticeService;
import com.ch.podo.notice.model.vo.Notice;

@Controller("noticeController")
public class NoticeController {
	
	@Autowired
	private NoticeService noticeService;
	
	
	
	
	@RequestMapping("ninsertForm.do")
	public ModelAndView NoticeInsertView(HttpSession session, ModelAndView mv) {
		
		Member m = (Member)session.getAttribute("loginUser");
		
		mv.addObject("m", m).setViewName("notice/noticeInsertForm");
		
		return mv;
	}
	
	
	// 공지사항 작성
	@RequestMapping("ninsert.do")
	public ModelAndView insertNotice(Notice notice, HttpServletRequest request, ModelAndView mv, HttpSession session, 
										@RequestParam(value="notice-upload-file", required=false) MultipartFile file) {
		
		if(!file.getOriginalFilename().equals("")) {
			
			String renameFileName = PodoRenamePolicy.rename(file, request, "/noticeUploadFiles");
			
			notice.setImageName(renameFileName);
			
		}
		
		int result = noticeService.insertNotice(notice);
		
		if(result > 0) {
			mv.setViewName("redirect:blist.do");
		}else {
			mv.setViewName("error/errorPage");
		}
		
		return mv;
	}
	
	
	// 수정 및 삭제 할 공지사항
	@RequestMapping("ndetail.do")
	public ModelAndView noticeDetail(int id, ModelAndView mv) {
		
		Notice notice = noticeService.selectNotice(id);
		
		notice.setContent(notice.getContent().replaceAll("(\\r\\n|\\n)", "<br>"));
		
		mv.addObject("notice", notice).setViewName("notice/noticeDetailView");
		
		return mv;
	}
	
	
	@RequestMapping("nupdateView.do")
	public ModelAndView noticeUpdateView(int id, ModelAndView mv) {
		
		Notice notice = noticeService.selectUpdateNotice(id);
		
		mv.addObject("notice", notice).setViewName("notice/noticeUpdateForm");
		
		return mv;
	}
	
	
	@RequestMapping("ndelete.do")
	public String noticeDelete(int id, HttpServletRequest request) {
		
		int result = noticeService.deleteNotice(id);
		
		if(result > 0) {
			
			return "redirect:blist.do";	
			
			
		}else {
			return "redirect:blist.do";
		}
		
	}
	
	
	
	
	@RequestMapping("nupdate.do")
	public ModelAndView noticeUpdate(Notice notice, HttpServletRequest request, ModelAndView mv, 
										@RequestParam(value="notice-upload-file", required=false) MultipartFile file) {
		
		if(!file.getOriginalFilename().equals("")) {
			
			String renameFileName = PodoRenamePolicy.rename(file, request, "/noticeUploadFiles");
			notice.setImageName(renameFileName);
			
		}
		
		int result = noticeService.updateNotice(notice);
		
		if(result > 0) {
			mv.addObject("notice", notice).setViewName("redirect:ndetail.do?id=" + notice.getId());
		}else {
			mv.setViewName("error/errorPage");
		}
		
		return mv;
	}
	

}
