package com.ch.podo.review.model.vo;

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
public class Review {
	
	private int id;
	private String userImage;				// 프로필 이미지
	private String nickname;			// 사용자 닉네임
	private String titleKor;			// 영화 한국 제목 -처란
	private String name;				// 영화 장르 -처란
	private String releaseYear;			// 영화 제작 년도 - 처란
	private String content;				// 영화 리뷰 내용
	private Date modifyDate; 			// 최종 수정일
	private Date createDate; 			// 최초 작성일
	private int inappropriateCount;		
	private int spoilerCount;
	private int likeCount;				// 리뷰 좋아요 갯수
	private String spoilerCheck;
	private String status;
	
}
