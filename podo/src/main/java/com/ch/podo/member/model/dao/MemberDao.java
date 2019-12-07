package com.ch.podo.member.model.dao;

import java.util.ArrayList;

import org.apache.ibatis.session.RowBounds;
import java.util.HashMap;
import java.util.Map;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.podo.member.model.vo.Member;
import com.ch.podo.member.model.vo.Pay;
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
	
	public Member selectUserPageMem(String userId) {
		return sqlSession.selectOne("memberMapper.selectUserPageMem", userId);
	}
	

	public ArrayList<Member> selectMemberList() {
		return (ArrayList)sqlSession.selectList("memberMapper.selectMemberList");
	}
	
	public ArrayList<Member> selectBlackList() {
		return (ArrayList)sqlSession.selectList("memberMapper.selectBlackList");
	}
	
	
	public int deleteBlackMember(String[] result) {
		for(int i=0; i<result.length; i++) {
			String item = result[i];
			sqlSession.insert("memberMapper.deleteBlackMember", item);
		}
		return 1;
	}

	public int prohibitionBoard(int bid) {
		return sqlSession.selectOne("memberMapper.prohibitionBoard", bid);
	}
	

	public int insertPaymentInfo(Pay pay) {
		return sqlSession.insert("memberMapper.insertPaymentInfo", pay);
	}

	public int updatePremiumInfo(String memberId) {
		return sqlSession.update("memberMapper.updatePremiumInfo", memberId);
	}
	
	public int insertBlackList(String[] result) {
		
		for(int i=0; i<result.length; i++) {
			String item = result[i];
			sqlSession.insert("memberMapper.insertBlackList", item);
		}
		return 1;
	}
	
	public int deleteReport(String[] result) {
		
		for(int i=0; i<result.length; i++) {
			String item = result[i];
			sqlSession.insert("memberMapper.deleteReport", item);
		}
		return 1;
	}
	
	public int exit(String id) {
		return sqlSession.update("memberMapper.exit", id);
	}
}
