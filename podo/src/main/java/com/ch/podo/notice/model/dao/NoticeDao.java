package com.ch.podo.notice.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.notice.model.vo.Notice;

@Repository("noticeDao")
public class NoticeDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	
	public int getNoticeCount() {
		return sqlSession.selectOne("noticeMapper.getNoticeCount");
	}
	
	public Notice selectNoticeList(){
		
		return sqlSession.selectOne("noticeMapper.selectNoticeList");
		
	}
	
	
	public int insertNotice(Notice n) {
		return sqlSession.insert("noticeMapper.insertNotice", n);
	}
	
	
	public int updateCount(int id) {
		return sqlSession.update("noticeMapper.updateCount", id);
	}
	
	
	public Notice selectNotice(int id) {
		return sqlSession.selectOne("noticeMapper.selectNotice", id);
	}
	
	
	public int deleteNotice(int id) {
		return sqlSession.update("noticeMapper.deleteNotice", id);
	}
	
	
	public int updateNotice(Notice n) {
		return sqlSession.update("noticeMapper.updateNotice", n);
	}

}
