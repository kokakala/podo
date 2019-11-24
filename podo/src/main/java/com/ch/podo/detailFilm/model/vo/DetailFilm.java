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
	
	private int id;						// 영화 상세 정보 번호
	private int filmId;					// 영화 번호
	private String titleKor;			// 영화 한글 제목
	private String titleEng;			// 영화 영어 제목
	private String director;			// 영화 감독
	private String actor;				// 배우
	private String trailer;				// 예고편 링크
	private String synopsys;			// 시놉시스
	private String trivia;				// 트리비아
	private String nickName;			// 기록자 닉네임
}
