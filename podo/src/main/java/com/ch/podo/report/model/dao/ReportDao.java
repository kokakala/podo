package com.ch.podo.report.model.dao;

import java.util.ArrayList;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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
	
	
	public int blindReport(ArrayList<Report> r) {
		/*
		for(int i=0; i<result.length; i++) {
			String item = result[i];
			
			//int targetId = Integer.parseInt(result[0]);
			//int type = Integer.parseInt(result[1]);
			
			//String targetId = result[0];
			//String type = result[1];
			
			sqlSession.update("reportMapper.blindReport", item);
			//sqlSession.update("reportMapper.blindReport", type);
		}
		return 1;
		*/
		
		/*
		HashMap map = new HashMap();
		
		if(btype == 1) {
			map.put("targetId", targetId);
			map.put("btype", btype);
			return sqlSession.update("reportMapper.blindReport1", map);
		}else if(btype == 2) {
			map.put("targetId", targetId);
			map.put("btype", btype);
			return sqlSession.update("reportMapper.blindReport2", map);
		}else if(btype == 3) {
			map.put("targetId", targetId);
			map.put("btype", btype);
			return sqlSession.update("reportMapper.blindReport3", map);
		}else {
			map.put("targetId", targetId);
			map.put("btype", btype);
			return sqlSession.update("reportMapper.blindReport4", map);
		}
		
		*/
		System.out.println(r);
		return sqlSession.update("reportMapper.blindReport", r);
		
		
		
		
		
	}
	

}
