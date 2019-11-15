package com.ch.podo.review.model.vo;

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
public class Review {
	private int id;
	private String content;
	private int inappropriateCount;
	private int spoilerCount;
	private int likeCout;
	private int spoilerCheck;
	private String status;
	
	
	
	
}
