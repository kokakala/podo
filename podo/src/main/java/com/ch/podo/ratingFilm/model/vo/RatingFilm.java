package com.ch.podo.ratingFilm.model.vo;

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
public class RatingFilm {
	private int id;		//영화 평가번호
	private int star;	//영화 별점
	private String saw;	//본영화 / 안본영화
}
