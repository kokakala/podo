package com.ch.podo.report.model.service;

import java.util.ArrayList;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.report.model.vo.Report;

public interface ReportService {
	
	// 관리자
	// 1. 현재 페이지에 보여질 신고 회원 리스트 조회용 서비스
	ArrayList<Report> selectReportList();
	
	// 2. 현재 페이지에 보여질 게시글 리스트 조회용 서비스
	ArrayList<Report> selectReportBoardList();

}
