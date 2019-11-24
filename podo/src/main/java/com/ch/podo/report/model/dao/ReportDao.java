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
	
	
	public int getReportListCount() {
		return sqlSession.selectOne("reportMapper.getReportListCount");
	}
	
	public ArrayList<Report> selectReportList(PageInfo pi){

		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		ArrayList<Report> list = (ArrayList)sqlSession.selectList("reportMapper.selectReportList",null, rowBounds);
		
		return list;
	}
	
	
	

}
