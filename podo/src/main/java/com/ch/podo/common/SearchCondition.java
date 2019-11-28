package com.ch.podo.common;

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
public class SearchCondition {
	
	private String releaseYear;
	private String productionCountry;
	private String genreId;
	private String saw;
	private int userId;
	private String order;
	
	private String email;
	private String nickName;
}
