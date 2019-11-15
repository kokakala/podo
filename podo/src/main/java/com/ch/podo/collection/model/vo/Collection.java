package com.ch.podo.collection.model.vo;

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
public class Collection {
	
	private int id;				// 컬렉션 아이디
	private String title;		// 제목
	private String content;		// 내용
	private int likeCount;		// 좋아요 갯수
	private int spoilerCount;	// 스포일러 갯수
	private Date createDate;	// 최초작성일
	private Date modifyDate;	// 최종수정일
	private String status;		// 상태
	private String open;		// 공개여부
	
}
