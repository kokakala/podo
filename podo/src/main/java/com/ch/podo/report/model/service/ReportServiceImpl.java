package com.ch.podo.report.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.report.model.dao.ReportDao;
import com.ch.podo.report.model.vo.Report;

@Service("reportService")
public class ReportServiceImpl implements ReportService {
	

	@Autowired
	private ReportDao reportDao;

	@Override
	public int getReportListCount() {
		return reportDao.getReportListCount();
	}

	@Override
	public ArrayList<Report> selectReportList(PageInfo pi) {
		return reportDao.selectReportList(pi);
	}
	
	

}
