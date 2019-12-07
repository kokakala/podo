package com.ch.podo.member.model.service;

import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.member.model.dao.MemberDao;
import com.ch.podo.member.model.vo.Member;
import com.ch.podo.member.model.vo.Pay;

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
	public int exit(String id) {
		return memberDao.exit(id);
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
	public int deleteBlackMember(String[] result) {
		return memberDao.deleteBlackMember(result);
	}


	@Override
	public int prohibitionBoard(int bid) {
		return memberDao.prohibitionBoard(bid);
	}
	
	@Override
	public int insertBlackList(String[] result) {
		
		int result1 = memberDao.insertBlackList(result);
		int result2 = memberDao.deleteReport(result);
		
		if(result1 > 0 && result2 > 0) {
			return 1;
		}
		return 0;
		
	}
	


	@Override
	public Member selectUserPageMem(String userId) {
		return memberDao.selectUserPageMem(userId);
	}

	@Override
	public int insertPaymentInfo(Pay pay) {
		int result1 = memberDao.insertPaymentInfo(pay);
		int result2 = memberDao.updatePremiumInfo(pay.getMemberId());
		if (result1 > 0 && result2 > 0) {
			return 1;
		} else {
			return 0;
		}
		
	}

}
