package com.ch.podo.member.model.vo;

import lombok.AllArgsConstructor;
import lombok.EqualsAndHashCode;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@NoArgsConstructor 
@AllArgsConstructor
@ToString
@EqualsAndHashCode
public class Pay {
	
	private String impUid;
	private String merchantUid;
	private String applyNum;
	private String paidAmount;
	private String memberId;
	
}
