package com.ch.podo.member.model.vo;

import java.sql.Date;
import java.util.ArrayList;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor 
@AllArgsConstructor
@ToString
@EqualsAndHashCode
public class Member {


	private String image;		// 프로필 사진 
	private String email;		// 회원 ID
	private String pwd;			// 비밀번호
	private String nickName;	// 회원 닉네임
	private String status;		// 탈퇴 여부 상태값
	private Date enrollDate;	// 회원가입일
	private Date modifyDate;	// 정보 수정일
	private String googleId;	// 구글 API 로그인
	private String kakaoId;		// 카카오 API 로그인

	
}
