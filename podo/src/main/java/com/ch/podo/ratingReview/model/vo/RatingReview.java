package com.ch.podo.ratingReview.model.vo;

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
public class RatingReview {
	private int id;
	private int ratingSound;		//음악
	private int ratingVisual;		//영상
	private int ratingActing;		//연기
	private int ratingPop;			//대중성
	private int ratingScript;		//각본
	private int ratingDirect;		//연출
	private String titleKor;		//영화 한국이름
	private String nickName;		//유저 닉네임
	private String content;			//내용
	private Date modifyDate; 		//수정한 날짜
	private Date createDate; 		//생성한 날짜
	private String userImage;		//유저 이미지
	private String posterImage;		//영화 포스터 이미지
	private int star;				// 영화 별점

}
