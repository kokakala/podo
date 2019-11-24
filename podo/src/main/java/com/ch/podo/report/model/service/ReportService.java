package com.ch.podo.report.model.service;

import java.util.ArrayList;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.report.model.vo.Report;

public interface ReportService {
	
	// 관리자
	// 1_1. 게시판 총 갯수 조회용 서비스
	int getReportListCount();
	
	// 1_2. 현재 페이지에 보여질 회원 리스트 조회용 서비스
	ArrayList<Report> selectReportList(PageInfo pi);

}
