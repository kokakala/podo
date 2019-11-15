package com.ch.podo.report.model.vo;

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
public class Report {
   
   private int id;         // 신고번호
   private int type;      // 타입
   private int targetId;   // 대상번호
   private int content;   // 신고내용
   private int reportId;   // 신고자번호
   private int reportedId;   // 신고대상자번호
   

}