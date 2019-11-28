package com.ch.podo.detailFilm.model.vo;

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

public class Actor {
	
	private int id;					// 배우번호
	private String actorName;		// 배우 이름
	private String profileImage;	// 배우 사진
	
}
