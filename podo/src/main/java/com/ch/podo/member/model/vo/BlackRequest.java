package com.ch.podo.member.model.vo;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter
@Setter
@ToString
public class BlackRequest { // 언블럭을 하기 위한 요청 객체를 담는 용도로 따로 빼줌
	private String[] blackUsers;
}
