package com.ch.podo.member.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.podo.member.model.vo.Member;
import com.ch.podo.board.model.vo.PageInfo;

@Repository("memberDao")
public class MemberDao {
	
	@Autowired
	private SqlSessionTemplate sqlSession;
	

	public int insertMember(Member mem) {
		return sqlSession.insert("memberMapper.insertMember", mem);
	}
	
	public int idCheck(String id) {
		return sqlSession.selectOne("memberMapper.idCheck", id);
	}
	
	public int nickCheck(String nick) {
		return sqlSession.selectOne("memberMapper.nickCheck", nick);
	}
	
	public Member selectLoginMember(Member mem) {
		return sqlSession.selectOne("memberMapper.selectLoginMember", mem);
	}
	
	public int updateMember(Member mem) {
		return sqlSession.update("memberMapper.updateMember", mem);
	}
	
	
	
	
	public int getMemberListCount() {
		return sqlSession.selectOne("memberMapper.getMemberListCount");
	}
	
	public ArrayList<Member> selectMemberList(PageInfo pi){
		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		ArrayList<Member> list = (ArrayList)sqlSession.selectList("memberMapper.selectMemberList",null, rowBounds);
		
		return list;
	}
	
	
	public int getBlackListCount() {
		return sqlSession.selectOne("memberMapper.getBlackListCount");
	}
	
	public ArrayList<Member> selectBlackList(PageInfo pi){

		int offset = (pi.getCurrentPage() - 1) * pi.getBoardLimit();
		RowBounds rowBounds = new RowBounds(offset, pi.getBoardLimit());

		ArrayList<Member> list = (ArrayList)sqlSession.selectList("memberMapper.selectBlackList",null, rowBounds);
		
		return list;
	}
	
	
}
