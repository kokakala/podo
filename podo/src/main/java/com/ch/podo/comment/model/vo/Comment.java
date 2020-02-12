package com.ch.podo.comment.model.vo;

import java.sql.Date;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@NoArgsConstructor
@AllArgsConstructor
@Getter
@Setter
@ToString
public class Comment {
	private int id;							// 댓글번호
	private int type;						// 댓글 타입
	private int targetId;				// 대상 리뷰 || 게시물
	private int level;				// 계층형 쿼리 깊이
	private String content;			// 내용
	private int inappropriateCount;	// 부적절한내용 신고 개수
	private int spoilerCount;		// 스포일러 신고 개수
	private int likeCount;			// 좋아요 개수
	private Date createDate;		// 최초 작성일
	private Date modifyDate;		// 최종 수정일
	private int memberId;				// 작성자 번호
	private String nickname;		// 작성자 닉네임
	private String memberImage;		// 작성자 프로필 사진
	private String parentId;		// 상위댓글 번호
	private int parentMemberId;	// 상위댓글 작성자 번호
	private String parentMemberNickname;		// 상위댓글 작성자 닉네임
}
