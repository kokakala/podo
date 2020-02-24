package com.ch.podo.report.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.podo.report.model.vo.Report;

@SuppressWarnings(value = "unchecked")
@Repository("reportDao")
public class ReportDao {

	@Autowired
	private SqlSessionTemplate sqlSession;

	public ArrayList<Report> selectReportList() {
		return (ArrayList) sqlSession.selectList("reportMapper.selectReportList");
	}

	public ArrayList<Report> selectReportBoardList() {
		return (ArrayList) sqlSession.selectList("reportMapper.selectReportBoardList");
	}

	public int blindReport(ArrayList<Report> r) {

		int type = r.get(0).getType();

		if (type == 1) {
			return sqlSession.update("reportMapper.blindReport1", r);
		} else if (type == 2) {
			return sqlSession.update("reportMapper.blindReport2", r);
		} else if (type == 3) {
			return sqlSession.update("reportMapper.blindReport3", r);
		} else if (type == 4) {
			return sqlSession.update("reportMapper.blindReport4", r);
		}
		return type;

	}

}
