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

public class DetailFilm {
	
	private int id;				// 영화 상세정보 번호
	private String synobsys;	// 시놉시스
	private String trivia;		// 트리비아
	private String trailer;		// 예고편 링크
	private String footage;		// 스틸 영상
	private String status;		// 영화 정보상태
	
}
