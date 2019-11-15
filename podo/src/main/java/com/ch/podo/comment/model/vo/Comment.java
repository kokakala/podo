package com.ch.podo.comment.model.vo;

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
public class Comment {
	
	private int id;					// 댓글번호
	private int type;				// 댓글 타입
	private String content;			// 내용
	private int inappropriateCount;	// 부적절한내용 신고 개수
	private int spoilerCount;		// 스포일러 신고 개수
	private int likeCount;			// 좋아용 개수
	private Date createDate;		// 최초 작성일
	private Date modifyDate;		// 최초 수정일
	private String status;			// 상태
	private int level;				// 댓글층
	
	
	
}
