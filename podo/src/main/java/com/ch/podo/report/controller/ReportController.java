package com.ch.podo.report.controller;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.common.Pagination;
import com.ch.podo.report.model.service.ReportService;
import com.ch.podo.report.model.vo.Report;

@Controller
public class ReportController {
	
	@Autowired
	private ReportService reportService;
	
	// 관리자 신고 리스트
	@RequestMapping("rlist.do")
	public ModelAndView reportList(ModelAndView mv, 
								  @RequestParam(value="currentPage", defaultValue="1") int currentPage) {
		
		int listCount = reportService.getReportListCount();
		
		PageInfo pi = Pagination.getPageInfo(currentPage, listCount);
		
		ArrayList<Report> list = reportService.selectReportList(pi);
		
		mv.addObject("pi", pi).addObject("list", list)
		  .setViewName("admin/reportListView");
		
		return mv;
	}
	
	
	

}
