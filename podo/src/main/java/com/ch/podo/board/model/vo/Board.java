package com.ch.podo.board.model.vo;

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
public class Board {
   
   private int id;
   private String title;
   private String content;
   private int viewCount;
   private int inappropriateCount;
   private int spoilerCount;
   private int likeCount;
   private Date modifyDate;
   private Date createDate;
   private String status;
   private int memberId;
   private int imageId;
   
   

}