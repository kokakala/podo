package com.ch.podo.member.model.vo;

import java.sql.Date;
import java.util.ArrayList;

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
public class Member {

	private int id;
	private String image;
	private String email;
	private String pwd;
	private String nickName;
	private String status;
	private Date enrollDate;
	private Date modifyDate;
	private String googleId;
	private String kakaoId;
	private String autho;
	private ArrayList<Integer> genre;
	
}
