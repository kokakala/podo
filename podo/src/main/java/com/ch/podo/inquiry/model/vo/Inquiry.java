package com.ch.podo.inquiry.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Setter
@Getter
@ToString
public class Inquiry {
	
	private int id;			  	// 문의번호
	private int type;		  	// 타입(신고 종류)	// 1= 마이페이지 문의 , 2= DB제보
	private String content;	  	// 문의 내용
	private Date createDate;	// 최초 작성일
	private String status;	  	// 상태
	private int userId;		// 사용자(문의자)아이디
	private String answer;	 	// 문의 답변
	private Date answerDate;	// 답변 작성일
	private int adminId;		// 관리자 아이디

}
