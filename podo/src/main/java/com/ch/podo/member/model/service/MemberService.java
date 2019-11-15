package com.ch.podo.member.model.service;

import com.ch.podo.member.model.vo.Member;

public interface MemberService {

	// 1. 회원 가입 
	int insertMember(Member mem);
	
	// 2. 아이디 중복체크 서비스
	int idCheck(String id);
	// 3. 로그인 
	Member loginMember(Member mem);
	
	// 4. 회원 정보 수정
	int updateMember(Member mem);
	
	// 5. 회원 탈퇴
	int deleteMember(String id);
	
}
