package com.ch.podo.ratingReview.model.vo;

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
public class RatingReview {
	private int id;
	private int ratingSound;
	private int ratingVisual;
	private int ratingActing;
	private int ratingPop;
	private int ratingScript;
	private int ratingDirect;
}
