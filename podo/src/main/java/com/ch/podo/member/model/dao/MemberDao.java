package com.ch.podo.member.model.dao;

import java.util.HashMap;

import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.ch.podo.member.model.vo.Member;

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
	
}
