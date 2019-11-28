package com.ch.podo.report.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.report.model.vo.Report;

@Repository("reportDao")
public class ReportDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	

	public ArrayList<Report> selectReportList(){

		ArrayList<Report> list = (ArrayList)sqlSession.selectList("reportMapper.selectReportList");
		
		return list;
	}
	

	public ArrayList<Report> selectReportBoardList(){

		ArrayList<Report> list = (ArrayList)sqlSession.selectList("reportMapper.selectReportBoardList");
		
		return list;
	}
	

}
