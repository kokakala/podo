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

}