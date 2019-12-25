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
	private int id;							// 댓글번호
	private int type;						// 댓글 타입
	private int targetId;				// 대상 리뷰 || 게시물
	private String content;			// 내용
	private int inappropriateCount;	// 부적절한내용 신고 개수
	private int spoilerCount;		// 스포일러 신고 개수
	private int likeCount;			// 좋아요 개수
	private Date createDate;		// 최초 작성일
	private Date modifyDate;		// 최종 수정일
	private String status;			// 상태
	private int memberId;				// 작성자 번호
	private String nickName;		// 작성자 닉네임
	private int level;					// 계층형 쿼리 깊이
}
