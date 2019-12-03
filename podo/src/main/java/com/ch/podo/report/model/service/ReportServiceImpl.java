package com.ch.podo.report.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ch.podo.report.model.dao.ReportDao;
import com.ch.podo.report.model.vo.Report;

@Service("reportService")
public class ReportServiceImpl implements ReportService {
	

	@Autowired
	private ReportDao reportDao;

	@Override
	public ArrayList<Report> selectReportList() {
		return reportDao.selectReportList();
	}

	@Override
	public ArrayList<Report> selectReportBoardList() {
		return reportDao.selectReportBoardList();
	}

	@Override
	public int blindReport(ArrayList<Report> r) {
		return reportDao.blindReport(r);
	}
	
	
	

}
