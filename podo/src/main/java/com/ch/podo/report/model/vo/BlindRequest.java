package com.ch.podo.report.model.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BlindRequest { // 블라인드 처리 하기 위한 요청 객체를 담는 용도로 따로 빼줌
	private String[] blinds;
}