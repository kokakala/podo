package com.ch.podo.member.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.member.model.dao.MemberDao;
import com.ch.podo.member.model.vo.Member;

@Service("memberService")
public class MemberServiceImpl implements MemberService {

	@Autowired
	private MemberDao memberDao;
	
	@Override
	public int insertMember(Member mem) {
		return memberDao.insertMember(mem);
	}

	@Override
	public int idCheck(String id) {
		return memberDao.idCheck(id);
	}
	
	@Override
	public int nickCheck(String nick) {
		return memberDao.nickCheck(nick);
	}
	
	@Override
	public Member selectLoginMember(Member mem) {
		return memberDao.selectLoginMember(mem);
	}

	@Override
	public int updateMember(Member mem) {
		return memberDao.updateMember(mem);
	}

	@Override
	public int deleteMember(String id) {
		// TODO Auto-generated method stub
		return 0;
	}
	
	
	
	@Override
	public ArrayList<Member> selectMemberList() {
		return memberDao.selectMemberList();
	}

	@Override
	public ArrayList<Member> selectBlackList() {
		return memberDao.selectBlackList();
	}


	@Override
	public int deleteBlackMember(int result) {
		return memberDao.deleteBlackMember(result);
	}




}
