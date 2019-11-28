package com.ch.podo.member.model.service;

import java.util.ArrayList;

import com.ch.podo.board.model.vo.PageInfo;
import com.ch.podo.member.model.vo.Member;

public interface MemberService {

	// 1_1. 회원 가입 
	int insertMember(Member mem);
	
	// 1_2. 아이디 중복체크 서비스
	int idCheck(String id);
	
	// 1_3. 닉네임 중복체크 서비스
	int nickCheck(String nick);
	
	// 3. 로그인 서비스
	Member selectLoginMember(Member mem);
	
	// 4. 회원 정보 수정
	int updateMember(Member mem);
	
	// 5. 회원 탈퇴
	int deleteMember(String id);
	
	
	
	
	// 관리자
	
	// 1. 현재 페이지에 보여질 회원 리스트 조회용 서비스
	ArrayList<Member> selectMemberList();
	
	// 2. 현재 페이지에 보여질 블랙 회원 리스트 조회용 서비스
	ArrayList<Member> selectBlackList();

	
	// 3. 블랙리스트 해제
	int deleteBlackMember(int result);
	
	
	
}
