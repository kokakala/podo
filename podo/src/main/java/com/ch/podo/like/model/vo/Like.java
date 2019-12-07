package com.ch.podo.like.model.vo;

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
public class Like {
   
   private int id;         // 좋아요 번호
   private int type;      // 타입 1=영화, 2=사용자, 3=리뷰, 4=컬렉션
   private int targetId;   // 대상번호
   private int userId;      // 회원번호
   private String titleKor;	// 영화제목
   private String titleEng; // 영화제목(영문)
   private String changeName;	// 영화 포스터, 멤버 프로필
   private String content;		// 리뷰내용
   private String nickName;		// 회원 닉네임
   private String rrId;			// 레이팅리뷰번호
   private int film_id; // 영화 번호
}